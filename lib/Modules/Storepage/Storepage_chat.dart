import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/Storepage/Storepage_chatbox.dart';
import 'package:audiobuy/Modules/Storepage/Storepage_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class StorepageChat extends GetView<StorepageController> {
  const StorepageChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        title: Text("Chat"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(
            left: sizer.width(width: 3, context: context),
            right: sizer.width(width: 3, context: context)),
        child: Obx(
          () => ListView.builder(
            itemCount: controller.chatsuser.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                    top: sizer.height(height: 1, context: context)),
                child: InkWell(
                  onTap: () {
                    Get.to(() => StorepageChatbox(
                          customerid: controller.chatsuser[index].sender,
                        ));
                    controller.getChat(
                        customerid: controller.chatsuser[index].sender);
                    controller.start_stream_chat(
                        customerid: controller.chatsuser[index].sender);
                    controller.update_seen_status(
                        customerid: controller.chatsuser[index].sender);
                  },
                  child: Container(
                    height: sizer.height(height: 10, context: context),
                    width: sizer.width(width: 100, context: context),
                    child: Row(
                      children: [
                        Container(
                          height: sizer.height(height: 8, context: context),
                          width: sizer.width(width: 20, context: context),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[700],
                              shape: BoxShape.circle),
                          child: Text(
                            controller.chatsuser[index].sender,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    sizer.font(fontsize: 15, context: context)),
                          ),
                        ),
                        SizedBox(
                          width: sizer.width(width: 3, context: context),
                        ),
                        Text(
                          "CustomerID: " + controller.chatsuser[index].sender,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  sizer.font(fontsize: 15, context: context)),
                        )
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
