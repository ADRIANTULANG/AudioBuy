import 'dart:async';
import 'dart:io';

import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Helpers/storage.dart';
import 'package:audiobuy/Modules/Login/Login_model.dart';
import 'package:audiobuy/Modules/Login/Login_view.dart';
import 'package:audiobuy/Modules/ProviderPage/Providerpage_api.dart';
import 'package:audiobuy/Modules/ProviderPage/Providerpage_model.dart';
import 'package:audiobuy/Modules/Storepage/Storepage_api.dart';
import 'package:audiobuy/Modules/Storepage/Storepage_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderController extends GetxController {
  @override
  void onInit() {
    getServices();
    setData();
    stream_approved_orders();
    get_chats_of_users();
    super.onInit();
  }

  RxList<Users> usersList = <Users>[].obs;
  RxString providerName = ''.obs;
  RxString providerUsername = ''.obs;
  RxString providerPassword = ''.obs;
  RxString providerContactno = ''.obs;
  RxString providerImage = ''.obs;
  RxString providerAdrress = ''.obs;

  Timer? chattimer;

  TextEditingController chatTextField = TextEditingController();
  RxBool hasMessageNotSeen = false.obs;

  setData() {
    providerImage.value = Get.find<StorageService>().box.read('image');
    providerName.value = Get.find<StorageService>().box.read('name');
    providerAdrress.value = Get.find<StorageService>().box.read('address');
    providerUsername.value = Get.find<StorageService>().box.read('username');
    providerPassword.value = Get.find<StorageService>().box.read('password');
    providerContactno.value = Get.find<StorageService>().box.read('contactno');
  }

  TextEditingController providernametext = TextEditingController();
  TextEditingController providerusernametext = TextEditingController();
  TextEditingController providerpasswordtext = TextEditingController();
  TextEditingController providercontactno = TextEditingController();
  TextEditingController provideraddress = TextEditingController();

  TextEditingController servicesName = TextEditingController();
  TextEditingController servicesPrice = TextEditingController();
  TextEditingController servicesDescription = TextEditingController();
  // TextEditingController servicesStoreID = TextEditingController();

  RxString providerFileImageName = 'no-image.jpg'.obs;
  File? providerFile;
  RxList<Services> serviceList = <Services>[].obs;
  RxList<ServicesForApproval> serviceForApprovalList =
      <ServicesForApproval>[].obs;

  RxBool hasApprovedServices = false.obs;
  RxInt countPeding = 0.obs;
  Timer? streamforApprovedOrders;

  RxList<ChatModelOfStore> chatsuser = <ChatModelOfStore>[].obs;

  RxList<ChatModel> chats = <ChatModel>[].obs;

  getServices() async {
    var result = await ProviderApi.getServicesData(
        servicesStoreId: Get.find<StorageService>().box.read('userid'));
    serviceList.assignAll(result);
  }

  getimage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (result != null) {
      providerFile = File(result.files.single.path!);
      providerFileImageName.value = providerFile!.path.split('/').last;
      print(providerFileImageName.value);
    } else {
      // User canceled the picker
    }
  }

  delete_Services(
      {required String servicesID, required BuildContext context}) async {
    var result = await ProviderApi.delete_Services(serviceID: servicesID);
    print(result);
    getServices();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Service Deleted!')));
  }

  create_services({required BuildContext context}) async {
    var result = await ProviderApi.create_Services(
        serviceName: servicesName.text,
        servicePrice: servicesPrice.text,
        serviceDescription: servicesDescription.text,
        serviceStoreID: Get.find<StorageService>().box.read('userid'),
        serviceImage: providerFileImageName.value);
    print(result);
    if (providerFileImageName.value == 'no-image.jpg') {
    } else {
      await ProviderApi.insertimage(
          path: providerFile!.path,
          imagename: providerFileImageName.value,
          imagefile: providerFile!);
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Service Created!')));
    getServices();
  }

  update_services(
      {required BuildContext context,
      required String servicesid,
      required String originalimage}) async {
    var result = await ProviderApi.update_Services(
        serviceID: servicesid,
        serviceName: servicesName.text,
        servicePrice: servicesPrice.text,
        serviceDescription: servicesDescription.text,
        serviceImage: providerFileImageName.value);
    print(result);
    if (originalimage != providerFileImageName.value) {
      await ProviderApi.insertimage(
          path: providerFile!.path,
          imagename: providerFileImageName.value,
          imagefile: providerFile!);
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Service Updated!')));
    getServices();
  }

  check_if_account_exist(
      {required BuildContext context,
      required String originalimagefilename}) async {
    var result = await ProviderApi.checkAccount(
        username: providerusernametext.text,
        password: providerpasswordtext.text,
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

  update_Account(
      {required BuildContext context,
      required String storeid,
      required String originalfilename}) async {
    var result = await ProviderApi.update_Account(
        providername: providernametext.text,
        provideraddress: provideraddress.text,
        providerusername: providerusernametext.text,
        providerpassword: providerpasswordtext.text,
        storeid: storeid,
        providercontact: providercontactno.text,
        providerimage: providerFileImageName.value);
    print(result);
    if (originalfilename != providerFileImageName.value) {
      await ProviderApi.insertimage(
          path: providerFile!.path,
          imagename: providerFileImageName.value,
          imagefile: providerFile!);
    }
    var res = await ProviderApi.getuser(
        username: providerusernametext.text,
        password: providerpasswordtext.text);
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

  get_services_rental_for_approval() async {
    var result = await ProviderApi.get_services_for_approval(
        providerid: Get.find<StorageService>().box.read('userid'));
    serviceForApprovalList.assignAll(result);
  }

  approved_or_cancel(
      {required String transactionID,
      required BuildContext context,
      required String status}) async {
    var result = await ProviderApi.update_order_Status(
        transactionID: transactionID, status: status);
    if (result == true) {
      get_services_rental_for_approval();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Order $status!')));
    }
  }

  count_approved_services() async {
    var result = await ProviderApi.count_approved_services(status: "Pending");
    print("services pending count : $result");
    if (result == 0) {
      hasApprovedServices(false);
      countPeding(result);
    } else {
      hasApprovedServices(true);
      countPeding(result);
    }
  }

  stream_approved_orders() {
    streamforApprovedOrders = Timer.periodic(Duration(seconds: 10), (timer) {
      count_approved_services();
      get_chats_of_users();
      count_Chats();
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

  get_chats_of_users() async {
    var result = await StoreApi.get_users_Chats(
        storeid: Get.find<StorageService>().box.read('userid'));
    chatsuser.assignAll(result);
  }

  sendMessage({required String customerid}) async {
    var result = await StoreApi.send_chats(
        storeid: Get.find<StorageService>().box.read('userid').toString(),
        customerid: customerid,
        message: chatTextField.text.toString());
    print(result);
    chatTextField.clear();
    update_seen_status(customerid: customerid);
  }

  getChat({required String customerid}) async {
    var result = await StoreApi.get_all_Chats(
      storeid: Get.find<StorageService>().box.read('userid').toString(),
      customerid: customerid,
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
    print(result);
  }

  start_stream_chat({required String customerid}) {
    print("timer start");
    chattimer = Timer.periodic(Duration(seconds: 3), (timer) {
      getChat(customerid: customerid);
    });
  }

  update_seen_status({required String customerid}) async {
    var result = await StoreApi.update_seen_Status(
      storeid: Get.find<StorageService>().box.read('userid').toString(),
      customerid: customerid,
    );
    print(result);
  }

  count_Chats() async {
    var result = await StoreApi.count_chats(
      storeid: Get.find<StorageService>().box.read('userid').toString(),
    );
    print(result);
    if (result > 0) {
      hasMessageNotSeen.value = true;
    } else {
      hasMessageNotSeen.value = false;
    }
  }

  stopStream() {
    chattimer!.cancel();
    // delete_Chats();
    Get.back();
    print("timer stop");
  }
}
