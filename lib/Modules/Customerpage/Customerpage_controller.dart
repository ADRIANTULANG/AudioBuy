import 'dart:async';
import 'dart:io';

import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Helpers/storage.dart';
import 'package:audiobuy/Modules/Customerpage/Customerpage_api.dart';
import 'package:audiobuy/Modules/Customerpage/Customerpage_model.dart';
import 'package:audiobuy/Modules/Login/Login_model.dart';
import 'package:audiobuy/Modules/Login/Login_view.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    getCountStoreOrServices(usertype: "store");
    getStoresOrServices(usertype: "store");
    setData();
    stream_approved_orders();
    super.onInit();
  }

  RxBool dontShowPassword = true.obs;
  RxBool isUpdating = false.obs;
  RxBool viewStorePage = true.obs;

  RxBool hasApprovedOrder = false.obs;
  RxBool hasApprovedServices = false.obs;

  RxList<Stores> storeList = <Stores>[].obs;
  RxList<Stores> storeListMasterList = <Stores>[].obs;

  TextEditingController customernametext = TextEditingController();
  TextEditingController customerusernametext = TextEditingController();
  TextEditingController customerpasswordtext = TextEditingController();
  TextEditingController customercontactno = TextEditingController();
  TextEditingController customeraddress = TextEditingController();

  RxString customerFileImageName = 'no-image.jpg'.obs;
  File? customerFile;

  RxString storecounts = ''.obs;
  RxBool isInfiniteScroll = true.obs;

  Timer? streamforApprovedOrders;
  Timer? debounce;

  RxList<Users> usersList = <Users>[].obs;
  RxString name = ''.obs;
  RxString contact = ''.obs;
  RxString address = ''.obs;
  RxString image = ''.obs;

  RxList<TrackOrder> trackOrderList = <TrackOrder>[].obs;
  RxList<TrackOrder> historyList = <TrackOrder>[].obs;

  List<RentalHistorModel> rentalHistory = <RentalHistorModel>[].obs;
  List<RentalHistorModel> trackRental = <RentalHistorModel>[].obs;

  List<OrderHistoryDetails> orderhsitoryDetails = <OrderHistoryDetails>[].obs;

  setData() {
    name.value = Get.find<StorageService>().box.read('name');
    contact.value = Get.find<StorageService>().box.read('contactno');
    address.value = Get.find<StorageService>().box.read('address');
    image.value = Get.find<StorageService>().box.read('image');
  }

  getimage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (result != null) {
      customerFile = File(result.files.single.path!);
      customerFileImageName.value = customerFile!.path.split('/').last;
      print(customerFileImageName.value);
    } else {
      // User canceled the picker
    }
  }

  getCountStoreOrServices({required String usertype}) async {
    var result = await HomepageApi.getCountStores(usertype: usertype);
    storecounts.value = result;
  }

  getStoresOrServices({required String usertype}) async {
    var result = await HomepageApi.getStores(usertype: usertype);
    storeList.assignAll(result);
    storeListMasterList.assignAll(result);
  }

  searchFunctionNew({required String stringtosearch}) {
    isInfiniteScroll.value = false;
    storeList.clear();
    storeList.addAll(storeListMasterList
        .where((u) => (u.name
                .toString()
                .toLowerCase()
                .contains(stringtosearch.toLowerCase()) ||
            u.address
                .toString()
                .toLowerCase()
                .contains(stringtosearch.toLowerCase())))
        .toList());
  }

  check_if_account_exist(
      {required BuildContext context,
      required String originalimagefilename}) async {
    isUpdating.value = true;
    var result = await HomepageApi.checkAccount(
        username: customernametext.text,
        password: customerpasswordtext.text,
        id: Get.find<StorageService>().box.read('userid'));
    if (result == "Valid") {
      update_Account(
          context: context,
          storeid: Get.find<StorageService>().box.read('userid'),
          originalfilename: originalimagefilename);
    } else if (result == "Invalid") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Account Already Exist!')));
      isUpdating.value = false;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error Contanct Developer!')));
      isUpdating.value = false;
    }
  }

  update_Account(
      {required BuildContext context,
      required String storeid,
      required String originalfilename}) async {
    var result = await HomepageApi.update_Account(
        customername: customernametext.text,
        customeraddress: customeraddress.text,
        customerusername: customerusernametext.text,
        customerpassword: customerpasswordtext.text,
        storeid: storeid,
        customercontact: customercontactno.text,
        customerimage: customerFileImageName.value);
    print(result);
    if (originalfilename != customerFileImageName.value) {
      await HomepageApi.insertimage(
          path: customerFile!.path,
          imagename: customerFileImageName.value,
          imagefile: customerFile!);
    }
    var res = await HomepageApi.getuser(
        username: customerusernametext.text,
        password: customerpasswordtext.text);
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

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Account Updated!')));
    isUpdating.value = false;
    setData();
  }

  get_Data_Pending() async {
    var result = await HomepageApi.getDataPending();
    trackOrderList.assignAll(result.reversed);
  }

  get_Data_history() async {
    var result = await HomepageApi.getHistory();
    historyList.assignAll(result.reversed);
  }

  get_rental_Data_Pending() async {
    var result = await HomepageApi.getRentalPending();
    trackRental.assignAll(result.reversed);
  }

  get_rental_Data_history() async {
    var result = await HomepageApi.getHistoryRental();
    rentalHistory.assignAll(result.reversed);
  }

  get_order_Details({required String ordernumber}) async {
    var result = await HomepageApi.getOrderDetails(ordernumber: ordernumber);
    orderhsitoryDetails.assignAll(result);
  }

  RxString countTotal() {
    var total = 0.0;
    for (var i = 0; i < orderhsitoryDetails.length; i++) {
      total = total +
          (double.parse(orderhsitoryDetails[i].productPrice) *
              int.parse(orderhsitoryDetails[i].productQuantity));
    }
    return total.toStringAsFixed(2).obs;
  }

  count_approved_order() async {
    var result = await HomepageApi.count_approved_orders(status: "Approved");
    print("order approved count : $result");
    if (result == 0) {
      hasApprovedOrder(false);
    } else {
      hasApprovedOrder(true);
    }
  }

  count_approved_services() async {
    var result = await HomepageApi.count_approved_services(status: "Approved");
    print("services approved count : $result");
    if (result == 0) {
      hasApprovedServices(false);
    } else {
      hasApprovedServices(true);
    }
  }

  stream_approved_orders() {
    streamforApprovedOrders = Timer.periodic(Duration(seconds: 30), (timer) {
      count_approved_order();
      count_approved_services();
    });
  }

  get_searched_product(
      {required String productName,
      required Sizer sizer,
      required BuildContext context}) async {
    var result =
        await HomepageApi.get_searched_product(productName: productName);
    RxList<SearchedProductModel> productSearchList =
        <SearchedProductModel>[].obs;
    productSearchList.assignAll(result);
    if (productSearchList.isEmpty) {
      showCustomerNote_Product_Unvailable(sizer: sizer, context: context);
    } else {
      Get.to(() => StoreProductView(), arguments: {
        'storeid': productSearchList[0].productStoreId,
        'searched_product': productName,
      });
    }
    // if(result.)
    // orderhsitoryDetails.assignAll(result);
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

  showCustomerNote(
      {required Sizer sizer,
      required BuildContext context,
      required String note}) {
    Get.dialog(AlertDialog(
      content: Container(
        height: sizer.height(height: 30, context: context),
        width: sizer.width(width: 70, context: context),
        // color: Colors.red,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: sizer.width(width: 70, context: context),
              child: Text(
                "Note",
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
                child: Text(
                  note,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: sizer.font(fontsize: 12, context: context)),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: sizer.width(width: 70, context: context),
              child: Text(
                "Note for store",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  showCustomerNote_Product_Unvailable({
    required Sizer sizer,
    required BuildContext context,
  }) {
    Get.dialog(AlertDialog(
      content: Container(
        height: sizer.height(height: 8, context: context),
        width: sizer.width(width: 70, context: context),
        // color: Colors.red,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: sizer.width(width: 70, context: context),
              child: Text(
                "Message",
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
                alignment: Alignment.center,
                width: sizer.width(width: 70, context: context),
                child: Text(
                  "Sorry. Product Unavailable.",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: sizer.font(fontsize: 14, context: context)),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
