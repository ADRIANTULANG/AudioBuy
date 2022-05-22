import 'dart:async';

import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Helpers/sizer.dart';

import 'package:audiobuy/Modules/Customerpage/Customerpage_controller.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_view.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class StoreView extends GetView<CustomerController> {
  const StoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: sizer.height(height: 1, context: context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  shape: BoxShape.circle,
                ),
                child: Obx(
                  () => Badge(
                    toAnimate: false,
                    badgeContent: Text(' ! '),
                    showBadge: controller.hasApprovedOrder.value == true ||
                            controller.hasApprovedServices.value == true
                        ? true
                        : false,
                    child: IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: Icon(
                          Icons.person,
                          color: Colors.black54,
                        )),
                  ),
                ),
              ),
              Container(
                child: Container(
                  alignment: Alignment.center,
                  // color: Colors.red,
                  height: sizer.height(height: 6, context: context),
                  width: sizer.width(width: 60, context: context),
                  child: TextField(
                    obscureText: false,
                    controller: controller.searchController,
                    onChanged: (value) {
                      if (controller.debounce?.isActive ?? false)
                        controller.debounce?.cancel();
                      controller.debounce =
                          Timer(const Duration(milliseconds: 800), () async {
                        if (controller.searchController.text == "") {
                          FocusScope.of(context).unfocus();
                        } else {
                          await controller.get_searched_product(
                              context: context,
                              sizer: sizer,
                              productName:
                                  controller.searchController.text.toString());
                          FocusScope.of(context).unfocus();
                          controller.searchController.clear();
                        }
                      });

                      // if (controller.searchController.text.isEmpty) {
                      //   print("daan here dont search");
                      //   controller.isInfiniteScroll.value = true;
                      //   controller.storeList
                      //       .assignAll(controller.storeListMasterList);
                      // } else {
                      //   print("daan here search");
                      //   controller.searchFunctionNew(
                      //       stringtosearch: controller.searchController.text);
                      // }
                    },
                    style: TextStyle(
                        fontSize: sizer.font(fontsize: 10, context: context)),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        prefixIcon: Icon(Icons.search),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Search Products",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                          32.0,
                        ))),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                    onPressed: () {
                      controller.viewStorePage.value = false;
                      controller.getCountStoreOrServices(usertype: "provider");
                      controller.getStoresOrServices(usertype: "provider");
                    },
                    icon: Icon(
                      Icons.home_repair_service,
                      color: Colors.black54,
                    )),
              )
            ],
          ),
          SizedBox(
            height: sizer.height(height: 3, context: context),
          ),
          Container(
            width: sizer.width(width: 100, context: context),
            child: Obx(
              () => Text(
                controller.storecounts.value + "+",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: sizer.font(fontsize: 25, context: context),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: sizer.width(width: 100, context: context),
            child: Text(
              "Amazing",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: sizer.font(fontsize: 23, context: context),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: sizer.width(width: 100, context: context),
            child: Text(
              "Stores",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: sizer.font(fontsize: 23, context: context),
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: sizer.height(height: 3, context: context),
          ),
          Obx(
            () => CarouselSlider(
              options: CarouselOptions(
                height: sizer.height(height: 60, context: context),
                enableInfiniteScroll: controller.isInfiniteScroll.value,
                enlargeCenterPage: true,
              ),
              items: controller.storeList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => StoreProductView(), arguments: {
                          'storeid': i.userid,
                          'searched_product': '/%no-product%/'
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                sizer.width(width: 1.5, context: context)),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32)),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          '$imageEndpoint/${i.image}')),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(32),
                                    topLeft: Radius.circular(32),
                                  )),
                              height:
                                  sizer.height(height: 39, context: context),
                              width: sizer.width(width: 100, context: context),
                            ),
                            SizedBox(
                              height:
                                  sizer.height(height: 1.5, context: context),
                            ),
                            Container(
                              // padding: EdgeInsets.only(
                              //     left: sizer.width(width: 1, context: context),
                              //     right: sizer.width(width: 1, context: context)),
                              width: sizer.width(width: 60, context: context),
                              child: Text(
                                i.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: sizer.font(
                                        fontsize: 17, context: context),
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              width: sizer.width(width: 80, context: context),
                              padding: EdgeInsets.only(
                                  left: sizer.width(width: 3, context: context),
                                  right:
                                      sizer.width(width: 3, context: context)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    size: sizer.font(
                                        fontsize: 20, context: context),
                                  ),
                                  SizedBox(
                                    width: sizer.width(
                                        width: 1.5, context: context),
                                  ),
                                  Container(
                                    width: sizer.width(
                                        width: 50, context: context),
                                    child: Text(
                                      i.address,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: sizer.font(
                                              fontsize: 11, context: context),
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: sizer.width(width: 3, context: context),
                                  right:
                                      sizer.width(width: 3, context: context)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: sizer.font(
                                        fontsize: 20, context: context),
                                  ),
                                  SizedBox(
                                    width: sizer.width(
                                        width: 1.5, context: context),
                                  ),
                                  Container(
                                    child: Text(
                                      i.contactno,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: sizer.font(
                                              fontsize: 11, context: context),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.count_approved_order();
            },
            child: Container(
              // color: Colors.green,
              alignment: Alignment.bottomLeft,
              height: sizer.height(height: 10, context: context),
              width: sizer.width(width: 100, context: context),
              child: Image.asset(
                'asset/image/newlogowithtext.png',
                height: sizer.height(height: 5.5, context: context),
              ),
            ),
          )
        ],
      ),
    );
  }
}
