import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_chat.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_checkout.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_controller.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_details.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class StoreProductView extends GetView<StoreProductController> {
  const StoreProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(StoreProductController());
    Sizer sizer = Sizer();
    return WillPopScope(
      onWillPop: () => controller.stopStream(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.grey[200],
            height: sizer.height(height: 100, context: context),
            width: sizer.width(width: 100, context: context),
            child: Obx(
              () => controller.isGettingStoreDetails.value == true
                  ? Center(
                      child: SpinKitThreeBounce(
                        color: Colors.black,
                        size: sizer.font(fontsize: 40, context: context),
                      ),
                    )
                  : Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Container(
                              height:
                                  sizer.height(height: 30, context: context),
                              width: sizer.width(width: 100, context: context),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "$imageEndpoint/${controller.storeimage.value}"),
                              )),
                            ),
                            Positioned(
                              bottom:
                                  sizer.height(height: 23, context: context),
                              child: Container(
                                width:
                                    sizer.width(width: 100, context: context),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      // color: Colors.red,
                                      height: sizer.height(
                                          height: 6, context: context),
                                      width: sizer.width(
                                          width: 85, context: context),
                                      child: TextField(
                                        obscureText: false,
                                        controller: controller.searchTextField,
                                        onChanged: (value) {
                                          controller.searchProduct(
                                              stringtosearch: controller
                                                  .searchTextField.text);
                                        },
                                        style: TextStyle(
                                            fontSize: sizer.font(
                                                fontsize: 10,
                                                context: context)),
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            prefixIcon: Icon(Icons.search),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 15.0),
                                            hintText: "Search",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        32.0))),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Obx(
                                          () => InkWell(
                                            onTap: () {
                                              Get.to(() => StoreProductsChat());
                                              controller.getChat();
                                              controller.update_seen_status();
                                            },
                                            child: controller.hasMessageNotSeen
                                                        .value ==
                                                    true
                                                ? Badge(
                                                    badgeContent: Text(" ! "),
                                                    child: Icon(
                                                      Icons.message_rounded,
                                                      color: Colors.white,
                                                      size: sizer.font(
                                                          fontsize: 30,
                                                          context: context),
                                                    ),
                                                  )
                                                : Icon(
                                                    Icons.message_rounded,
                                                    color: Colors.white,
                                                    size: sizer.font(
                                                        fontsize: 30,
                                                        context: context),
                                                  ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: sizer.width(
                                              width: 3, context: context),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: sizer.width(width: 2, context: context),
                                  bottom:
                                      sizer.height(height: 1, context: context),
                                  right:
                                      sizer.width(width: 2, context: context)),
                              child: Container(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                height:
                                    sizer.height(height: 9, context: context),
                                width:
                                    sizer.width(width: 100, context: context),
                                padding: EdgeInsets.only(
                                    left:
                                        sizer.width(width: 1, context: context),
                                    top: sizer.height(
                                        height: 0.5, context: context),
                                    right: sizer.width(
                                        width: 1, context: context)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.storename.value,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      controller.storeaddress.value,
                                      style: TextStyle(
                                        fontSize: sizer.font(
                                            fontsize: 9, context: context),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      controller.storecontanctno.value,
                                      style: TextStyle(
                                        fontSize: sizer.font(
                                            fontsize: 9, context: context),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: sizer.height(height: 2, context: context),
                        ),
                        Expanded(
                          child: Obx(
                            () => GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: controller.storeProducts.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    controller.selectedProduct =
                                        controller.storeProducts[index];
                                    Get.to(() => StoreProductDetailsView());
                                    controller.searchTextField.clear();
                                    controller.searchProduct(
                                        stringtosearch: "");
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: sizer.width(
                                            width: 2, context: context),
                                        bottom: sizer.width(
                                            width: 2, context: context),
                                        right: sizer.width(
                                            width: 2, context: context)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      height: sizer.height(
                                          height: 15, context: context),
                                      width: sizer.width(
                                          width: 100, context: context),
                                      child: Column(
                                        children: [
                                          Stack(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            '$imageEndpoint/${controller.storeProducts[index].productImage}')),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20),
                                                    )),
                                                height: sizer.height(
                                                    height: 15,
                                                    context: context),
                                                width: sizer.width(
                                                    width: 100,
                                                    context: context),
                                              ),
                                              Obx(
                                                () =>
                                                    controller
                                                                .storeProducts[
                                                                    index]
                                                                .productQuantity
                                                                .value ==
                                                            0
                                                        ? SizedBox()
                                                        : Positioned(
                                                            top: 10,
                                                            right: 10,
                                                            child: Container(
                                                              padding: EdgeInsets.only(
                                                                  top: sizer.width(
                                                                      width:
                                                                          0.5,
                                                                      context:
                                                                          context),
                                                                  bottom: sizer.width(
                                                                      width:
                                                                          0.5,
                                                                      context:
                                                                          context),
                                                                  left: sizer.width(
                                                                      width: 2,
                                                                      context:
                                                                          context),
                                                                  right: sizer.width(
                                                                      width: 2,
                                                                      context:
                                                                          context)),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3),
                                                                  color: Colors
                                                                      .black45),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child:
                                                                  Obx(
                                                                      () =>
                                                                          Text(
                                                                            controller.storeProducts[index].productQuantity.value.toString(),
                                                                            style: TextStyle(
                                                                                fontSize: sizer.font(fontsize: 16, context: context),
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.black),
                                                                          )),
                                                            ),
                                                          ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                              height: sizer.height(
                                                  height: 0.5,
                                                  context: context)),
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: sizer.width(
                                                  width: 1, context: context),
                                            ),
                                            width: sizer.width(
                                                width: 100, context: context),
                                            child: Text(
                                              controller.storeProducts[index]
                                                  .productName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: sizer.font(
                                                      fontsize: 12,
                                                      context: context)),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: sizer.width(
                                                  width: 1, context: context),
                                            ),
                                            width: sizer.width(
                                                width: 100, context: context),
                                            child: Text(
                                              "₱ " +
                                                  double.parse(controller
                                                          .storeProducts[index]
                                                          .productPrice)
                                                      .toStringAsFixed(2),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: sizer.font(
                                                      fontsize: 9,
                                                      context: context)),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: sizer.width(
                                                  width: 1, context: context),
                                            ),
                                            width: sizer.width(
                                                width: 100, context: context),
                                            child: Text(
                                              controller.storeProducts[index]
                                                          .productCount ==
                                                      "1"
                                                  ? "Stocks: " +
                                                      controller
                                                          .storeProducts[index]
                                                          .productCount +
                                                      "-pc."
                                                  : "Stocks: " +
                                                      controller
                                                          .storeProducts[index]
                                                          .productCount +
                                                      "-pcs.",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: sizer.font(
                                                      fontsize: 9,
                                                      context: context)),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
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
        ),
        floatingActionButton: Obx(
          () => Badge(
            showBadge: controller.count_product().value == "0" ? false : true,
            position: BadgePosition(end: 1, top: 1),
            badgeColor: Colors.black,
            borderSide: BorderSide(color: Colors.white, width: 1),
            badgeContent: Obx(
              () => Text(
                controller.count_product().value,
                style: TextStyle(
                    fontSize: sizer.font(fontsize: 13, context: context),
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
            child: Container(
              height: 80.0,
              width: 80.0,
              child: FittedBox(
                child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: () async {
                      await controller.add_to_Cart();
                      Get.to(() => StoreProductsCheckoutView());
                    },
                    child: Icon(Icons.shopping_cart)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
