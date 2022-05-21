import 'dart:async';
import 'dart:convert';

import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Helpers/storage.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_api.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_model.dart';
import 'package:audiobuy/Modules/SuccessfulAndUnsuccesfulOrder/UnsuccessfulAndSuccess_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreProductController extends GetxController {
  RxString storeid = ''.obs;
  RxString storeimage = ''.obs;
  RxString storename = ''.obs;
  RxString storeaddress = ''.obs;
  RxString storecontanctno = ''.obs;
  TextEditingController searchTextField = TextEditingController();
  TextEditingController chatTextField = TextEditingController();
  RxBool isCheckedCOD = true.obs;
  RxBool isCheckedPickUp = false.obs;
  RxBool hasUnvailableItem = false.obs;
  RxBool isRegisteredProductDetails = false.obs;
  @override
  void onInit() async {
    storeid.value = await Get.arguments['storeid'];
    await get_store_Details(storeid: storeid.value);
    await start_stream_chat();
    searched_product.value = await Get.arguments['searched_product'];
    if (searched_product.value != '/%no-product%/') {
      searchTextField.text = searched_product.value;
      searchProduct(stringtosearch: searched_product.value);
    }

    super.onInit();
  }

  Timer? chattimer;

  Products? selectedProduct;

  RxBool isGettingStoreDetails = true.obs;
  RxBool isGettingStoreProducts = true.obs;
  RxBool hasMessageNotSeen = false.obs;
  RxList<NotAvailableItemListModel> notAvailableItemsList =
      <NotAvailableItemListModel>[].obs;
  RxList<NotAvailableItemListModel> successfulOrdereditemList =
      <NotAvailableItemListModel>[].obs;

  RxList<StoreDetails> storeDetails = <StoreDetails>[].obs;

  RxList<Products> storeProducts = <Products>[].obs;
  RxList<Products> storeProducts_MasterList = <Products>[].obs;
  RxList<CartModel> cartList = <CartModel>[].obs;
  RxList<ChatModel> chats = <ChatModel>[].obs;
  // ScrollController scroll_controller = ScrollController();
  RxString searched_product = ''.obs;

  RxBool isPlacingOrder = false.obs;

  get_store_Details({required String storeid}) async {
    var result = await StoreProductApi.getStoreDetails(storeid: storeid);
    storeDetails.assignAll(result);
    storeimage.value = storeDetails[0].image;
    storename.value = storeDetails[0].name;
    storeaddress.value = storeDetails[0].address;
    storecontanctno.value = storeDetails[0].contactno;
    isGettingStoreDetails.value = false;
    await get_products_of_store(storeid: storeid);
  }

  get_products_of_store({required String storeid}) async {
    var result = await StoreProductApi.getProducts(storeid: storeid);
    storeProducts.assignAll(result);
    storeProducts_MasterList.assignAll(result);
    isGettingStoreProducts(false);
  }

  searchProduct({required String stringtosearch}) {
    storeProducts.assignAll(storeProducts_MasterList
        .where((u) => (u.productName
                .toString()
                .toLowerCase()
                .contains(stringtosearch.toLowerCase()) ||
            u.productPrice
                .toString()
                .toLowerCase()
                .contains(stringtosearch.toLowerCase())))
        .toList());
  }

  RxString count_product() {
    var total = 0;
    for (var i = 0; i < storeProducts.length; i++) {
      total = total + storeProducts[i].productQuantity.value;
    }

    return total.toString().obs;
  }

  add_to_Cart() {
    var list = [];
    for (var i = 0; i < storeProducts.length; i++) {
      if (storeProducts[i].productQuantity.value != 0) {
        Map map = {
          "productId": storeProducts[i].productId,
          "productName": storeProducts[i].productName,
          "productPrice": storeProducts[i].productPrice,
          "productDescription": storeProducts[i].productDescription,
          "productStoreId": storeProducts[i].productStoreId,
          "productImage": storeProducts[i].productImage,
          "productQuantity": storeProducts[i].productQuantity.value
        };
        list.add(map);
      }
    }

    var result = cartModelFromJson(jsonEncode(list));
    cartList.assignAll(result);
  }

  place_order({required BuildContext context, required Sizer sizer}) async {
    notAvailableItemsList.clear();
    successfulOrdereditemList.clear();
    hasUnvailableItem(false);
    isPlacingOrder(true);
    String isDelivery = '';
    if (isCheckedCOD.value == true) {
      isDelivery = true.toString();
    } else {
      isDelivery = false.toString();
    }
    DateTime dateandtime = new DateTime.now();
    var customerid = Get.find<StorageService>().box.read('userid');
    var ordernumber = await StoreProductApi.create_order(
        isDelivery: isDelivery,
        storeid: storeid.value,
        contactno: Get.find<StorageService>().box.read('contactno'),
        customerid: customerid.toString(),
        datetime: dateandtime.toString());

    print(ordernumber);
    insert_all_purchased_products(
        ordernumber: ordernumber, context: context, sizer: sizer);
  }

  insert_all_purchased_products(
      {required String ordernumber,
      required BuildContext context,
      required Sizer sizer}) async {
    String isDelivery = '';
    if (isCheckedCOD.value == true) {
      isDelivery = true.toString();
    } else {
      isDelivery = false.toString();
    }
    for (var i = 0; i < cartList.length; i++) {
      await StoreProductApi.insert_ordered_products(
          productImage: cartList[i].productImage,
          productStoreID: cartList[i].productStoreId,
          productDescription: cartList[i].productDescription,
          productPrice: cartList[i].productPrice,
          productName: cartList[i].productName,
          productID: cartList[i].productId,
          productQuantity: cartList[i].productQuantity.toString(),
          isDelivery: isDelivery,
          ordernumber: ordernumber);
    }

    isPlacingOrder(false);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Order Succesful!')));
    if (hasUnvailableItem.value == true) {
      // showCustomerMessage_Unvailable_Items(sizer: sizer, context: context);
      Get.to(() => UnsuccessfulAndSuccessfulView());
    } else {
      if (isRegisteredProductDetails.value == true) {
        Get.back();
        Get.back();
      } else {
        Get.back();
      }
    }
    if (successfulOrdereditemList.isEmpty) {
      await StoreProductApi.delete_ordernumber(ordernumber: ordernumber);
    } else {}
    await get_products_of_store(storeid: storeid.value);
    hasUnvailableItem(false);
  }

  RxDouble count_checkout_total() {
    var total = 0.0;
    for (var i = 0; i < cartList.length; i++) {
      total = total +
          (cartList[i].productQuantity *
              double.parse(cartList[i].productPrice));
    }
    return total.obs;
  }

  sendMessage() async {
    var message = chatTextField.text.toString();
    chatTextField.clear();
    var result = await StoreProductApi.send_chat(
        storeid: storeid.value,
        customerid: Get.find<StorageService>().box.read('userid').toString(),
        message: message.toString());
    print(result);
    chatTextField.clear();
    update_seen_status();
  }

  getChat() async {
    var result = await StoreProductApi.get_all_Chats(
      storeid: storeid.value,
      customerid: Get.find<StorageService>().box.read('userid').toString(),
    );
    chats.assignAll(result);
    var counts = 0;
    for (var i = 0; i < chats.length; i++) {
      if (chats[i].receiver ==
          Get.find<StorageService>().box.read('userid').toString()) {
        if (chats[i].seen.toString() == "1") {
          counts++;
        } else {}
      }
    }
    if (counts > 0) {
      hasMessageNotSeen.value = true;
    } else {
      hasMessageNotSeen.value = false;
    }
    // print(result);
  }

  start_stream_chat() {
    print("timer start");
    chattimer = Timer.periodic(Duration(seconds: 5), (timer) {
      getChat();
    });
  }

  update_seen_status() async {
    var result = await StoreProductApi.update_seen_Status(
      storeid: storeid.value,
      customerid: Get.find<StorageService>().box.read('userid').toString(),
    );
    print(result);
  }

  get_searched_products() {
    var productname = 'YAMAHA CLASSICAL GUITAR';
    var indexes = 0;
    for (var i = 0; i < storeProducts.length; i++) {
      if (storeProducts[i].productName.toLowerCase().toString() ==
          productname.toLowerCase().toString()) {
        indexes = i;
      }
    }
    print(indexes);
    // scroll_controller.jumpTo(double.parse(indexes.toString()));
  }

  // delete_Chats() async {
  //   var result = await StoreProductApi.delete_chats(
  //     storeid: storeid.value,
  //     customerid: Get.find<StorageService>().box.read('userid').toString(),
  //   );
  //   print(result);
  // }

  getback() {
    isRegisteredProductDetails.value = false;
    Get.back();
  }

  stopStream() {
    chattimer!.cancel();
    // delete_Chats();
    Get.back();
    print("timer stop");
  }

  showCustomerMessage_Unvailable_Items(
      {required Sizer sizer, required BuildContext context}) {
    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => successfulOrdereditemList.isEmpty
                  ? SizedBox(
                      height: sizer.height(height: 1, context: context),
                    )
                  : Container(
                      constraints: BoxConstraints(
                        minHeight: sizer.height(height: 10, context: context),
                        maxHeight: sizer.height(height: 30, context: context),
                      ),
                      width: sizer.width(width: 70, context: context),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: sizer.width(width: 70, context: context),
                            child: Text(
                              "Successful Ordered Items",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: sizer.height(height: 2, context: context),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.topLeft,
                              width: sizer.width(width: 70, context: context),
                              child: Obx(
                                () => ListView.builder(
                                  // shrinkWrap: true,
                                  itemCount: successfulOrdereditemList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: sizer.height(
                                              height: 1, context: context)),
                                      child: Container(
                                        child: Text(
                                          "● " +
                                              successfulOrdereditemList[index]
                                                  .productName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            SizedBox(
              height: sizer.height(height: 1, context: context),
            ),
            Obx(
              () => notAvailableItemsList.isEmpty
                  ? SizedBox(
                      height: sizer.height(height: 1, context: context),
                    )
                  : Container(
                      constraints: BoxConstraints(
                        minHeight: sizer.height(height: 10, context: context),
                        maxHeight: sizer.height(height: 30, context: context),
                      ),
                      width: sizer.width(width: 70, context: context),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: sizer.width(width: 70, context: context),
                            child: Text(
                              "Unsuccessful Ordered Items",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: sizer.width(width: 70, context: context),
                            child: Text(
                              "Reason: Out of stocks.",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: sizer.height(height: 2, context: context),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.topLeft,
                              width: sizer.width(width: 70, context: context),
                              child: Obx(
                                () => ListView.builder(
                                  // shrinkWrap: true,
                                  itemCount: notAvailableItemsList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: sizer.height(
                                              height: 1, context: context)),
                                      child: Container(
                                        child: Text(
                                          "● " +
                                              notAvailableItemsList[index]
                                                  .productName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
