import 'package:audiobuy/Modules/Storeproductpage/storeproduct_controller.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_model.dart';
import 'package:get/get.dart';

class UnsuccessfulSuccessfulController extends GetxController {
  RxList<CartModel> successfulItems = <CartModel>[].obs;
  RxList<CartModel> unSuccessfulItems = <CartModel>[].obs;
  @override
  void onInit() {
    for (var i = 0;
        i < Get.find<StoreProductController>().notAvailableItemsList.length;
        i++) {
      for (var x = 0;
          x < Get.find<StoreProductController>().cartList.length;
          x++) {
        if (Get.find<StoreProductController>()
                .notAvailableItemsList[i]
                .productID ==
            Get.find<StoreProductController>().cartList[x].productId) {
          unSuccessfulItems.add(CartModel(
              productId:
                  Get.find<StoreProductController>().cartList[x].productId,
              productName: Get.find<StoreProductController>()
                  .notAvailableItemsList[i]
                  .productName,
              productPrice:
                  Get.find<StoreProductController>().cartList[x].productPrice,
              productDescription: Get.find<StoreProductController>()
                  .cartList[x]
                  .productDescription,
              productStoreId:
                  Get.find<StoreProductController>().cartList[x].productStoreId,
              productImage:
                  Get.find<StoreProductController>().cartList[x].productImage,
              productQuantity: Get.find<StoreProductController>()
                  .cartList[x]
                  .productQuantity));
        }
      }
    }

    for (var i = 0;
        i < Get.find<StoreProductController>().successfulOrdereditemList.length;
        i++) {
      for (var x = 0;
          x < Get.find<StoreProductController>().cartList.length;
          x++) {
        if (Get.find<StoreProductController>()
                .successfulOrdereditemList[i]
                .productID ==
            Get.find<StoreProductController>().cartList[x].productId) {
          successfulItems.add(CartModel(
              productId:
                  Get.find<StoreProductController>().cartList[x].productId,
              productName: Get.find<StoreProductController>()
                  .successfulOrdereditemList[i]
                  .productName,
              productPrice:
                  Get.find<StoreProductController>().cartList[x].productPrice,
              productDescription: Get.find<StoreProductController>()
                  .cartList[x]
                  .productDescription,
              productStoreId:
                  Get.find<StoreProductController>().cartList[x].productStoreId,
              productImage:
                  Get.find<StoreProductController>().cartList[x].productImage,
              productQuantity: Get.find<StoreProductController>()
                  .cartList[x]
                  .productQuantity));
        }
      }
    }
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getback() {
    if (Get.find<StoreProductController>().isRegisteredProductDetails.value ==
        true) {
      Get.back();
      Get.back();
      Get.back();
    } else {
      Get.back();
      Get.back();
    }
  }
}
