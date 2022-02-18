import 'dart:async';
import 'dart:io';

import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Helpers/storage.dart';
import 'package:audiobuy/Modules/Login/Login_model.dart';
import 'package:audiobuy/Modules/Login/Login_view.dart';
import 'package:audiobuy/Modules/Storepage/Storepage_api.dart';
import 'package:audiobuy/Modules/Storepage/Storepage_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StorepageController extends GetxController {
  RxList<Products> productList = <Products>[].obs;
  TextEditingController productname = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productDescription = TextEditingController();

  TextEditingController storename = TextEditingController();
  TextEditingController storeaddress = TextEditingController();
  TextEditingController storepassword = TextEditingController();
  TextEditingController storeusername = TextEditingController();
  TextEditingController storecontact = TextEditingController();

  File? productimage;
  RxString productFilename = 'no-image.jpg'.obs;
  File? profileimage;
  RxString profileFileImage = 'no-image.jpg'.obs;
  RxList<Users> usersList = <Users>[].obs;
  RxBool isGettingStoreDetails = true.obs;

  RxList<OrdersForApproval> orderForApprovalList = <OrdersForApproval>[].obs;
  RxList<OrdersForApprovalDetails> orderForApprovalOrderDetails =
      <OrdersForApprovalDetails>[].obs;

  RxString nameofstore = ''.obs;
  RxString addressofstore = ''.obs;
  RxString usernameofstore = ''.obs;
  RxString passwordofstore = ''.obs;
  RxString imageofstore = ''.obs;
  RxString contanctofstore = ''.obs;

  RxBool hasApprovedOrder = false.obs;
  RxInt pendingCount = 0.obs;

  Timer? streamforApprovedOrders;

  @override
  void onInit() {
    get_products();
    setData();
    stream_approved_orders();
    super.onInit();
  }

  get_products() async {
    var result = await StoreApi.getProducts(
        storeid: Get.find<StorageService>().box.read('userid'));
    productList(result);
  }

  setData() {
    imageofstore.value = Get.find<StorageService>().box.read('image');
    nameofstore.value = Get.find<StorageService>().box.read('name');
    addressofstore.value = Get.find<StorageService>().box.read('address');
    usernameofstore.value = Get.find<StorageService>().box.read('username');
    passwordofstore.value = Get.find<StorageService>().box.read('password');
    contanctofstore.value = Get.find<StorageService>().box.read('contactno');
  }

  getimage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (result != null) {
      productimage = File(result.files.single.path!);
      productFilename.value = productimage!.path.split('/').last;
      print(productFilename.value);
    } else {
      // User canceled the picker
    }
  }

  getimage_update_profile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (result != null) {
      profileimage = File(result.files.single.path!);
      profileFileImage.value = profileimage!.path.split('/').last;
      print(profileFileImage.value);
    } else {
      // User canceled the picker
    }
  }

  check_if_productExist({required BuildContext context}) async {
    var result = await StoreApi.checkProduct(productname: productname.text);
    if (result == "Valid") {
      ceate_prodducts(context: context);
    } else if (result == "Invalid") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Product Already Exist!')));
    } else if (result == "Error") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error contact developer!')));
    } else {}
  }

  check_if_account_exist(
      {required BuildContext context,
      required String originalimagefilename}) async {
    var result = await StoreApi.checkAccount(
        username: storeusername.text,
        password: storepassword.text,
        id: Get.find<StorageService>().box.read('userid'));
    if (result == "Valid") {
      update_Account(
          context: context,
          storeid: Get.find<StorageService>().box.read('userid'),
          originalfilename: originalimagefilename);
    } else if (result == "Invalid") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Account Already Exist!')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error Contanct Developer!')));
    }
  }

  ceate_prodducts({required BuildContext context}) async {
    var result = await StoreApi.create_products(
        productname: productname.text,
        productPrice: productPrice.text,
        ProductDescription: productDescription.text,
        productStoreID: Get.find<StorageService>().box.read('userid'),
        productImage: productFilename.value,
        imageFile: productimage);
    print(result);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Product Created!')));
    get_products();
  }

  delete({required String productid}) async {
    var result = await StoreApi.delete_items(productid: productid);
    print(result);
    get_products();
  }

  update_product(
      {required String productID,
      required BuildContext context,
      required String originalfilename}) async {
    var result = await StoreApi.update_product(
        productname: productname.text,
        productPrice: productPrice.text,
        productDescription: productDescription.text,
        productImage: productFilename.value,
        imageFile: productimage,
        productid: productID);
    print(result);
    if (originalfilename != productFilename.value) {
      await StoreApi.insertimage(
          path: productimage!.path,
          imagename: productFilename.value,
          imagefile: productimage!);
    }
    get_products();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Product Updated!')));
  }

  update_Account(
      {required BuildContext context,
      required String storeid,
      required String originalfilename}) async {
    var result = await StoreApi.update_Account(
        storename: storename.text,
        storeaddress: storeaddress.text,
        storeusername: storeusername.text,
        storepassword: storepassword.text,
        storeid: storeid,
        storecontactno: storecontact.text,
        storeimage: profileFileImage.value);
    print(result);
    if (originalfilename != profileFileImage.value) {
      await StoreApi.insertimage(
          path: profileimage!.path,
          imagename: profileFileImage.value,
          imagefile: profileimage!);
    }
    var res = await StoreApi.getuser(
        username: storeusername.text, password: storepassword.text);
    usersList.clear();
    usersList.assignAll(res);
    if (usersList.length != 0) {
      await Get.find<StorageService>().setUser(
          userid: usersList[0].userid,
          username: usersList[0].user,
          password: usersList[0].pass,
          name: usersList[0].name,
          contactno: usersList[0].contactno,
          image: usersList[0].image,
          address: usersList[0].address,
          usertype: usersList[0].usertype);
    }
    setData();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Account Updated!')));
  }

  get_orders_of_Stores() async {
    var result = await StoreApi.get_store_orders();
    orderForApprovalList.assignAll(result);
  }

  get_order_details({required String transactionID}) async {
    var result = await StoreApi.get_order_for_approval_Details(
        ordernumber: transactionID);
    orderForApprovalOrderDetails.assignAll(result);
  }

  approved_or_cancel(
      {required String transactionID,
      required BuildContext context,
      required String status}) async {
    var result = await StoreApi.update_order_Status(
        ordernumber: transactionID, status: status);
    if (result == true) {
      get_orders_of_Stores();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Order $status!')));
    }
  }

  count_approved_order() async {
    var result = await StoreApi.count_approved_orders(status: "Pending");
    print("order pending count : $result");
    if (result == 0) {
      hasApprovedOrder(false);
      pendingCount(result);
    } else {
      hasApprovedOrder(true);
      pendingCount(result);
    }
  }

  stream_approved_orders() {
    streamforApprovedOrders = Timer.periodic(Duration(seconds: 10), (timer) {
      count_approved_order();
    });
  }

  @override
  void onClose() {
    streamforApprovedOrders!.cancel();
    super.onClose();
  }

  logout({required BuildContext context}) {
    Sizer sizer = Sizer();
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        content: Container(
            height: sizer.height(height: 20, context: context),
            width: sizer.width(width: 20, context: context),
            color: Colors.transparent,
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    height: sizer.height(height: 10, context: context),
                    width: sizer.width(width: 100, context: context),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      child: Text(
                        "Logout?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: sizer.width(width: 30, context: context),
                      height: sizer.height(height: 8, context: context),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        // color: Color(0xff01A0C7),
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Colors.white,
                                  Colors.white,
                                  Colors.white,
                                  Colors.white
                                ]),
                          ),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("No ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                        fontSize: sizer.font(
                                            fontsize: 10, context: context))
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: sizer.width(width: 30, context: context),
                      height: sizer.height(height: 8, context: context),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        // color: Color(0xff01A0C7),
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Colors.white,
                                  Colors.white,
                                  Colors.white,
                                  Colors.white
                                ]),
                          ),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              Get.find<StorageService>().removedUser();
                              Get.offAll(() => LoginView());
                            },
                            child: Text("Yes ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                        fontSize: sizer.font(
                                            fontsize: 10, context: context))
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
      barrierDismissible: false,
    );
  }
}
