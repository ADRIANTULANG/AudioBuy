import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/Customerpage/Customer_rentalHistory_details.dart';
import 'package:audiobuy/Modules/Customerpage/Customerpage_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomerRentalHistory extends GetView<CustomerController> {
  const CustomerRentalHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Rental History",
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
            itemCount: controller.rentalHistory.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context),
                    top: sizer.width(width: 2, context: context),
                    right: sizer.width(width: 2, context: context)),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => CustomerRentalHistoryDetails(
                        servicesDetails: controller.rentalHistory[index]));
                  },
                  child: Container(
                    color: Colors.white,
                    height: sizer.height(height: 8, context: context),
                    width: sizer.width(width: 100, context: context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.rentalHistory[index].transactionNo,
                          style: sizer.style(
                              context: context,
                              fontsize: 12,
                              color: Colors.black),
                        ),
                        Text(
                          "From:" +
                              controller.rentalHistory[index]
                                  .serviceRentalDateFrom.year
                                  .toString() +
                              "-" +
                              controller.rentalHistory[index]
                                  .serviceRentalDateFrom.day
                                  .toString() +
                              "-" +
                              controller.rentalHistory[index]
                                  .serviceRentalDateFrom.month
                                  .toString() +
                              "to:" +
                              controller
                                  .rentalHistory[index].serviceRentalDateTo.year
                                  .toString() +
                              "-" +
                              controller
                                  .rentalHistory[index].serviceRentalDateTo.day
                                  .toString() +
                              "-" +
                              controller.rentalHistory[index]
                                  .serviceRentalDateTo.month
                                  .toString(),
                          style: sizer.style(
                              context: context,
                              fontsize: 12,
                              color: Colors.black),
                        ),
                        Text(
                          controller.rentalHistory[index].status,
                          style: sizer.style(
                              context: context,
                              fontsize: 15,
                              color: controller.rentalHistory[index].status ==
                                          "Pending" ||
                                      controller.rentalHistory[index].status ==
                                          "Cancelled"
                                  ? Colors.red
                                  : controller.rentalHistory[index].status ==
                                          "Paid"
                                      ? Colors.green
                                      : Colors.blue),
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
