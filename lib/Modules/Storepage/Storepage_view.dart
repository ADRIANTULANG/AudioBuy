import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Helpers/storage.dart';

import 'package:audiobuy/Modules/Storepage/Storepage_addProduct.dart';
import 'package:audiobuy/Modules/Storepage/Storepage_controller.dart';
import 'package:audiobuy/Modules/Storepage/Storepage_for_approval.dart';
import 'package:audiobuy/Modules/Storepage/Storepage_profileupdate.dart';
import 'package:audiobuy/Modules/Storepage/Storepage_updateproducts.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class StorePageView extends GetView<StorepageController> {
  const StorePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(StorepageController());
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
                            image: controller.imageofstore.value !=
                                    'no-image.jpg'
                                ? NetworkImage(
                                    '$imageEndpoint${controller.imageofstore.value}')
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
                          controller.profileFileImage.value =
                              Get.find<StorageService>().box.read('image');
                          controller.storename.text =
                              Get.find<StorageService>().box.read('name');
                          controller.storeaddress.text =
                              Get.find<StorageService>().box.read('address');
                          controller.storeusername.text =
                              Get.find<StorageService>().box.read('username');
                          controller.storepassword.text =
                              Get.find<StorageService>().box.read('password');
                          controller.storecontact.text =
                              Get.find<StorageService>().box.read('contactno');
                          Get.to(() => StorePageUpdateProfile(
                              id: Get.find<StorageService>().box.read('userid'),
                              image: Get.find<StorageService>()
                                  .box
                                  .read('image')));
                        },
                        icon: Icon(
                          Icons.person_pin,
                          color: Colors.white,
                          size: sizer.font(fontsize: 40, context: context),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: sizer.height(height: 7.5, context: context),
                    left: sizer.width(width: 1, context: context),
                    child: Container(
                      child: IconButton(
                        onPressed: () {
                          controller.get_orders_of_Stores();
                          Get.to(() => StoreOrderForApproval());
                        },
                        icon: Obx(
                          () => Badge(
                            badgeContent:
                                Text(controller.pendingCount.value.toString()),
                            showBadge: controller.hasApprovedOrder.value,
                            child: Icon(
                              Icons.list_alt,
                              color: Colors.white,
                              size: sizer.font(fontsize: 38, context: context),
                            ),
                          ),
                        ),
                      ),
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
                  ),
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
                      controller.nameofstore.value,
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
                      controller.addressofstore.value,
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
                      controller.contanctofstore.value,
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
                      itemCount: controller.productList.length,
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
                                        controller.delete(
                                            productid: controller
                                                .productList[index].productId);
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
                                          controller.productname.text =
                                              controller.productList[index]
                                                  .productName;
                                          controller.productPrice.text =
                                              controller.productList[index]
                                                  .productPrice;
                                          controller.productDescription.text =
                                              controller.productList[index]
                                                  .productDescription;
                                          controller.productFilename.value =
                                              controller.productList[index]
                                                  .productImage;
                                          Get.to(() => StorePageUpdateProducts(
                                                id: controller
                                                    .productList[index]
                                                    .productId,
                                                name: controller
                                                    .productList[index]
                                                    .productName,
                                                price: controller
                                                    .productList[index]
                                                    .productPrice,
                                                description: controller
                                                    .productList[index]
                                                    .productDescription,
                                                image: controller
                                                    .productList[index]
                                                    .productImage,
                                              ));
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
                                            image: controller.productList[index]
                                                        .productImage !=
                                                    'no-image.jpg'
                                                ? NetworkImage(
                                                    '$imageEndpoint${controller.productList[index].productImage}')
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
                                              .productList[index].productName,
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
                                              controller.productList[index]
                                                  .productPrice,
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
                                          controller.productList[index]
                                              .productDescription,
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
          controller.productname.clear();
          controller.productPrice.clear();
          controller.productDescription.clear();
          controller.productFilename.value = 'no-image.jpg';
          Get.to(() => StoreAddProducts());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
