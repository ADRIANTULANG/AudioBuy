import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/Registration/Registration_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RegisterCustomer extends GetView<RegistrationController> {
  const RegisterCustomer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return Scaffold(
      body: Container(
        height: sizer.height(height: 100, context: context),
        width: sizer.width(width: 100, context: context),
        padding: EdgeInsets.only(
            left: sizer.width(width: 3, context: context),
            right: sizer.width(width: 2, context: context)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                // color: Colors.red,
                // height: sizer.height(height: 100, context: context),
                // width: sizer.width(width: 100, context: context),
                child: Image.asset(
                  'asset/image/logowithtext.png',
                  height: sizer.height(height: 40, context: context),
                  width: sizer.width(width: 100, context: context),
                ),
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
                child: TextField(
                  obscureText: false,
                  controller: controller.password,
                  style: TextStyle(
                      fontSize: sizer.font(fontsize: 10, context: context)),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Password",
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
                child: TextField(
                  obscureText: false,
                  controller: controller.firstname,
                  style: TextStyle(
                      fontSize: sizer.font(fontsize: 10, context: context)),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.label),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Name",
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
                child: TextField(
                  obscureText: false,
                  controller: controller.address,
                  style: TextStyle(
                      fontSize: sizer.font(fontsize: 10, context: context)),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_history_sharp),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Address",
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
                child: TextField(
                  obscureText: false,
                  controller: controller.contanctno,
                  style: TextStyle(
                      fontSize: sizer.font(fontsize: 10, context: context)),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Contact no.",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Container(
                height: sizer.height(height: 10, context: context),
                width: sizer.width(width: 100, context: context),
                decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: Obx(() => controller.imagefilename.value == ''
                    ? IconButton(
                        onPressed: () {
                          controller.getimage();
                        },
                        icon: Icon(
                          Icons.add_a_photo,
                          color: Colors.grey,
                        ))
                    : GestureDetector(
                        onTap: () {
                          controller.getimage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    controller.image!,
                                  ))),
                        ),
                      )),
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
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
                      controller.check_if_account_exist(
                          context: context, usertype: "customer");
                    },
                    child: Text("Create Account as Customer",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                                fontSize:
                                    sizer.font(fontsize: 10, context: context))
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
