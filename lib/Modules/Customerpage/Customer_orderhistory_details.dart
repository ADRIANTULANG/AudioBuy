import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/Customerpage/Customerpage_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomerOrderHistoryDetails extends GetView<CustomerController> {
  const CustomerOrderHistoryDetails(
      {Key? key,
      required this.ordernumber,
      required this.isDelivery,
      required this.orderStatus})
      : super(key: key);
  final String? ordernumber;
  final bool? isDelivery;
  final String? orderStatus;

  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Order Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: sizer.height(height: 100, context: context),
        width: sizer.width(width: 100, context: context),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.orderhsitoryDetails.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: sizer.width(width: 2, context: context),
                        right: sizer.width(width: 2, context: context),
                        top: sizer.height(height: 2, context: context),
                      ),
                      child: Container(
                        height: sizer.height(height: 15, context: context),
                        width: sizer.width(width: 100, context: context),
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  height: sizer.height(
                                      height: 13, context: context),
                                  width:
                                      sizer.width(width: 30, context: context),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              '$imageEndpoint/${controller.orderhsitoryDetails[index].productImage}'))),
                                ),
                                Positioned(
                                  top: sizer.height(
                                      height: .5, context: context),
                                  right:
                                      sizer.width(width: 1, context: context),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[500],
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: EdgeInsets.only(
                                        top: sizer.height(
                                            height: .5, context: context),
                                        bottom: sizer.height(
                                            height: .5, context: context),
                                        left: sizer.width(
                                            width: 2, context: context),
                                        right: sizer.width(
                                            width: 2, context: context)),
                                    child: Text(
                                      controller.orderhsitoryDetails[index]
                                          .productQuantity
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.only(
                                  top: sizer.height(
                                      height: 0.5, context: context),
                                  left:
                                      sizer.width(width: 2, context: context)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller
                                        .orderhsitoryDetails[index].productName
                                        .trim(),
                                    style: sizer.style(
                                        context: context,
                                        fontsize: 12,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "₱ " +
                                        controller.orderhsitoryDetails[index]
                                            .productPrice,
                                    style: sizer.style(
                                        context: context,
                                        fontsize: 10,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: sizer.width(width: 4, context: context),
                right: sizer.width(width: 4, context: context),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Status:",
                    style: sizer.style(
                        context: context, fontsize: 12, color: Colors.black),
                  ),
                  Text(
                    orderStatus.toString(),
                    style: sizer.style(
                        context: context, fontsize: 12, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: sizer.height(height: 1, context: context)),
            Padding(
              padding: EdgeInsets.only(
                left: sizer.width(width: 4, context: context),
                right: sizer.width(width: 4, context: context),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payment type:",
                    style: sizer.style(
                        context: context, fontsize: 12, color: Colors.black),
                  ),
                  Text(
                    isDelivery == true ? "Cash on Delivery (COD)" : "Pick Up",
                    style: sizer.style(
                        context: context, fontsize: 12, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: sizer.height(height: 1, context: context)),
            Padding(
              padding: EdgeInsets.only(
                left: sizer.width(width: 4, context: context),
                right: sizer.width(width: 4, context: context),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: sizer.style(
                        context: context, fontsize: 12, color: Colors.black),
                  ),
                  Obx(
                    () => Text(
                      "₱ " + controller.countTotal().value,
                      style: sizer.style(
                          context: context, fontsize: 12, color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: sizer.height(height: 3, context: context)),
          ],
        ),
      ),
    );
  }
}
