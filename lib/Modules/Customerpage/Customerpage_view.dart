import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Helpers/storage.dart';
import 'package:audiobuy/Modules/Customerpage/Curtomer_rentalhistory.dart';
import 'package:audiobuy/Modules/Customerpage/Customer_ProfileUpdate.dart';
import 'package:audiobuy/Modules/Customerpage/Customer_orderhistory.dart';
import 'package:audiobuy/Modules/Customerpage/Customer_serviceprovider.dart';
import 'package:audiobuy/Modules/Customerpage/Customer_storeview_.dart';
import 'package:audiobuy/Modules/Customerpage/Customer_trackorder.dart';
import 'package:audiobuy/Modules/Customerpage/Customerpage_controller.dart';
import 'package:audiobuy/Modules/Customerpage/customer_trackrental.dart';

import 'package:badges/badges.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomerView extends GetView<CustomerController> {
  const CustomerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CustomerController());
    Sizer sizer = Sizer();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                padding: EdgeInsets.all(0),
                child: Container(
                  color: Colors.grey[400],
                  height: sizer.height(height: 100, context: context),
                  width: sizer.width(width: 100, context: context),
                  child: Row(
                    children: [
                      SizedBox(
                        width: sizer.width(width: 1, context: context),
                      ),
                      Obx(
                        () => Container(
                          height: sizer.height(height: 25, context: context),
                          width: sizer.width(width: 25, context: context),
                          decoration: BoxDecoration(
                              border: Border.all(width: 5, color: Colors.black),
                              // color: Colors.black,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "$imageEndpoint/${controller.image.value}")),
                              shape: BoxShape.circle),
                        ),
                      ),
                      SizedBox(
                        width: sizer.width(width: 1, context: context),
                      ),
                      Expanded(
                          child: Container(
                        // color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() => Text(
                                  controller.name.value,
                                  style: TextStyle(
                                    fontSize: sizer.font(
                                        fontsize: 11, context: context),
                                  ),
                                )),
                            Obx(() => Text(
                                  controller.address.value,
                                  style: TextStyle(
                                    fontSize: sizer.font(
                                        fontsize: 9, context: context),
                                  ),
                                )),
                            Obx(() => Text(
                                  controller.contact.value,
                                  style: TextStyle(
                                    fontSize: sizer.font(
                                        fontsize: 9, context: context),
                                  ),
                                )),
                          ],
                        ),
                      ))
                    ],
                  ),
                )),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.person_pin),
                  SizedBox(
                    width: sizer.width(width: 2, context: context),
                  ),
                  Text('Profile'),
                ],
              ),
              onTap: () {
                controller.customerFileImageName.value =
                    Get.find<StorageService>().box.read('image');
                controller.customernametext.text =
                    Get.find<StorageService>().box.read('name');
                controller.customeraddress.text =
                    Get.find<StorageService>().box.read('address');
                controller.customerusernametext.text =
                    Get.find<StorageService>().box.read('username');
                controller.customerpasswordtext.text =
                    Get.find<StorageService>().box.read('password');
                controller.customercontactno.text =
                    Get.find<StorageService>().box.read('contactno');
                Get.to(() => CustomerProfileUpdate(
                    id: Get.find<StorageService>().box.read('userid'),
                    image: Get.find<StorageService>().box.read('image')));
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.receipt_long),
                  SizedBox(
                    width: sizer.width(width: 2, context: context),
                  ),
                  Text('Track Rental Transaction'),
                ],
              ),
              onTap: () {
                controller.get_rental_Data_Pending();
                Get.to(() => CustomerTrackRental());
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.production_quantity_limits_rounded),
                  SizedBox(
                    width: sizer.width(width: 2, context: context),
                  ),
                  Text('Track Orders'),
                ],
              ),
              onTap: () {
                controller.get_Data_Pending();
                Get.to(() => CustomerTrackOrder());
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.list),
                  SizedBox(
                    width: sizer.width(width: 2, context: context),
                  ),
                  Text('Rental History'),
                  Obx(
                    () => Badge(
                      position: BadgePosition(
                          start: sizer.width(width: 1, context: context),
                          bottom: sizer.height(height: -1, context: context)),
                      badgeContent: Text(" ! "),
                      showBadge: controller.hasApprovedServices.value,
                      child: SizedBox(
                        width: sizer.width(width: 3, context: context),
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                controller.get_rental_Data_history();
                Get.to(() => CustomerRentalHistory());
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.list),
                  SizedBox(
                    width: sizer.width(width: 2, context: context),
                  ),
                  Text('Order History'),
                  Obx(
                    () => Badge(
                      position: BadgePosition(
                          start: sizer.width(width: 1, context: context),
                          bottom: sizer.height(height: -1, context: context)),
                      badgeContent: Text(" ! "),
                      showBadge: controller.hasApprovedOrder.value,
                      child: SizedBox(
                        width: sizer.width(width: 3, context: context),
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                controller.get_Data_history();
                Get.to(() => CustomerOrderHistory());
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(
                    width: sizer.width(width: 2, context: context),
                  ),
                  Text('Log out'),
                ],
              ),
              onTap: () {
                Get.back();
                controller.logout(context: context);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey[200],
          height: sizer.height(height: 100, context: context),
          width: sizer.width(width: 100, context: context),
          padding: EdgeInsets.only(
              left: sizer.width(width: 5, context: context),
              right: sizer.width(width: 5, context: context)),
          child: SingleChildScrollView(
            child: Obx(() => controller.viewStorePage.value == true
                ? StoreView()
                : ServicesView()),
          ),
        ),
      ),
    );
  }
}
