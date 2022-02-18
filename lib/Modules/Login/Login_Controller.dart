import 'package:audiobuy/Helpers/storage.dart';
import 'package:audiobuy/Modules/Customerpage/Customerpage_view.dart';
import 'package:audiobuy/Modules/Login/Login_api.dart';
import 'package:audiobuy/Modules/Login/Login_model.dart';
import 'package:audiobuy/Modules/ProviderPage/Providerpage_view.dart';
import 'package:audiobuy/Modules/Storepage/Storepage_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  RxList<Users> usersList = <Users>[].obs;
  RxBool dontshowPassword = true.obs;

  RxBool isLoadingLogin = false.obs;

  login({required BuildContext context}) async {
    var result =
        await LoginApi.login(username: username.text, password: password.text);
    usersList.assignAll(result);
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
      if (usersList[0].usertype == "customer") {
        Get.offAll(() => CustomerView());
      } else if (usersList[0].usertype == "store") {
        Get.offAll(() => StorePageView());
      } else if (usersList[0].usertype == "provider") {
        Get.offAll(() => ProviderPageView());
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('User did not exist!')));
    }
  }
}
