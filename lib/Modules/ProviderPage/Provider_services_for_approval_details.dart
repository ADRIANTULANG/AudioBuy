import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/ProviderPage/ProviderPage_controller.dart';
import 'package:audiobuy/Modules/ProviderPage/Providerpage_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ProviderServiceForApprovalDetails extends GetView<ProviderController> {
  const ProviderServiceForApprovalDetails(
      {Key? key, required this.servicesDetails})
      : super(key: key);
  final ServicesForApproval? servicesDetails;

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
            // Padding(
            //   padding: EdgeInsets.only(
            //     left: sizer.width(width: 2, context: context),
            //     right: sizer.width(width: 2, context: context),
            //   ),
            //   child: Row(
            //     children: [
            //       IconButton(onPressed: () {}, icon: Icon(Icons.call)),
            //       Text(
            //         servicesDetails!.customercontactno,
            //         style: sizer.style(
            //             context: context, fontsize: 12, color: Colors.black),
            //       ),
            //     ],
            //   ),
            // ),
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
            SizedBox(height: sizer.height(height: 1, context: context)),

            Padding(
              padding: EdgeInsets.only(
                  left: sizer.width(width: 5, context: context),
                  right: sizer.width(width: 5, context: context)),
              child: Material(
                elevation: 5.0,

                borderRadius: BorderRadius.circular(30.0),
                // color: Gradient.linear(from, to, colors),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  ),
                  child: MaterialButton(
                    // color:
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {
                      UrlLauncher.launch(
                          'tel:${servicesDetails!.customercontactno}');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: sizer.width(width: 2, context: context),
                        ),
                        Text(
                          servicesDetails!.customercontactno,
                          style: sizer.style(
                              context: context,
                              fontsize: 12,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: sizer.height(height: 1, context: context)),
            Padding(
              padding: EdgeInsets.only(
                  left: sizer.width(width: 5, context: context),
                  right: sizer.width(width: 5, context: context)),
              child: Material(
                elevation: 5.0,

                borderRadius: BorderRadius.circular(30.0),
                // color: Gradient.linear(from, to, colors),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  ),
                  child: MaterialButton(
                    // color:
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {
                      controller.approved_or_cancel(
                          context: context,
                          transactionID: servicesDetails!.transactionNo,
                          status: "Paid");
                    },
                    child: Text("Paid",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                                fontSize:
                                    sizer.font(fontsize: 10, context: context))
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            SizedBox(height: sizer.height(height: 1, context: context)),
            Padding(
              padding: EdgeInsets.only(
                  left: sizer.width(width: 5, context: context),
                  right: sizer.width(width: 5, context: context)),
              child: Material(
                elevation: 5.0,

                borderRadius: BorderRadius.circular(30.0),
                // color: Gradient.linear(from, to, colors),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  ),
                  child: MaterialButton(
                    // color:
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {
                      controller.approved_or_cancel(
                          context: context,
                          transactionID: servicesDetails!.transactionNo,
                          status: "Approved");
                    },
                    child: Text("Approved",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                                fontSize:
                                    sizer.font(fontsize: 10, context: context))
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            SizedBox(height: sizer.height(height: 1, context: context)),
            Padding(
              padding: EdgeInsets.only(
                  left: sizer.width(width: 5, context: context),
                  right: sizer.width(width: 5, context: context)),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                // color: Gradient.linear(from, to, colors),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  ),
                  child: MaterialButton(
                    // color:
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {
                      controller.approved_or_cancel(
                          context: context,
                          transactionID: servicesDetails!.transactionNo,
                          status: "Cancelled");
                    },
                    child: Text("Cancel",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                                fontSize:
                                    sizer.font(fontsize: 10, context: context))
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                  ),
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
