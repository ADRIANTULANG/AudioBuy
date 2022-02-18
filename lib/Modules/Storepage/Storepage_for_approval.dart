import 'package:audiobuy/Helpers/sizer.dart';

import 'package:audiobuy/Modules/Storepage/Storepage_controller.dart';
import 'package:audiobuy/Modules/Storepage/Storepage_for_approval_Details.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class StoreOrderForApproval extends GetView<StorepageController> {
  const StoreOrderForApproval({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "For Approval",
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
            itemCount: controller.orderForApprovalList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context),
                    top: sizer.width(width: 2, context: context),
                    right: sizer.width(width: 2, context: context)),
                child: GestureDetector(
                  onTap: () {
                    controller.get_order_details(
                        transactionID:
                            controller.orderForApprovalList[index].ordernumber);
                    Get.to(() => StoreForApprovalDetails(
                          contactno: controller
                              .orderForApprovalList[index].customercontactno,
                          ordernumber: controller
                              .orderForApprovalList[index].ordernumber,
                        ));
                  },
                  child: Container(
                    color: Colors.white,
                    height: sizer.height(height: 8, context: context),
                    width: sizer.width(width: 100, context: context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.orderForApprovalList[index].ordernumber,
                          style: sizer.style(
                              context: context,
                              fontsize: 12,
                              color: Colors.black),
                        ),
                        Text(
                          controller.orderForApprovalList[index].timeStamp.year
                                  .toString() +
                              "-" +
                              controller
                                  .orderForApprovalList[index].timeStamp.day
                                  .toString() +
                              "-" +
                              controller
                                  .orderForApprovalList[index].timeStamp.month
                                  .toString(),
                          style: sizer.style(
                              context: context,
                              fontsize: 12,
                              color: Colors.black),
                        ),
                        Text(
                          controller.orderForApprovalList[index].status,
                          style: sizer.style(
                              context: context,
                              fontsize: 15,
                              color: controller.orderForApprovalList[index]
                                              .status ==
                                          "Pending" ||
                                      controller.orderForApprovalList[index]
                                              .status ==
                                          "Cancelled"
                                  ? Colors.red
                                  : controller.orderForApprovalList[index]
                                              .status ==
                                          "Approved"
                                      ? Colors.blueAccent
                                      : Colors.greenAccent),
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
