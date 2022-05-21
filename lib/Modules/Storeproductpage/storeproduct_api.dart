import 'dart:async';
import 'dart:convert';

import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_controller.dart';
import 'package:audiobuy/Modules/Storeproductpage/storeproduct_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StoreProductApi {
// Future<List<Users> >
  static Future<List<StoreDetails>> getStoreDetails({
    required String storeid,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-store-details.php"),
        body: {
          'storeid': storeid,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      // print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          // print(result);
          return StoreDetailsFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('getStoreDetails catch error $error');
      return Future.error(true);
    }
  }

// <List<StoreDetails>>
  static Future<List<Products>> getProducts({
    required String storeid,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-products.php"),
        body: {
          'storeid': storeid,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          // print(result);
          return productsFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('getProducts catch error $error');
      return Future.error(true);
    }
  }

  static Future create_order(
      {required String storeid,
      required String customerid,
      required String datetime,
      required String isDelivery,
      required String contactno}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/create-order.php"),
        body: {
          'storeid': storeid,
          'customerid': customerid,
          'timeStamp': datetime,
          'customercontactno': contactno,
          'isDelivery': isDelivery
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonDecode(response.body)['data'];
          return result;
        } else {
          return "error";
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('create_order catch error $error');
      return Future.error(true);
    }
  }

  static Future insert_ordered_products({
    required String productImage,
    required String productStoreID,
    required String productDescription,
    required String productPrice,
    required String productName,
    required String productID,
    required String productQuantity,
    required String ordernumber,
    required String isDelivery,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/create-order-products.php"),
        body: {
          'productImage': productImage,
          'productStoreID': productStoreID,
          'productDescription': productDescription,
          'productPrice': productPrice,
          'productName': productName,
          'productID': productID,
          'productQuantity': productQuantity,
          'ordernumber': ordernumber,
          'isDelivery': isDelivery
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      print(response.body);
      // print(json.encode(json.decode(response.body)));

      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var message = jsonDecode(response.body)['message'];
          if (message == 'Item not available') {
            Get.find<StoreProductController>().hasUnvailableItem.value = true;
            var itemName = jsonDecode(response.body)['productName'];
            var productID = jsonDecode(response.body)['productID'];
            Get.find<StoreProductController>().notAvailableItemsList.add(
                NotAvailableItemListModel(
                    productName: itemName, productID: productID));
          } else if (message == 'Item not available and available') {
            var itemNameAvailable =
                jsonDecode(response.body)['productNameAvailable'];
            var itemNameUnavailable = jsonDecode(response.body)['productName'];
            var productID = jsonDecode(response.body)['productID'];
            Get.find<StoreProductController>().hasUnvailableItem.value = true;
            Get.find<StoreProductController>().notAvailableItemsList.add(
                NotAvailableItemListModel(
                    productName: itemNameUnavailable, productID: productID));
            Get.find<StoreProductController>().successfulOrdereditemList.add(
                NotAvailableItemListModel(
                    productName: itemNameAvailable, productID: productID));
          } else if (message == 'Success') {
            var itemNameAvailable =
                jsonDecode(response.body)['productNameAvailable'];
            var productID = jsonDecode(response.body)['productID'];
            Get.find<StoreProductController>().successfulOrdereditemList.add(
                NotAvailableItemListModel(
                    productName: itemNameAvailable, productID: productID));
          }
          return true;
        } else {
          return "error";
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('insert_ordered_products catch error $error');
      return Future.error(true);
    }
  }

  static Future send_chat({
    required String storeid,
    required String customerid,
    required String message,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/create-chat.php"),
        body: {'receiver': storeid, 'sender': customerid, 'message': message},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      // print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          // var result = jsonDecode(response.body)['data'];
          // return result;
        } else {
          return "error";
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('send_chat catch error $error');
      return Future.error(true);
    }
  }

  static Future<List<ChatModel>> get_all_Chats({
    required String storeid,
    required String customerid,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-chats.php"),
        body: {
          'storeid': storeid,
          'customerid': customerid,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result =
              chatModelFromJson(jsonEncode(jsonDecode(response.body)['data']));
          return result;
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('get_all_Chats catch error $error');
      return Future.error(true);
    }
  }

  static Future update_seen_Status({
    required String storeid,
    required String customerid,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/update-chat-seen-status.php"),
        body: {
          'storeid': storeid,
          'customerid': customerid,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          // var result =
          //     chatModelFromJson(jsonEncode(jsonDecode(response.body)['data']));
          // return result;
        } else {
          return "error";
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('update_seen_Status catch error $error');
      return Future.error(true);
    }
  }

  static Future delete_chats({
    required String storeid,
    required String customerid,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/delete-chat-history.php"),
        body: {
          'storeid': storeid,
          'customerid': customerid,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          // var result =
          //     chatModelFromJson(jsonEncode(jsonDecode(response.body)['data']));
          // return result;
        } else {
          return "error";
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('delete_chats catch error $error');
      return Future.error(true);
    }
  }

  static Future delete_ordernumber({
    required String ordernumber,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/delete-transaction-unsuccessful-order.php"),
        body: {
          'ordernumber': ordernumber,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          // var result =
          //     chatModelFromJson(jsonEncode(jsonDecode(response.body)['data']));
          // return result;
        } else {
          return "error";
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('delete_ordernumber catch error $error');
      return Future.error(true);
    }
  }
}
