import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Helpers/storage.dart';
import 'package:audiobuy/Modules/Customerpage/Customerpage_model.dart';
import 'package:audiobuy/Modules/Login/Login_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomepageApi {
// Future<List<Users> >
  static Future getCountStores({required String usertype}) async {
    try {
      var response = await http.post(Uri.parse("$endPoint/count-stores.php"),
          body: {
            "usertype": usertype
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonDecode(response.body)['data'];
          print(result);
          var count = result[0]['counts'];
          return count.toString();
        } else {
          return 0.toString();
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('login catch error $error');
      return Future.error(true);
    }
  }

  static Future<List<Stores>> getStores({required String usertype}) async {
    try {
      var response =
          await http.post(Uri.parse("$endPoint/get-stores.php"), body: {
        'usertype': usertype,
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);

          return storesFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('login catch error $error');
      return Future.error(true);
    }
  }

  static Future update_Account({
    required String customername,
    required String customeraddress,
    required String customerusername,
    required String customerpassword,
    required String storeid,
    required String customercontact,
    required String customerimage,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/update-account-customer.php"),
        body: {
          'customername': customername,
          'customeraddress': customeraddress,
          'customerusername': customerusername,
          'customerpassword': customerpassword,
          'storeid': storeid,
          'customercontact': customercontact,
          'customerimage': customerimage
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
      print(response.body);
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

  static Future<List<TrackOrder>> getDataPending() async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-order-pending.php"),
        body: {'customerid': Get.find<StorageService>().box.read('userid')},
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
          return trackOrderFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('getDataApproved catch error $error');
      return Future.error(true);
    }
  }

  static Future<List<TrackOrder>> getHistory() async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-order-history.php"),
        body: {'customerid': Get.find<StorageService>().box.read('userid')},
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
          return trackOrderFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('getHistory catch error $error');
      return Future.error(true);
    }
  }

// Future<List<RentalHistorModel>>
  static Future<List<RentalHistorModel>> getHistoryRental() async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-rental-history.php"),
        body: {'customerid': Get.find<StorageService>().box.read('userid')},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      // print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          return rentalHistorModelFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('getHistoryRental catch error $error');
      return Future.error(true);
    }
  }

  static Future<List<RentalHistorModel>> getRentalPending() async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-rental-pending.php"),
        body: {'customerid': Get.find<StorageService>().box.read('userid')},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      // print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          return rentalHistorModelFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('getRentalApproved catch error $error');
      return Future.error(true);
    }
  }

// Future<List<OrderHistoryDetails>>
  static Future<List<OrderHistoryDetails>> getOrderDetails(
      {required String ordernumber}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-order-history-details.php"),
        body: {'ordernumber': ordernumber},
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
          return orderHistoryDetailsFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('getOrderDetails catch error $error');
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

  static Future count_approved_services({required String status}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/count-approved-services.php"),
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
      print('count_approved_services catch error $error');
      return Future.error(true);
    }
  }
}
