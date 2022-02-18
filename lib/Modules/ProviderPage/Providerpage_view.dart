import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Helpers/storage.dart';

import 'package:audiobuy/Modules/ProviderPage/ProviderPage_controller.dart';
import 'package:audiobuy/Modules/ProviderPage/Provider_addServices.dart';
import 'package:audiobuy/Modules/ProviderPage/Provider_profileupdate.dart';
import 'package:audiobuy/Modules/ProviderPage/Provider_services_for_approval.dart';
import 'package:audiobuy/Modules/ProviderPage/Provider_updateServices.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProviderPageView extends GetView<ProviderController> {
  const ProviderPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProviderController());
    Sizer sizer = Sizer();
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: sizer.height(height: 100, context: context),
          width: sizer.width(width: 100, context: context),
          child: Column(
            children: [
              Stack(
                children: [
                  Obx(
                    () => Container(
                      height: sizer.height(height: 30, context: context),
                      width: sizer.width(width: 100, context: context),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: controller.providerImage.value !=
                                    'no-image.jpg'
                                ? NetworkImage(
                                    '$imageEndpoint${controller.providerImage.value}')
                                : NetworkImage("$imageEndpoint/no-image.jpg")),
                      ),
                    ),
                  ),
                  Positioned(
                    top: sizer.height(height: 1, context: context),
                    left: sizer.width(width: 1, context: context),
                    child: Container(
                      child: IconButton(
                          onPressed: () {
                            controller.providerFileImageName.value =
                                Get.find<StorageService>().box.read('image');
                            controller.providernametext.text =
                                Get.find<StorageService>().box.read('name');
                            controller.provideraddress.text =
                                Get.find<StorageService>().box.read('address');
                            controller.providerusernametext.text =
                                Get.find<StorageService>().box.read('username');
                            controller.providerpasswordtext.text =
                                Get.find<StorageService>().box.read('password');
                            controller.providercontactno.text =
                                Get.find<StorageService>()
                                    .box
                                    .read('contactno');
                            Get.to(() => ProviderUpdateProfile(
                                id: Get.find<StorageService>()
                                    .box
                                    .read('userid'),
                                image: Get.find<StorageService>()
                                    .box
                                    .read('image')));
                          },
                          icon: Icon(
                            Icons.person_pin,
                            color: Colors.white,
                            size: sizer.font(fontsize: 40, context: context),
                          )),
                    ),
                  ),
                  Positioned(
                    top: sizer.height(height: 8, context: context),
                    left: sizer.width(width: 2, context: context),
                    child: Container(
                      child: IconButton(
                          onPressed: () async {
                            await controller.get_services_rental_for_approval();
                            Get.to(() => ProviderServicesForApproval());
                          },
                          icon: Obx(
                            () => Badge(
                              badgeContent:
                                  Text(controller.countPeding.value.toString()),
                              showBadge: controller.hasApprovedServices.value,
                              child: Icon(
                                Icons.list_alt,
                                color: Colors.white,
                                size:
                                    sizer.font(fontsize: 35, context: context),
                              ),
                            ),
                          )),
                    ),
                  ),
                  Positioned(
                    top: sizer.height(height: 14, context: context),
                    left: sizer.width(width: 2.5, context: context),
                    child: Container(
                      child: IconButton(
                          onPressed: () {
                            controller.logout(context: context);
                          },
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: sizer.font(fontsize: 35, context: context),
                          )),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context),
                    right: sizer.width(width: 2, context: context)),
                child: Container(
                  width: sizer.width(width: 100, context: context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32))),
                  child: Obx(
                    () => Text(
                      controller.providerName.value,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sizer.font(fontsize: 14, context: context)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context),
                    right: sizer.width(width: 2, context: context)),
                child: Container(
                  width: sizer.width(width: 100, context: context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32))),
                  child: Obx(
                    () => Text(
                      controller.providerAdrress.value,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sizer.font(fontsize: 9, context: context)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context),
                    right: sizer.width(width: 2, context: context)),
                child: Container(
                  width: sizer.width(width: 100, context: context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32))),
                  child: Obx(
                    () => Text(
                      controller.providerContactno.value,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sizer.font(fontsize: 9, context: context)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: sizer.width(width: 2, context: context),
                      right: sizer.width(width: 2, context: context)),
                  child: Obx(
                    () => ListView.builder(
                      itemCount: controller.serviceList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  sizer.height(height: 1, context: context)),
                          child: Container(
                            width: sizer.width(width: 100, context: context),
                            height: sizer.height(height: 15, context: context),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      sizer.width(width: 1, context: context),
                                ),
                                PopupMenuButton(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      onTap: () {
                                        controller.delete_Services(
                                            context: context,
                                            servicesID: controller
                                                .serviceList[index].servicesId);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete),
                                          Text("  Delete"),
                                        ],
                                      ),
                                      value: 1,
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        Future.delayed(
                                            Duration(milliseconds: 500),
                                            () async {
                                          controller.servicesName.text =
                                              controller.serviceList[index]
                                                  .serviceName;
                                          controller.servicesPrice.text =
                                              controller.serviceList[index]
                                                  .servicePrice;
                                          controller.servicesDescription.text =
                                              controller.serviceList[index]
                                                  .serviceDescription;
                                          controller
                                                  .providerFileImageName.value =
                                              controller.serviceList[index]
                                                  .serviceImage;
                                          Get.to(() => ProvicerUpdateServices(
                                              id: controller.serviceList[index]
                                                  .servicesId,
                                              name: controller
                                                  .serviceList[index]
                                                  .serviceName,
                                              price: controller
                                                  .serviceList[index]
                                                  .servicePrice,
                                              description: controller
                                                  .serviceList[index]
                                                  .serviceDescription,
                                              image: controller
                                                  .serviceList[index]
                                                  .serviceImage));
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit),
                                          Text("  Update"),
                                        ],
                                      ),
                                      value: 2,
                                    )
                                  ],
                                  child: Container(
                                    width: sizer.width(
                                        width: 30, context: context),
                                    height: sizer.height(
                                        height: 14, context: context),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: controller.serviceList[index]
                                                        .serviceImage !=
                                                    'no-image.jpg'
                                                ? NetworkImage(
                                                    '$imageEndpoint${controller.serviceList[index].serviceImage}')
                                                : NetworkImage(
                                                    "$imageEndpoint/no-image.jpg")),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      sizer.width(width: 2, context: context),
                                ),
                                Container(
                                  // color: Colors.red,
                                  width:
                                      sizer.width(width: 60, context: context),
                                  height: sizer.height(
                                      height: 14, context: context),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: sizer.width(
                                            width: 60, context: context),
                                        child: Text(
                                          controller
                                              .serviceList[index].serviceName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: sizer.font(
                                                  fontsize: 13,
                                                  context: context)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        width: sizer.width(
                                            width: 60, context: context),
                                        child: Text(
                                          "₱ " +
                                              controller.serviceList[index]
                                                  .servicePrice,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: sizer.font(
                                                  fontsize: 11,
                                                  context: context)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        // color: Colors.red,
                                        width: sizer.width(
                                            width: 60, context: context),
                                        height: sizer.height(
                                            height: 9, context: context),
                                        child: Text(
                                          controller.serviceList[index]
                                              .serviceDescription,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                              fontSize: sizer.font(
                                                  fontsize: 9,
                                                  context: context)),
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[500],
        onPressed: () {
          controller.servicesName.clear();
          controller.servicesPrice.clear();
          controller.servicesDescription.clear();
          controller.providerFileImageName.value = 'no-image.jpg';
          Get.to(() => ProviderAddServices());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
