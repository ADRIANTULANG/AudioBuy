import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Helpers/storage.dart';
import 'package:audiobuy/Modules/Servicesview/Services_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ServicesChat extends GetView<ServicesController> {
  const ServicesChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return Scaffold(
      body: Container(
        height: sizer.height(height: 100, context: context),
        width: sizer.width(width: 100, context: context),
        padding: EdgeInsets.only(
            top: sizer.height(height: 3, context: context),
            left: sizer.width(width: 3, context: context),
            right: sizer.width(width: 3, context: context)),
        child: Column(
          children: [
            // Text("Data"),
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
                        alignment: controller.chats[index].sender.toString() ==
                                Get.find<StorageService>()
                                    .box
                                    .read('userid')
                                    .toString()
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: sizer.height(height: 1, context: context),
                              top: sizer.height(height: 1, context: context),
                              left: sizer.width(width: 4, context: context),
                              right: sizer.width(width: 4, context: context)),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(32)),
                          child:
                              Text(controller.chats[index].message.toString()),
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
                          fontSize: sizer.font(fontsize: 10, context: context)),
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
                      print(" aadsasd ");
                      if (controller.chatTextField.text.isNotEmpty) {
                        print("object");
                        controller.sendMessage();
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
          ],
        ),
      ),
    );
  }
}
