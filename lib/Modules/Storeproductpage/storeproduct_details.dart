import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Helpers/sizer.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_checkout.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreProductDetailsView extends GetView<StoreProductController> {
  const StoreProductDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        height: sizer.height(height: 100, context: context),
        width: sizer.width(width: 100, context: context),
        child: Column(
          children: [
            Container(
              height: sizer.height(height: 40, context: context),
              width: sizer.width(width: 100, context: context),
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "$imageEndpoint/${controller.selectedProduct!.productImage}"),
              )),
            ),
            SizedBox(
              height: sizer.height(height: 1, context: context),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                left: sizer.width(width: 2, context: context),
                right: sizer.width(width: 2, context: context),
              ),
              child: Text(
                controller.selectedProduct!.productName,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: sizer.font(fontsize: 17, context: context)),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                left: sizer.width(width: 2, context: context),
                right: sizer.width(width: 2, context: context),
              ),
              child: Text(
                "₱ " +
                    double.parse(controller.selectedProduct!.productPrice)
                        .toStringAsFixed(2),
                style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w700,
                    fontSize: sizer.font(fontsize: 15, context: context)),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                left: sizer.width(width: 2, context: context),
                right: sizer.width(width: 2, context: context),
              ),
              child: Text(
                controller.selectedProduct!.productCount == "1"
                    ? "Stocks: " +
                        controller.selectedProduct!.productCount +
                        "pc."
                    : "Stocks: " +
                        controller.selectedProduct!.productCount +
                        "pcs.",
                style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w700,
                    fontSize: sizer.font(fontsize: 15, context: context)),
              ),
            ),
            SizedBox(
              height: sizer.height(height: 1, context: context),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(
                  left: sizer.width(width: 2, context: context),
                  right: sizer.width(width: 2, context: context),
                ),
                child: Text(
                  controller.selectedProduct!.productDescription,
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w700,
                      fontSize: sizer.font(fontsize: 11, context: context)),
                ),
              ),
            ),
            Container(
              // color: Colors.red,
              height: sizer.height(height: 8, context: context),
              width: sizer.width(width: 100, context: context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: sizer.height(height: 8, context: context),
                    width: sizer.width(width: 13, context: context),
                    decoration: BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                    child: IconButton(
                      onPressed: () {
                        if (controller.selectedProduct!.productQuantity.value ==
                            0) {
                        } else {
                          controller.selectedProduct!.productQuantity.value--;
                        }
                      },
                      icon: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    child: Obx(
                      () => Text(
                        controller.selectedProduct!.productQuantity.value
                            .toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                sizer.font(fontsize: 25, context: context)),
                      ),
                    ),
                  ),
                  Container(
                    height: sizer.height(height: 8, context: context),
                    width: sizer.width(width: 13, context: context),
                    decoration: BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                    child: IconButton(
                      onPressed: () {
                        if (int.parse(
                                controller.selectedProduct!.productCount) <=
                            controller.selectedProduct!.productQuantity.value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Max quantity reached!')));
                        } else {
                          controller.selectedProduct!.productQuantity.value++;
                        }
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: sizer.height(height: 2, context: context),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.black,
              height: sizer.height(height: 8, context: context),
              // width: sizer.width(width: 100, context: context),
              child: TextButton(
                onPressed: () async {
                  await controller.add_to_Cart();
                  Get.to(() => StoreProductsCheckoutView());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag,
                        color: Colors.white,
                        size: sizer.font(fontsize: 25, context: context)),
                    SizedBox(width: sizer.width(width: 5, context: context)),
                    Text(
                      "Buy now",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: sizer.font(fontsize: 13, context: context)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
