import 'dart:async';
import 'dart:convert';

import 'package:audiobuy/Helpers/storage.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_api.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreProductController extends GetxController {
  RxString storeid = ''.obs;
  RxString storeimage = ''.obs;
  RxString storename = ''.obs;
  RxString storeaddress = ''.obs;
  RxString storecontanctno = ''.obs;
  TextEditingController searchTextField = TextEditingController();

  @override
  void onInit() async {
    storeid.value = await Get.arguments['storeid'];
    get_store_Details(storeid: storeid.value);
    super.onInit();
  }

  Products? selectedProduct;

  RxBool isGettingStoreDetails = true.obs;

  RxList<StoreDetails> storeDetails = <StoreDetails>[].obs;

  RxList<Products> storeProducts = <Products>[].obs;
  RxList<Products> storeProducts_MasterList = <Products>[].obs;
  RxList<CartModel> cartList = <CartModel>[].obs;

  RxBool isPlacingOrder = false.obs;

  get_store_Details({required String storeid}) async {
    var result = await StoreProductApi.getStoreDetails(storeid: storeid);
    storeDetails.assignAll(result);
    storeimage.value = storeDetails[0].image;
    storename.value = storeDetails[0].name;
    storeaddress.value = storeDetails[0].address;
    storecontanctno.value = storeDetails[0].contactno;
    isGettingStoreDetails.value = false;
    get_products_of_store(storeid: storeid);
  }

  get_products_of_store({required String storeid}) async {
    var result = await StoreProductApi.getProducts(storeid: storeid);
    storeProducts.assignAll(result);
    storeProducts_MasterList.assignAll(result);
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

  place_order({required BuildContext context}) async {
    isPlacingOrder(true);
    DateTime dateandtime = new DateTime.now();
    var customerid = Get.find<StorageService>().box.read('userid');
    var ordernumber = await StoreProductApi.create_order(
        storeid: storeid.value,
        contactno: Get.find<StorageService>().box.read('contactno'),
        customerid: customerid.toString(),
        datetime: dateandtime.toString());

    print(ordernumber);
    insert_all_purchased_products(ordernumber: ordernumber, context: context);
  }

  insert_all_purchased_products(
      {required String ordernumber, required BuildContext context}) async {
    for (var i = 0; i < cartList.length; i++) {
      await StoreProductApi.insert_ordered_products(
          productImage: cartList[i].productImage,
          productStoreID: cartList[i].productStoreId,
          productDescription: cartList[i].productDescription,
          productPrice: cartList[i].productPrice,
          productName: cartList[i].productName,
          productID: cartList[i].productId,
          productQuantity: cartList[i].productQuantity.toString(),
          ordernumber: ordernumber);
    }
    Timer(Duration(seconds: 3), () {
      isPlacingOrder(false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Order Succesful!')));
    });
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
}
