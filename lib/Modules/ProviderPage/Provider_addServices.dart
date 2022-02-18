import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/ProviderPage/ProviderPage_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProviderAddServices extends GetView<ProviderController> {
  const ProviderAddServices({Key? key, this.image}) : super(key: key);
  final String? image;
  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return Scaffold(
      body: Container(
        height: sizer.height(height: 100, context: context),
        width: sizer.width(width: 100, context: context),
        padding: EdgeInsets.only(
            left: sizer.width(width: 2, context: context),
            right: sizer.width(width: 2, context: context)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // color: Colors.red,
                // height: sizer.height(height: 30, context: context),
                // width: sizer.width(width: 100, context: context),
                child: Image.asset(
                  'asset/image/newlogowithtext.png',
                  height: sizer.height(height: 40, context: context),
                  width: sizer.width(width: 80, context: context),
                ),
              ),
              Container(
                alignment: Alignment.center,
                // color: Colors.red,
                height: sizer.height(height: 6, context: context),
                width: sizer.width(width: 100, context: context),
                child: TextField(
                  obscureText: false,
                  controller: controller.servicesName,
                  style: TextStyle(
                      fontSize: sizer.font(fontsize: 10, context: context)),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.label),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
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
                  controller: controller.servicesPrice,
                  style: TextStyle(
                      fontSize: sizer.font(fontsize: 10, context: context)),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.paid_outlined),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Price",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                ),
              ),
              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
              Container(
                alignment: Alignment.center,
                // color: Colors.red,
                height: sizer.height(height: 15, context: context),
                width: sizer.width(width: 100, context: context),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 6,
                  obscureText: false,
                  controller: controller.servicesDescription,
                  style: TextStyle(
                      fontSize: sizer.font(fontsize: 10, context: context)),
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                            bottom:
                                sizer.height(height: 8.5, context: context)),
                        child: Icon(Icons.format_list_bulleted_rounded),
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                ),
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Container(
                height: sizer.height(height: 15, context: context),
                width: sizer.width(width: 100, context: context),
                decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: Obx(() =>
                    controller.providerFileImageName.value == 'no-image.jpg'
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
                                    controller.providerFile!,
                                  ),
                                ),
                              ),
                            ),
                          )),
              ),
              SizedBox(
                height: sizer.height(height: 3, context: context),
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
                      controller.create_services(context: context);
                    },
                    child: Text("Add Services",
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
