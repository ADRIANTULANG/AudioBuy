import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/Login/Login_Controller.dart';
import 'package:audiobuy/Modules/Registration/Registration_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    var sizer = Sizer();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: sizer.height(height: 100, context: context),
          width: sizer.width(width: 100, context: context),
          padding: EdgeInsets.only(
              left: sizer.width(width: 5, context: context),
              right: sizer.width(width: 5, context: context)),
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                // height: sizer.height(height: 100, context: context),
                // width: sizer.width(width: 100, context: context),
                child: Image.asset(
                  'asset/image/logowithtext.png',
                  // height: sizer.height(height: 40, context: context),
                  // width: sizer.width(width: 100, context: context),
                ),
              ),
              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
              Container(
                alignment: Alignment.center,
                // color: Colors.red,
                height: sizer.height(height: 6, context: context),
                width: sizer.width(width: 100, context: context),
                child: TextField(
                  obscureText: false,
                  controller: controller.username,
                  style: TextStyle(
                      fontSize: sizer.font(fontsize: 10, context: context)),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "User name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Container(
                  alignment: Alignment.center,
                  // color: Colors.red,
                  height: sizer.height(height: 6, context: context),
                  width: sizer.width(width: 100, context: context),
                  child: Obx(
                    () => TextField(
                      controller: controller.password,
                      obscureText: controller.dontshowPassword.value,
                      style: TextStyle(
                          fontSize: sizer.font(fontsize: 10, context: context)),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                if (controller.dontshowPassword.value == true) {
                                  controller.dontshowPassword.value = false;
                                } else {
                                  controller.dontshowPassword.value = true;
                                }
                              },
                              child: controller.dontshowPassword.value == true
                                  ? Icon(Icons.remove_red_eye)
                                  : Icon(Icons.remove_red_eye_outlined)),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                    ),
                  )),
              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
              Material(
                elevation: 5.0,

                borderRadius: BorderRadius.circular(30.0),
                // color: Gradient.linear(from, to, colors),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[700],
                    // gradient: LinearGradient(
                    //     begin: Alignment.bottomLeft,
                    //     end: Alignment.topRight,
                    //     colors: [
                    //       Colors.cyanAccent,
                    //       Colors.greenAccent,
                    //       Colors.blue,
                    //       Colors.tealAccent
                    //     ]),
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  ),
                  child: MaterialButton(
                    // color:
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {
                      controller.login(context: context);
                    },
                    child: Obx(
                      () => controller.isLoadingLogin.value == true
                          ? Center(
                              child: SpinKitThreeBounce(
                                color: Colors.white,
                                size:
                                    sizer.font(fontsize: 10, context: context),
                              ),
                            )
                          : Text("Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                      fontSize: sizer.font(
                                          fontsize: 10, context: context))
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Dont have an account?",
                      style: sizer.style(
                          context: context, fontsize: 11, color: Colors.black),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => RegistrationView());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "  Sign up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                sizer.font(fontsize: 11, context: context),
                            color: Colors.lightBlue),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
