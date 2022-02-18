import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/Servicesview/Services_controller.dart';
import 'package:audiobuy/Modules/Servicesview/Services_rental_form.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ServicesPageView extends GetView<ServicesController> {
  const ServicesPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController());
    Sizer sizer = Sizer();
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[200],
          height: sizer.height(height: 100, context: context),
          width: sizer.width(width: 100, context: context),
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Obx(
                    () => Container(
                      height: sizer.height(height: 30, context: context),
                      width: sizer.width(width: 100, context: context),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "$imageEndpoint/${controller.providerimage.value}"),
                      )),
                    ),
                  ),
                  Positioned(
                    bottom: sizer.height(height: 23, context: context),
                    child: Container(
                      alignment: Alignment.center,
                      // color: Colors.red,
                      height: sizer.height(height: 6, context: context),
                      width: sizer.width(width: 100, context: context),
                      child: TextField(
                        obscureText: false,
                        controller: controller.searchTextField,
                        onChanged: (value) {
                          controller.searchProduct(
                              stringtosearch: controller.searchTextField.text);
                        },
                        style: TextStyle(
                            fontSize:
                                sizer.font(fontsize: 10, context: context)),
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.search),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Search",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: sizer.width(width: 2, context: context),
                        bottom: sizer.height(height: 1, context: context),
                        right: sizer.width(width: 2, context: context)),
                    child: Container(
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      height: sizer.height(height: 9, context: context),
                      width: sizer.width(width: 100, context: context),
                      padding: EdgeInsets.only(
                          left: sizer.width(width: 1, context: context),
                          top: sizer.height(height: 0.5, context: context),
                          right: sizer.width(width: 1, context: context)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              controller.providername.value,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              controller.provideraddress.value,
                              style: TextStyle(
                                fontSize:
                                    sizer.font(fontsize: 9, context: context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              controller.providercontact.value,
                              style: TextStyle(
                                fontSize:
                                    sizer.font(fontsize: 9, context: context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.servicesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          controller.selectedService =
                              controller.servicesList[index];
                          Get.to(() => ServicesApplicationForm());
                          controller.searchTextField.clear();
                          controller.searchProduct(stringtosearch: "");
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: sizer.width(width: 2, context: context),
                            right: sizer.width(width: 2, context: context),
                            bottom: sizer.height(height: 2, context: context),
                          ),
                          child: Container(
                            color: Colors.white,
                            height: sizer.height(height: 16, context: context),
                            width: sizer.width(width: 100, context: context),
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      sizer.width(width: 2, context: context),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      // color: Colors.blue,
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "$imageEndpoint/${controller.servicesList[index].serviceImage}"))),
                                  height: sizer.height(
                                      height: 14, context: context),
                                  width:
                                      sizer.width(width: 30, context: context),
                                ),
                                SizedBox(
                                  width:
                                      sizer.width(width: 1, context: context),
                                ),
                                Expanded(
                                    child: Container(
                                  // color: Colors.amber,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: sizer.height(
                                            height: 1, context: context),
                                      ),
                                      Text(
                                          controller
                                              .servicesList[index].serviceName,
                                          style: sizer.style(
                                              context: context,
                                              fontsize: 15,
                                              color: Colors.black)),
                                      Text(
                                          "₱ " +
                                              controller.servicesList[index]
                                                  .servicePrice,
                                          style: sizer.style(
                                              context: context,
                                              fontsize: 9,
                                              color: Colors.grey)),
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
