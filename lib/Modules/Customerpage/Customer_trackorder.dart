import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/Customerpage/Customer_orderhistory_details.dart';
import 'package:audiobuy/Modules/Customerpage/Customerpage_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomerTrackOrder extends GetView<CustomerController> {
  const CustomerTrackOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Track Order",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[200],
        height: sizer.height(height: 100, context: context),
        width: sizer.width(width: 100, context: context),
        child: Obx(
          () => ListView.builder(
            itemCount: controller.trackOrderList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context),
                    top: sizer.width(width: 2, context: context),
                    right: sizer.width(width: 2, context: context)),
                child: GestureDetector(
                  onTap: () {
                    controller.get_order_Details(
                        ordernumber:
                            controller.trackOrderList[index].ordernumber);
                    Get.to(() => CustomerOrderHistoryDetails(
                        ordernumber:
                            controller.trackOrderList[index].ordernumber));
                  },
                  child: Container(
                    color: Colors.white,
                    height: sizer.height(height: 8, context: context),
                    width: sizer.width(width: 100, context: context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.trackOrderList[index].ordernumber,
                          style: sizer.style(
                              context: context,
                              fontsize: 12,
                              color: Colors.black),
                        ),
                        Text(
                          controller.trackOrderList[index].timeStamp.year
                                  .toString() +
                              "-" +
                              controller.trackOrderList[index].timeStamp.day
                                  .toString() +
                              "-" +
                              controller.trackOrderList[index].timeStamp.month
                                  .toString(),
                          style: sizer.style(
                              context: context,
                              fontsize: 12,
                              color: Colors.black),
                        ),
                        Text(
                          controller.trackOrderList[index].status,
                          style: sizer.style(
                              context: context,
                              fontsize: 15,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
