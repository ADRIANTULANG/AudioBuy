import 'dart:async';

import 'package:audiobuy/Helpers/storage.dart';
import 'package:audiobuy/Modules/Servicesview/Services_api.dart';
import 'package:audiobuy/Modules/Servicesview/Services_model.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_api.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ServicesController extends GetxController {
  TextEditingController searchTextField = TextEditingController();
  RxString providerid = ''.obs;
  RxString providerimage = ''.obs;
  RxString providername = ''.obs;
  RxString providercontact = ''.obs;
  RxString provideraddress = ''.obs;
  TextEditingController chatTextField = TextEditingController();
  RxList<ServicesModel> servicesList = <ServicesModel>[].obs;

  RxList<ServicesModel> servicesList_MasterList = <ServicesModel>[].obs;

  RxList<ChatModel> chats = <ChatModel>[].obs;
  RxBool hasMessageNotSeen = false.obs;
  Timer? chattimer;

  ServicesModel? selectedService;

  TextEditingController note = TextEditingController();
  RxString datefrom = ''.obs;
  RxString dateto = ''.obs;

  RxBool isLoadingRental = false.obs;

  @override
  void onInit() async {
    providerid.value = await Get.arguments['providerid'];
    providerimage.value = await Get.arguments['providerimage'];
    providername.value = await Get.arguments['providername'];
    providercontact.value = await Get.arguments['providercontact'];
    provideraddress.value = await Get.arguments['provideraddress'];
    get_all_Services(id: providerid.value);
    start_stream_chat();
    super.onInit();
  }

  get_all_Services({required String id}) async {
    var result = await ServicesViewApi.get_services(servicesstoreid: id);
    servicesList.assignAll(result);
    servicesList_MasterList.assignAll(result);
  }

  searchProduct({required String stringtosearch}) {
    servicesList.assignAll(servicesList_MasterList
        .where((u) => (u.serviceName
                .toString()
                .toLowerCase()
                .contains(stringtosearch.toLowerCase()) ||
            u.servicePrice
                .toString()
                .toLowerCase()
                .contains(stringtosearch.toLowerCase())))
        .toList());
  }

  onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    print(args.value.endDate.toString());
    print(args.value.startDate.toString());
    datefrom.value = args.value.startDate.toString();
    dateto.value = args.value.endDate.toString();
    // var from = args.value..toString();
    // var to = args.value['endDate'].toString();
    // print(from + " " + to);
  }

  rentNow({required BuildContext context}) async {
    isLoadingRental(true);
    var result = await ServicesViewApi.create_rental(
        customercontactno: Get.find<StorageService>().box.read('contactno'),
        customerid: Get.find<StorageService>().box.read('userid'),
        servicesID: selectedService!.servicesId,
        serviceName: selectedService!.serviceName,
        servicePrice: selectedService!.servicePrice,
        serviceDescription: selectedService!.serviceDescription,
        serviceStoreID: selectedService!.serviceStoreId,
        serviceImage: selectedService!.serviceImage,
        serviceRentalDate_from: datefrom.value,
        serviceRentalDate_to: dateto.value,
        note: note.text);
    print(result);
    Timer(Duration(seconds: 3), () {
      isLoadingRental(false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Rental Succesful!')));
    });
  }

  sendMessage() async {
    var result = await StoreProductApi.send_chat(
        storeid: providerid.value,
        customerid: Get.find<StorageService>().box.read('userid').toString(),
        message: chatTextField.text.toString());
    print(result);
    chatTextField.clear();
    update_seen_status();
  }

  getChat() async {
    var result = await StoreProductApi.get_all_Chats(
      storeid: providerid.value,
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
    print(result);
  }

  start_stream_chat() {
    print("timer start");
    chattimer = Timer.periodic(Duration(seconds: 5), (timer) {
      getChat();
    });
  }

  update_seen_status() async {
    var result = await StoreProductApi.update_seen_Status(
      storeid: providerid.value,
      customerid: Get.find<StorageService>().box.read('userid').toString(),
    );
    print(result);
  }

  // delete_Chats() async {
  //   var result = await StoreProductApi.delete_chats(
  //     storeid: storeid.value,
  //     customerid: Get.find<StorageService>().box.read('userid').toString(),
  //   );
  //   print(result);
  // }

  stopStream() {
    chattimer!.cancel();
    // delete_Chats();
    Get.back();
    print("timer stop");
  }
}
