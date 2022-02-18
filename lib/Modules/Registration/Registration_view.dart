import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/Registration/Registration_Customer.dart';
import 'package:audiobuy/Modules/Registration/Registration_Service_Provider.dart';
import 'package:audiobuy/Modules/Registration/Registration_Store.dart';
import 'package:audiobuy/Modules/Registration/Registration_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RegistrationController());
    Sizer sizer = Sizer();
    return Scaffold(
      body: Container(
        height: sizer.height(height: 100, context: context),
        width: sizer.width(width: 100, context: context),
        padding: EdgeInsets.only(
            left: sizer.width(width: 3, context: context),
            right: sizer.width(width: 2, context: context)),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                // height: sizer.height(height: 100, context: context),
                // width: sizer.width(width: 100, context: context),
                child: Image.asset(
                  'asset/image/logowithtext.png',
                  height: sizer.height(height: 90, context: context),
                  width: sizer.width(width: 100, context: context),
                ),
              ),
            ),
            Material(
              elevation: 5.0,

              borderRadius: BorderRadius.circular(30.0),
              // color: Gradient.linear(from, to, colors),
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[700],
                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                ),
                child: MaterialButton(
                  // color:
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                    controller.username.clear();
                    controller.password.clear();
                    controller.firstname.clear();
                    controller.imagefilename.value = "";
                    controller.address.clear();
                    controller.contanctno.clear();
                    Get.to(() => RegisterCustomer());
                  },
                  child: Text("Customer",
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
            SizedBox(
              height: sizer.height(height: 1, context: context),
            ),
            Material(
              elevation: 5.0,

              borderRadius: BorderRadius.circular(30.0),
              // color: Gradient.linear(from, to, colors),
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[700],
                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                ),
                child: MaterialButton(
                  // color:
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                    controller.username.clear();
                    controller.password.clear();
                    controller.firstname.clear();
                    controller.imagefilename.value = "";
                    controller.address.clear();
                    controller.contanctno.clear();
                    Get.to(() => RegisterStore());
                  },
                  child: Text("Store",
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
            SizedBox(
              height: sizer.height(height: 1, context: context),
            ),
            Material(
              elevation: 5.0,

              borderRadius: BorderRadius.circular(30.0),
              // color: Gradient.linear(from, to, colors),
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[700],
                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                ),
                child: MaterialButton(
                  // color:
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                    controller.username.clear();
                    controller.password.clear();
                    controller.firstname.clear();
                    controller.imagefilename.value = "";
                    controller.address.clear();
                    controller.contanctno.clear();
                    Get.to(() => RegisterProvider());
                  },
                  child: Text("Service Provider",
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
            SizedBox(
              height: sizer.height(height: 3, context: context),
            ),
          ],
        ),
      ),
    );
  }
}
