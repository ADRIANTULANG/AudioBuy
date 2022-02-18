import 'dart:async';

import 'package:audiobuy/Helpers/storage.dart';
import 'package:audiobuy/Modules/Customerpage/Customerpage_view.dart';
import 'package:audiobuy/Modules/Login/Login_view.dart';
import 'package:audiobuy/Modules/ProviderPage/Providerpage_view.dart';
import 'package:audiobuy/Modules/Storepage/Storepage_view.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    startNavigating();
    super.onInit();
  }

  startNavigating() {
    Timer(Duration(seconds: 4), () {
      if (Get.find<StorageService>().box.read('userid') == null) {
        Get.offAll(() => LoginView());
      } else if (Get.find<StorageService>().box.read('usertype') ==
          "customer") {
        Get.offAll(() => CustomerView());
      } else if (Get.find<StorageService>().box.read('usertype') == "store") {
        Get.offAll(() => StorePageView());
      } else if (Get.find<StorageService>().box.read('usertype') ==
          "provider") {
        Get.offAll(() => ProviderPageView());
      }
    });
  }
}
