import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Helpers/storage.dart';
import 'package:audiobuy/Modules/Login/Login_model.dart';
import 'package:audiobuy/Modules/Storepage/Storepage_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StoreApi {
// Future<List<Users> >
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
      // print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);

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

  static Future checkProduct({
    required String productname,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/check-products.php"),
        body: {
          'productname': productname,
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

          print(result);
          if (result == "[]") {
            return "Valid";
          } else {
            return "Invalid";
          }
        } else {
          return "Error";
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('checkProduct catch error $error');
      return Future.error(true);
    }
  }

  static Future checkAccount({
    required String username,
    required String password,
    required String id,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/check-credentials-update.php"),
        body: {
          'username': username,
          'password': password,
          'userid': id,
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

          print(result);
          if (result == "[]") {
            return "Valid";
          } else {
            return "Invalid";
          }
        } else {
          return "Error";
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('checkAccount catch error $error');
      return Future.error(true);
    }
  }

  static Future create_products(
      {required String productname,
      required String productPrice,
      required String ProductDescription,
      required String productStoreID,
      required String productImage,
      required String productCount,
      required File? imageFile}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/create-products.php"),
        body: {
          'productname': productname,
          'productPrice': productPrice,
          'ProductDescription': ProductDescription,
          'productStoreID': productStoreID,
          'productImage': productImage,
          'productCount': productCount,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      // print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          if (productImage != 'no-image.jpg') {
            insertimage(
                path: imageFile!.path,
                imagename: productImage,
                imagefile: imageFile);
          }
          return true;
        } else {
          return false;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('create_products catch error $error');
      return Future.error(true);
    }
  }

  static Future insertimage(
      {required String path,
      required String imagename,
      required File? imagefile}) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("$endPoint/multipart-image-insert.php"),
      );
      request.fields['name'] = imagename;
      var pic = await http.MultipartFile.fromPath("image", imagefile!.path);
      request.files.add(pic);
      var response = await request.send();
      if (response.statusCode == 200) {
        print("done!");
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('insertimage catch error $error');
      return Future.error(true);
    }
  }

  static Future delete_items({
    required String productid,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/delete-products.php"),
        body: {
          'productid': productid,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      // print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('delete_items catch error $error');
      return Future.error(true);
    }
  }

  static Future update_product({
    required String productname,
    required String productPrice,
    required String productDescription,
    required String productImage,
    required String productCount,
    required File? imageFile,
    required String productid,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/update-products.php"),
        body: {
          'productid': productid,
          'productname': productname,
          'productDescription': productDescription,
          'productImage': productImage,
          'productPrice': productPrice,
          'productCount': productCount,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      // print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('delete_items catch error $error');
      return Future.error(true);
    }
  }

  static Future update_Account({
    required String storename,
    required String storeaddress,
    required String storeusername,
    required String storepassword,
    required String storeid,
    required String storecontactno,
    required String storeimage,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/update-account.php"),
        body: {
          'storename': storename,
          'storeaddress': storeaddress,
          'storeusername': storeusername,
          'storepassword': storepassword,
          'storeid': storeid,
          'storecontactno': storecontactno,
          'storeimage': storeimage
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        print(status);
        return true;
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('update_Account catch error $error');
      return Future.error(true);
    }
  }

  static Future<List<Users>> getuser({
    required String username,
    required String password,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-user.php"),
        body: {
          'username': username,
          'password': password,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          print(result);
          return usersFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('getuser catch error $error');
      return Future.error(true);
    }
  }

  static Future<List<OrdersForApproval>> get_store_orders() async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-stores-order-for-approval.php"),
        body: {
          'storeid': Get.find<StorageService>().box.read('userid'),
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          return ordersForApprovalFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('get_store_orders catch error $error');
      return Future.error(true);
    }
  }

// Future<List<OrdersForApprovalDetails>>
  static Future<List<OrdersForApprovalDetails>> get_order_for_approval_Details(
      {required String ordernumber}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-stores-order-for-approval-details.php"),
        body: {
          'ordernumber': ordernumber,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);

          return ordersForApprovalDetailsFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('get_order_for_approval_Details catch error $error');
      return Future.error(true);
    }
  }

  // update-ordernumber-status

  static Future update_order_Status(
      {required String ordernumber, required String status}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/update-ordernumber-status.php"),
        body: {
          'ordernumber': ordernumber,
          'status': status,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('update_order_Status catch error $error');
      return Future.error(true);
    }
  }

  static Future count_approved_orders({required String status}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/count-approved-order.php"),
        body: {'status': status},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      // print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonDecode(response.body)['data'];
          // print(result);
          result = int.parse(result[0]['counts'].toString());
          // print(result);
          return result;
        } else {
          return "Error";
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('count_approved_orders catch error $error');
      return Future.error(true);
    }
  }

//
  static Future<List<ChatModelOfStore>> get_users_Chats(
      {required String storeid}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-chats-of-store.php"),
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

          return chatModelOfStoreFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('get_users_Chats catch error $error');
      return Future.error(true);
    }
  }

  static Future send_chats({
    required String storeid,
    required String customerid,
    required String message,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/create-chat.php"),
        body: {'receiver': customerid, 'sender': storeid, 'message': message},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      print(response.body);
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
          'storeid': customerid,
          'customerid': storeid,
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

  static Future count_chats({
    required String storeid,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/count-chats.php"),
        body: {
          'storeid': storeid,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonDecode(response.body)['data'];
          var counts = int.parse(result[0]['counts']);
          print(counts);
          print(counts.runtimeType);
          return counts;
        } else {
          return 0;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('update_seen_Status catch error $error');
      return Future.error(true);
    }
  }
}
