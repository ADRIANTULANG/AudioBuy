import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Modules/Login/Login_model.dart';
import 'package:audiobuy/Modules/ProviderPage/Providerpage_model.dart';
import 'package:http/http.dart' as http;

class ProviderApi {
// Future<List<Users> >
  static Future<List<Services>> getServicesData({
    required String servicesStoreId,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-services.php"),
        body: {
          'servicesStoreId': servicesStoreId,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);

          return servicesFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('getServicesData catch error $error');
      return Future.error(true);
    }
  }

  static Future create_Services({
    required String serviceName,
    required String servicePrice,
    required String serviceDescription,
    required String serviceStoreID,
    required String serviceImage,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/create-services.php"),
        body: {
          'serviceName': serviceName,
          'servicePrice': servicePrice,
          'serviceDescription': serviceDescription,
          'serviceStoreID': serviceStoreID,
          'serviceImage': serviceImage,
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
          return true;
          // return servicesFromJson(result);
        } else {
          return false;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('create_Services catch error $error');
      return Future.error(true);
    }
  }

  static Future update_Services({
    required String serviceName,
    required String servicePrice,
    required String serviceDescription,
    required String serviceImage,
    required String serviceID,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/update-services.php"),
        body: {
          'serviceName': serviceName,
          'servicePrice': servicePrice,
          'serviceDescription': serviceDescription,
          'serviceImage': serviceImage,
          'serviceID': serviceID
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
          return true;
          // return servicesFromJson(result);
        } else {
          return false;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('update_Services catch error $error');
      return Future.error(true);
    }
  }

  static Future delete_Services({
    required String serviceID,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/delete-services.php"),
        body: {
          'serviceID': serviceID,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          // var result = jsonEncode(jsonDecode(response.body)['data']);

          return true;
          // return servicesFromJson(result);
        } else {
          return false;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('delete_Services catch error $error');
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

  static Future update_Account({
    required String providername,
    required String provideraddress,
    required String providerusername,
    required String providerpassword,
    required String storeid,
    required String providercontact,
    required String providerimage,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/update-account-provider.php"),
        body: {
          'providername': providername,
          'provideraddress': provideraddress,
          'providerusername': providerusername,
          'providerpassword': providerpassword,
          'storeid': storeid,
          'providercontact': providercontact,
          'providerimage': providerimage
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

// Future<List<ServicesForApproval>>
  static Future<List<ServicesForApproval>> get_services_for_approval({
    required String providerid,
    // required String password,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-services-rental-for-approval.php"),
        body: {
          'providerid': providerid,
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
          return servicesForApprovalFromJson(result);
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

  static Future update_order_Status(
      {required String transactionID, required String status}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/update-servicestatus-status.php"),
        body: {
          'transactionID': transactionID,
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
