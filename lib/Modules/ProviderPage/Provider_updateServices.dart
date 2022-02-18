import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/ProviderPage/ProviderPage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProvicerUpdateServices extends GetView<ProviderController> {
  const ProvicerUpdateServices(
      {Key? key,
      required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.image})
      : super(key: key);
  final String? id;
  final String? name;
  final String? price;
  final String? description;
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
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Obx(
                      () => Container(
                        height: sizer.height(height: 30, context: context),
                        width: sizer.width(width: 100, context: context),
                        decoration: BoxDecoration(
                          image: controller.providerFileImageName.value ==
                                  image!
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage("$imageEndpoint/${image}"),
                                )
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    controller.providerFile!,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                        right: 5,
                        top: 3,
                        child: IconButton(
                            onPressed: () {
                              controller.getimage();
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: sizer.font(fontsize: 30, context: context),
                            )))
                  ],
                ),
                SizedBox(
                  height: sizer.width(width: 2, context: context),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: sizer.width(width: 3, context: context),
                      right: sizer.width(width: 3, context: context)),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        // color: Colors.red,
                        height: sizer.height(height: 6, context: context),
                        width: sizer.width(width: 100, context: context),
                        child: TextField(
                          obscureText: false,
                          controller: controller.servicesName,
                          style: TextStyle(
                              fontSize:
                                  sizer.font(fontsize: 10, context: context)),
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
                              fontSize:
                                  sizer.font(fontsize: 10, context: context)),
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
                              fontSize:
                                  sizer.font(fontsize: 10, context: context)),
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    bottom: sizer.height(
                                        height: 8.5, context: context)),
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
                      Material(
                        elevation: 5.0,

                        borderRadius: BorderRadius.circular(30.0),
                        // color: Gradient.linear(from, to, colors),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[700],
                            borderRadius:
                                BorderRadius.all(Radius.circular(80.0)),
                          ),
                          child: MaterialButton(
                            // color:
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              controller.update_services(
                                  context: context,
                                  servicesid: id!,
                                  originalimage: image!);
                            },
                            child: Text("Update Services",
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
