import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/SuccessfulAndUnsuccesfulOrder/UnsuccessfulAndSuccess_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnsuccessfulAndSuccessfulView
    extends GetView<UnsuccessfulSuccessfulController> {
  const UnsuccessfulAndSuccessfulView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UnsuccessfulSuccessfulController());
    Sizer sizer = Sizer();
    return WillPopScope(
      onWillPop: () => controller.getback(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                controller.getback();
              }),
          title: Text(
            "Order Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => controller.successfulItems.isEmpty
                    ? SizedBox(
                        height: sizer.height(height: 2, context: context),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: sizer.height(height: 2, context: context),
                          ),
                          Container(
                            width: sizer.width(width: 100, context: context),
                            alignment: Alignment.center,
                            child: Text(
                              "SUCCESSFUL ORDERED ITEMS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: sizer.height(height: 2, context: context),
                          ),
                          Container(
                            child: Obx(
                              () => ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.successfulItems.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: sizer.height(
                                            height: 1, context: context)),
                                    child: Container(
                                      height: sizer.height(
                                          height: 13, context: context),
                                      width: sizer.width(
                                          width: 90, context: context),
                                      // color: Colors.red,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: sizer.width(
                                                width: 2, context: context),
                                          ),
                                          Container(
                                            height: sizer.height(
                                                height: 12, context: context),
                                            width: sizer.width(
                                                width: 25, context: context),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: sizer.width(
                                                        width: .5,
                                                        context: context)),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        '$imageEndpoint/${controller.successfulItems[index].productImage}')),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          SizedBox(
                                            width: sizer.width(
                                                width: 2, context: context),
                                          ),
                                          Container(
                                            height: sizer.height(
                                                height: 11, context: context),
                                            width: sizer.width(
                                                width: 70, context: context),
                                            child: Text(
                                              controller.successfulItems[index]
                                                  .productName,
                                              // overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
              Obx(
                () => controller.unSuccessfulItems.isEmpty
                    ? SizedBox(
                        height: sizer.height(height: 2, context: context),
                      )
                    : Column(
                        children: [
                          Container(
                            width: sizer.width(width: 100, context: context),
                            alignment: Alignment.center,
                            child: Text(
                              "UNSUCCESSFUL ORDERED ITEMS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: sizer.width(width: 100, context: context),
                            child: Text(
                              "Reason: Out of stocks.",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: sizer.height(height: 2, context: context),
                          ),
                          Container(
                            child: Obx(
                              () => ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.unSuccessfulItems.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: sizer.height(
                                            height: 1, context: context)),
                                    child: Container(
                                      height: sizer.height(
                                          height: 13, context: context),
                                      width: sizer.width(
                                          width: 90, context: context),
                                      // color: Colors.red,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: sizer.width(
                                                width: 2, context: context),
                                          ),
                                          Stack(
                                            children: [
                                              Container(
                                                height: sizer.height(
                                                    height: 12,
                                                    context: context),
                                                width: sizer.width(
                                                    width: 25,
                                                    context: context),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: sizer.width(
                                                            width: .5,
                                                            context: context)),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            '$imageEndpoint/${controller.unSuccessfulItems[index].productImage}')),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                              ),
                                              Positioned(
                                                top: sizer.height(
                                                    height: .5,
                                                    context: context),
                                                left: sizer.width(
                                                    width: -13,
                                                    context: context),
                                                height: sizer.height(
                                                    height: 11,
                                                    context: context),
                                                width: sizer.width(
                                                    width: 50,
                                                    context: context),
                                                child: Container(
                                                  height: sizer.height(
                                                      height: 40,
                                                      context: context),
                                                  width: sizer.width(
                                                      width: 40,
                                                      context: context),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'asset/image/outofstock.png'))),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: sizer.width(
                                                width: 2, context: context),
                                          ),
                                          Container(
                                            height: sizer.height(
                                                height: 11, context: context),
                                            width: sizer.width(
                                                width: 70, context: context),
                                            child: Text(
                                              controller
                                                  .unSuccessfulItems[index]
                                                  .productName,
                                              // overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: sizer.height(height: 9, context: context),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: sizer.width(width: 2, context: context),
                                right: sizer.width(width: 2, context: context)),
                            child: Material(
                              elevation: 5.0,

                              borderRadius: BorderRadius.circular(30.0),
                              // color: Gradient.linear(from, to, colors),
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[700],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(80.0)),
                                ),
                                child: MaterialButton(
                                  // color:
                                  minWidth: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  onPressed: () {
                                    controller.getback();
                                  },
                                  child: Text("D O N E",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                              fontSize: sizer.font(
                                                  fontsize: 10,
                                                  context: context))
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
