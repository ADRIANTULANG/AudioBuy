import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/Customerpage/Customer_orderhistory_details.dart';
import 'package:audiobuy/Modules/Customerpage/Customerpage_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomerOrderHistory extends GetView<CustomerController> {
  const CustomerOrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Order History",
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
            itemCount: controller.historyList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context),
                    top: sizer.width(width: 2, context: context),
                    right: sizer.width(width: 2, context: context)),
                child: GestureDetector(
                  onTap: () {
                    controller.get_order_Details(
                        ordernumber: controller.historyList[index].ordernumber);
                    Get.to(() => CustomerOrderHistoryDetails(
                        orderStatus: controller.historyList[index].status,
                        isDelivery: controller.historyList[index].isDelivery,
                        ordernumber:
                            controller.historyList[index].ordernumber));
                  },
                  child: Container(
                    color: Colors.white,
                    height: sizer.height(height: 8, context: context),
                    width: sizer.width(width: 100, context: context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.historyList[index].ordernumber,
                          style: sizer.style(
                              context: context,
                              fontsize: 12,
                              color: Colors.black),
                        ),
                        Text(
                          controller.historyList[index].timeStamp.year
                                  .toString() +
                              "-" +
                              controller.historyList[index].timeStamp.day
                                  .toString() +
                              "-" +
                              controller.historyList[index].timeStamp.month
                                  .toString(),
                          style: sizer.style(
                              context: context,
                              fontsize: 12,
                              color: Colors.black),
                        ),
                        Text(
                          controller.historyList[index].status,
                          style: sizer.style(
                              context: context,
                              fontsize: 15,
                              color: controller.historyList[index].status ==
                                          "Pending" ||
                                      controller.historyList[index].status ==
                                          "Cancelled"
                                  ? Colors.red
                                  : controller.historyList[index].status ==
                                          "Approved"
                                      ? Colors.blue
                                      : Colors.green),
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
