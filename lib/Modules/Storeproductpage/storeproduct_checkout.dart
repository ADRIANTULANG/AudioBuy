import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class StoreProductsCheckoutView extends GetView<StoreProductController> {
  const StoreProductsCheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Checkout",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: sizer.height(height: 100, context: context),
        width: sizer.width(width: 100, context: context),
        padding: EdgeInsets.only(
          left: sizer.width(width: 3, context: context),
          right: sizer.width(width: 3, context: context),
        ),
        child: Column(
          children: [
            SizedBox(
              height: sizer.height(height: 1, context: context),
            ),
            Container(
              // color: Colors.red,
              width: sizer.width(width: 100, context: context),
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.cartList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: sizer.height(height: 0.5, context: context),
                      ),
                      child: Container(
                        // color: Colors.black,
                        // height: sizer.height(height: 5, context: context),
                        width: sizer.width(width: 100, context: context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.cartList[index].productName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: sizer.font(
                                      fontsize: 13, context: context)),
                            ),
                            Text(
                              "₱ " +
                                  controller.cartList[index].productPrice +
                                  " x " +
                                  controller.cartList[index].productQuantity
                                      .toString() +
                                  " = ₱ " +
                                  (double.parse(controller
                                              .cartList[index].productPrice) *
                                          controller
                                              .cartList[index].productQuantity)
                                      .toStringAsFixed(2),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: sizer.font(
                                      fontsize: 11, context: context)),
                            ),
                            SizedBox(
                              height: sizer.height(height: 2, context: context),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Expanded(child: SizedBox()),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: controller.isCheckedCOD.value,
                    onChanged: (value) {
                      if (controller.isCheckedCOD.value == true) {
                        controller.isCheckedCOD.value = false;
                        controller.isCheckedPickUp.value = true;
                      } else {
                        controller.isCheckedCOD.value = true;
                        controller.isCheckedPickUp.value = false;
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: sizer.width(width: 2, context: context),
                ),
                Text(
                  "Cash on Delivery (COD)",
                  style: sizer.style(
                      context: context, fontsize: 12, color: Colors.black),
                ),
              ],
            ),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: controller.isCheckedPickUp.value,
                    onChanged: (value) {
                      if (controller.isCheckedPickUp.value == true) {
                        controller.isCheckedPickUp.value = false;
                        controller.isCheckedCOD.value = true;
                      } else {
                        controller.isCheckedPickUp.value = true;
                        controller.isCheckedCOD.value = false;
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: sizer.width(width: 2, context: context),
                ),
                Text(
                  "Pick up",
                  style: sizer.style(
                      context: context, fontsize: 12, color: Colors.black),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: sizer.width(width: 4, context: context),
                  right: sizer.width(width: 2, context: context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total: ",
                    style: sizer.style(
                        context: context, fontsize: 14, color: Colors.black),
                  ),
                  Text(
                    "₱ " +
                        controller
                            .count_checkout_total()
                            .value
                            .toStringAsFixed(2),
                    style: sizer.style(
                        context: context, fontsize: 14, color: Colors.black),
                  )
                ],
              ),
            ),
            SizedBox(
              height: sizer.height(height: 2, context: context),
            ),
            Material(
              elevation: 5.0,

              borderRadius: BorderRadius.circular(30.0),
              // color: Gradient.linear(from, to, colors),
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.black,
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
                    controller.place_order(context: context, sizer: sizer);
                  },
                  child: Obx(
                    () => controller.isPlacingOrder.value == true
                        ? Center(
                            child: SpinKitThreeBounce(
                              color: Colors.white,
                              size: sizer.font(fontsize: 15, context: context),
                            ),
                          )
                        : Text("Place Order",
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
            SizedBox(
              height: sizer.height(height: 1, context: context),
            ),
          ],
        ),
      ),
    );
  }
}
