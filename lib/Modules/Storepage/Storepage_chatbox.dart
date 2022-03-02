import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Helpers/storage.dart';
import 'package:audiobuy/Modules/Storepage/Storepage_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class StorepageChatbox extends GetView<StorepageController> {
  const StorepageChatbox({Key? key, required this.customerid})
      : super(key: key);
  final String customerid;

  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return WillPopScope(
      onWillPop: () => controller.stopStream(),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
              top: sizer.height(height: 2, context: context),
              left: sizer.width(width: 3, context: context),
              right: sizer.width(width: 3, context: context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Container(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.chats.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: sizer.height(height: 1, context: context)),
                        child: Container(
                          width: sizer.width(width: 100, context: context),
                          alignment:
                              controller.chats[index].sender.toString() ==
                                      Get.find<StorageService>()
                                          .box
                                          .read('userid')
                                          .toString()
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    sizer.height(height: 1, context: context),
                                top: sizer.height(height: 1, context: context),
                                left: sizer.width(width: 4, context: context),
                                right: sizer.width(width: 4, context: context)),
                            decoration: BoxDecoration(
                                color: controller.chats[index].sender
                                            .toString() ==
                                        Get.find<StorageService>()
                                            .box
                                            .read('userid')
                                            .toString()
                                    ? Colors.blueGrey[700]
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(32),
                                border:
                                    controller.chats[index].sender.toString() ==
                                            Get.find<StorageService>()
                                                .box
                                                .read('userid')
                                                .toString()
                                        ? null
                                        : Border.all(color: Colors.black)),
                            child: Text(
                              controller.chats[index].message
                                  .toString()
                                  .capitalizeFirst
                                  .toString(),
                              style: TextStyle(
                                  color: controller.chats[index].sender
                                              .toString() ==
                                          Get.find<StorageService>()
                                              .box
                                              .read('userid')
                                              .toString()
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )),
              Container(
                width: sizer.width(width: 100, context: context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      // color: Colors.red,
                      height: sizer.height(height: 6, context: context),
                      width: sizer.width(width: 85, context: context),
                      child: TextField(
                        obscureText: false,
                        controller: controller.chatTextField,
                        style: TextStyle(
                            fontSize:
                                sizer.font(fontsize: 10, context: context)),
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            // prefixIcon: Icon(Icons.search),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Message",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0))),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (controller.chatTextField.text.isNotEmpty) {
                          controller.sendMessage(customerid: customerid);
                        }
                      },
                      child: Icon(
                        Icons.send_sharp,
                        size: sizer.font(fontsize: 30, context: context),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: sizer.height(height: 2, context: context))
            ],
          ),
        ),
      ),
    );
  }
}
