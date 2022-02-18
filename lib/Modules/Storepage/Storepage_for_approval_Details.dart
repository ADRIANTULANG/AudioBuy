import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/Storepage/Storepage_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class StoreForApprovalDetails extends GetView<StorepageController> {
  const StoreForApprovalDetails(
      {Key? key, required this.ordernumber, required this.contactno})
      : super(key: key);
  final String? ordernumber;
  final String? contactno;

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
                  itemCount: controller.orderForApprovalOrderDetails.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        height: sizer.height(height: 15, context: context),
                        width: sizer.width(width: 100, context: context),
                        child: Row(
                          children: [
                            Container(
                              height:
                                  sizer.height(height: 13, context: context),
                              width: sizer.width(width: 30, context: context),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          '$imageEndpoint/${controller.orderForApprovalOrderDetails[index].productImage}'))),
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
                                        .orderForApprovalOrderDetails[index]
                                        .productName
                                        .trim(),
                                    style: sizer.style(
                                        context: context,
                                        fontsize: 12,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "₱ " +
                                        controller
                                            .orderForApprovalOrderDetails[index]
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
                      UrlLauncher.launch('tel:${contactno!}');
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
                          contactno!,
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
                          transactionID: ordernumber!,
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
                          transactionID: ordernumber!,
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
                          transactionID: ordernumber!,
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
