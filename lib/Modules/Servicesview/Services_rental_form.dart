import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/Servicesview/Services_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ServicesApplicationForm extends GetView<ServicesController> {
  const ServicesApplicationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Rental Form",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Container(
            height: sizer.height(height: 100, context: context),
            width: sizer.width(width: 100, context: context),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(width: 1, color: Colors.black)),
            child: Padding(
              padding: EdgeInsets.only(
                  right: sizer.width(width: 2, context: context),
                  left: sizer.width(width: 2, context: context),
                  top: sizer.height(height: 1, context: context)),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: sizer.width(width: 100, context: context),
                    height: sizer.height(height: 20, context: context),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "$imageEndpoint/${controller.selectedService!.serviceImage}"))),
                  ),
                  SizedBox(
                    height: sizer.height(height: 1, context: context),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: sizer.width(width: 100, context: context),
                    child: Text(controller.selectedService!.serviceName,
                        style: sizer.style(
                            context: context,
                            fontsize: 13,
                            color: Colors.black)),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: sizer.width(width: 100, context: context),
                    child: Text("₱ " + controller.selectedService!.servicePrice,
                        style: sizer.style(
                            context: context,
                            fontsize: 10,
                            color: Colors.black54)),
                  ),
                  SizedBox(
                    height: sizer.height(height: 1, context: context),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      width: sizer.width(width: 100, context: context),
                      child: Text(
                        controller.selectedService!.serviceDescription,
                        style: sizer.style(
                            context: context,
                            fontsize: 10,
                            color: Colors.black54),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: sizer.width(width: 2.6, context: context),
                    ),
                    alignment: Alignment.centerLeft,
                    width: sizer.width(width: 100, context: context),
                    child: Text("Select Rental Date",
                        style: TextStyle(
                            fontSize:
                                sizer.font(fontsize: 13.5, context: context),
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  ),
                  SfDateRangePicker(
                    onSelectionChanged: controller.onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.range,
                  ),
                  Container(
                    alignment: Alignment.center,
                    // color: Colors.red,
                    height: sizer.height(height: 15, context: context),
                    width: sizer.width(width: 100, context: context),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      obscureText: false,
                      controller: controller.note,
                      style: TextStyle(
                          fontSize: sizer.font(fontsize: 10, context: context)),
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(
                                bottom: sizer.height(
                                    height: 8.5, context: context)),
                            child: Icon(Icons.format_list_bulleted_rounded),
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Leave a note",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                    ),
                  ),
                  SizedBox(
                    height: sizer.height(height: 1, context: context),
                  ),
                  Material(
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
                          controller.rentNow(context: context);
                        },
                        child: Obx(
                          () => controller.isLoadingRental.value == true
                              ? Center(
                                  child: SpinKitThreeBounce(
                                    color: Colors.white,
                                    size: sizer.font(
                                        fontsize: 10, context: context),
                                  ),
                                )
                              : Text("Rent now",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                          fontSize: sizer.font(
                                              fontsize: 10, context: context))
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizer.height(height: 1, context: context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
