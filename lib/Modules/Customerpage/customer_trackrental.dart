import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/Customerpage/Customer_rentalHistory_details.dart';
import 'package:audiobuy/Modules/Customerpage/Customerpage_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomerTrackRental extends GetView<CustomerController> {
  const CustomerTrackRental({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Track Rentals",
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
            itemCount: controller.trackRental.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context),
                    top: sizer.width(width: 2, context: context),
                    right: sizer.width(width: 2, context: context)),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => CustomerRentalHistoryDetails(
                        servicesDetails: controller.trackRental[index]));
                  },
                  child: Container(
                    color: Colors.white,
                    height: sizer.height(height: 8, context: context),
                    width: sizer.width(width: 100, context: context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.trackRental[index].transactionNo,
                          style: sizer.style(
                              context: context,
                              fontsize: 12,
                              color: Colors.black),
                        ),
                        Text(
                          "From:" +
                              controller
                                  .trackRental[index].serviceRentalDateFrom.year
                                  .toString() +
                              "-" +
                              controller
                                  .trackRental[index].serviceRentalDateFrom.day
                                  .toString() +
                              "-" +
                              controller.trackRental[index]
                                  .serviceRentalDateFrom.month
                                  .toString() +
                              " to:" +
                              controller
                                  .trackRental[index].serviceRentalDateTo.year
                                  .toString() +
                              "-" +
                              controller
                                  .trackRental[index].serviceRentalDateTo.day
                                  .toString() +
                              "-" +
                              controller
                                  .trackRental[index].serviceRentalDateTo.month
                                  .toString(),
                          style: sizer.style(
                              context: context,
                              fontsize: 12,
                              color: Colors.black),
                        ),
                        Text(
                          controller.trackRental[index].status,
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
