import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/Customerpage/Customerpage_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomerProfileUpdate extends GetView<CustomerController> {
  const CustomerProfileUpdate({
    Key? key,
    required this.id,
    required this.image,
  }) : super(key: key);
  final String? id;
  final String? image;

  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: sizer.height(height: 100, context: context),
          width: sizer.width(width: 100, context: context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Obx(
                      () => Container(
                        height: sizer.height(height: 30, context: context),
                        width: sizer.width(width: 100, context: context),
                        decoration: BoxDecoration(
                          image: controller.customerFileImageName.value == image
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage("$imageEndpoint/${image}"),
                                )
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    controller.customerFile!,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.red,
                      height: sizer.height(height: 6, context: context),
                      width: sizer.width(width: 100, context: context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: sizer.width(width: 2, context: context),
                              ),
                              Container(
                                // color: Colors.red,
                                // height: sizer.height(height: 30, context: context),
                                // width: sizer.width(width: 100, context: context),
                                child: Image.asset(
                                  'asset/image/newlogo.png',
                                  height:
                                      sizer.height(height: 6, context: context),
                                  width:
                                      sizer.width(width: 10, context: context),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.getimage();
                                },
                                icon: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                  size: sizer.font(
                                      fontsize: 30, context: context),
                                ),
                              ),
                              SizedBox(
                                width: sizer.width(width: 2, context: context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: sizer.width(width: 4, context: context),
                      right: sizer.width(width: 4, context: context)),
                  child: TextField(
                    controller: controller.customernametext,
                    decoration: InputDecoration(
                        prefix: Icon(
                          Icons.label,
                          color: Colors.black,
                        ),
                        labelText: 'Name',
                        labelStyle: TextStyle(
                            fontSize:
                                sizer.font(fontsize: 12, context: context),
                            color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: sizer.width(width: 4, context: context),
                      right: sizer.width(width: 4, context: context)),
                  child: TextField(
                    controller: controller.customeraddress,
                    decoration: InputDecoration(
                        prefix: Icon(
                          Icons.location_pin,
                          color: Colors.black,
                        ),
                        labelText: 'Address',
                        labelStyle: TextStyle(
                            fontSize:
                                sizer.font(fontsize: 12, context: context),
                            color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: sizer.width(width: 4, context: context),
                      right: sizer.width(width: 4, context: context)),
                  child: TextField(
                    controller: controller.customerusernametext,
                    decoration: InputDecoration(
                        prefix: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        labelText: 'Username',
                        labelStyle: TextStyle(
                            fontSize:
                                sizer.font(fontsize: 12, context: context),
                            color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: sizer.width(width: 4, context: context),
                      right: sizer.width(width: 4, context: context)),
                  child: Obx(
                    () => TextField(
                      controller: controller.customerpasswordtext,
                      obscureText: controller.dontShowPassword.value,
                      decoration: InputDecoration(
                          prefix: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          labelText: 'Password',
                          suffix: InkWell(
                            onTap: () {
                              if (controller.dontShowPassword.value == true) {
                                controller.dontShowPassword.value = false;
                              } else {
                                controller.dontShowPassword.value = true;
                              }
                            },
                            child: Obx(
                              () => controller.dontShowPassword.value == true
                                  ? Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.black,
                                    )
                                  : Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: Colors.black,
                                    ),
                            ),
                          ),
                          labelStyle: TextStyle(
                              fontSize:
                                  sizer.font(fontsize: 12, context: context),
                              color: Colors.black)),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: sizer.width(width: 4, context: context),
                      right: sizer.width(width: 4, context: context)),
                  child: TextField(
                    controller: controller.customercontactno,
                    decoration: InputDecoration(
                        prefix: Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                        labelText: 'Contact no.',
                        labelStyle: TextStyle(
                            fontSize:
                                sizer.font(fontsize: 12, context: context),
                            color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: sizer.height(height: 10, context: context),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: sizer.width(width: 4, context: context),
                      right: sizer.width(width: 4, context: context)),
                  child: Material(
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
                              context: context, originalimagefilename: image!);
                        },
                        child: Obx(
                          () => controller.isUpdating.value == true
                              ? Center(
                                  child: SpinKitThreeBounce(
                                    color: Colors.white,
                                    size: sizer.font(
                                        fontsize: 10, context: context),
                                  ),
                                )
                              : Text("Update Account",
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
                ),
                SizedBox(
                  height: sizer.height(height: 3, context: context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
