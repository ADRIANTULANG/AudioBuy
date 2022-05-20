import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/Customerpage/Customerpage_controller.dart';
import 'package:audiobuy/Modules/Customerpage/Customerpage_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerRentalHistoryDetails extends GetView<CustomerController> {
  const CustomerRentalHistoryDetails({Key? key, required this.servicesDetails})
      : super(key: key);
  final RentalHistorModel? servicesDetails;

  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return Scaffold(
      body: Container(
        height: sizer.height(height: 100, context: context),
        width: sizer.width(width: 100, context: context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: sizer.height(height: 30, context: context),
              width: sizer.width(width: 100, context: context),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "$imageEndpoint/${servicesDetails!.serviceImage}"))),
            ),
            SizedBox(
              height: sizer.height(height: 1, context: context),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: sizer.width(width: 2, context: context),
                right: sizer.width(width: 4, context: context),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    servicesDetails!.serviceName,
                    style: sizer.style(
                        context: context, fontsize: 18, color: Colors.black),
                  ),
                  InkWell(
                    onTap: () {
                      controller.showCustomerNote(
                          sizer: sizer,
                          context: context,
                          note: servicesDetails!.note);
                    },
                    child: Icon(
                      Icons.list_alt,
                      size: sizer.font(fontsize: 30, context: context),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: sizer.width(width: 2, context: context),
                right: sizer.width(width: 2, context: context),
              ),
              child: Text(
                "₱ " + servicesDetails!.servicePrice,
                style: sizer.style(
                    context: context, fontsize: 13, color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: sizer.width(width: 2, context: context),
                right: sizer.width(width: 2, context: context),
              ),
              child: Text(
                "From: " +
                    servicesDetails!.serviceRentalDateFrom.year.toString() +
                    "-" +
                    servicesDetails!.serviceRentalDateFrom.month.toString() +
                    "-" +
                    servicesDetails!.serviceRentalDateFrom.day.toString(),
                style: sizer.style(
                    context: context, fontsize: 12, color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: sizer.width(width: 2, context: context),
                right: sizer.width(width: 2, context: context),
              ),
              child: Text(
                "To: " +
                    servicesDetails!.serviceRentalDateTo.year.toString() +
                    "-" +
                    servicesDetails!.serviceRentalDateTo.month.toString() +
                    "-" +
                    servicesDetails!.serviceRentalDateTo.day.toString(),
                style: sizer.style(
                    context: context, fontsize: 12, color: Colors.black),
              ),
            ),
            SizedBox(
              height: sizer.height(height: 1, context: context),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: sizer.width(width: 2, context: context),
                  right: sizer.width(width: 2, context: context),
                ),
                child: Text(
                  servicesDetails!.serviceDescription,
                  style: sizer.style(
                      context: context, fontsize: 10, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: sizer.height(height: 3, context: context)),
          ],
        ),
      ),
    );
  }
}
