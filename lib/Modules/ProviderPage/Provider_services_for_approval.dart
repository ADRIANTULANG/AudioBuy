import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/ProviderPage/ProviderPage_controller.dart';
import 'package:audiobuy/Modules/ProviderPage/Provider_services_for_approval_details.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProviderServicesForApproval extends GetView<ProviderController> {
  const ProviderServicesForApproval({Key? key}) : super(key: key);

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
            itemCount: controller.serviceForApprovalList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context),
                    top: sizer.width(width: 2, context: context),
                    right: sizer.width(width: 2, context: context)),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ProviderServiceForApprovalDetails(
                        servicesDetails:
                            controller.serviceForApprovalList[index]));
                  },
                  child: Container(
                    color: Colors.white,
                    height: sizer.height(height: 8, context: context),
                    width: sizer.width(width: 100, context: context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller
                              .serviceForApprovalList[index].transactionNo,
                          style: sizer.style(
                              context: context,
                              fontsize: 12,
                              color: Colors.black),
                        ),
                        Text(
                          "From: " +
                              controller.serviceForApprovalList[index]
                                  .serviceRentalDateFrom.year
                                  .toString() +
                              "-" +
                              controller.serviceForApprovalList[index]
                                  .serviceRentalDateFrom.day
                                  .toString() +
                              "-" +
                              controller.serviceForApprovalList[index]
                                  .serviceRentalDateFrom.month
                                  .toString() +
                              " To: " +
                              controller.serviceForApprovalList[index]
                                  .serviceRentalDateTo.year
                                  .toString() +
                              "-" +
                              controller.serviceForApprovalList[index]
                                  .serviceRentalDateTo.day
                                  .toString() +
                              "-" +
                              controller.serviceForApprovalList[index]
                                  .serviceRentalDateTo.month
                                  .toString(),
                          style: sizer.style(
                              context: context,
                              fontsize: 12,
                              color: Colors.black),
                        ),
                        Text(
                          controller.serviceForApprovalList[index].status,
                          style: sizer.style(
                              context: context,
                              fontsize: 15,
                              color: controller.serviceForApprovalList[index]
                                              .status ==
                                          "Pending" ||
                                      controller.serviceForApprovalList[index]
                                              .status ==
                                          "Cancelled"
                                  ? Colors.red
                                  : controller.serviceForApprovalList[index]
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
