import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/SplashScreen/SplashScreen_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    Sizer sizer = Sizer();
    return Scaffold(
      body: Container(
        height: sizer.height(height: 100, context: context),
        width: sizer.width(width: 100, context: context),
        padding: EdgeInsets.only(
            left: sizer.width(width: 3, context: context),
            right: sizer.width(width: 3, context: context)),
        child: Column(
          children: [
            Container(
              height: sizer.height(height: 100, context: context),
              width: sizer.width(width: 100, context: context),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/image/logowithtext.png'))),
            )
          ],
        ),
      ),
    );
  }
}
