import 'dart:io';

import 'package:audiobuy/Modules/Registration/Registration_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstname = TextEditingController();

  TextEditingController address = TextEditingController();
  TextEditingController contanctno = TextEditingController();

  RxString imagefilename = ''.obs;
  File? image;

  @override
  void onInit() {
    super.onInit();
  }

  getimage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (result != null) {
      image = File(result.files.single.path!);
      imagefilename.value = image!.path.split('/').last;
      print(imagefilename.value);
    } else {
      // User canceled the picker
    }
  }

  check_if_account_exist(
      {required BuildContext context, required String usertype}) async {
    var result = await RegistrationApi.check_credentials(
        username: username.text, password: password.text);
    if (result == "Valid") {
      createAccount(context: context, usertype: usertype);
    } else if (result == "Invalid") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Account Already Exist!')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error Contanct Developer!')));
    }
  }

  createAccount(
      {required BuildContext context, required String usertype}) async {
    var result = await RegistrationApi.create_user(
        usertype: usertype,
        username: username.text,
        password: password.text,
        firstname: firstname.text,
        contactno: contanctno.text,
        address: address.text,
        image: imagefilename.value == "" ? "no-image.jpg" : imagefilename.value,
        imagefile: image);
    print("result $result");
    if (imagefilename.value != "") {
      var imageresult = await RegistrationApi.insertimage(
          path: image!.path, imagename: imagefilename.value, imagefile: image);
      print("iimage result: $imageresult");
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Account Created!')));
  }
}
