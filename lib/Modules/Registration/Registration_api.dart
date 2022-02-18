import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audiobuy/Constant/endpoints.dart';
import 'package:http/http.dart' as http;

class RegistrationApi {
// Future<List<Bus>>
  static Future create_user(
      {required String username,
      required String password,
      required String firstname,
      required String contactno,
      required String address,
      required String image,
      required String usertype,
      required File? imagefile}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/create-user.php"),
        body: {
          'username': username,
          'password': password,
          'name': firstname,
          'contactno': contactno,
          'address': address,
          'usertype': usertype,
          'image': image,
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
        } else {
          return false;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('create_user catch error $error');
      return Future.error(true);
    }
  }

  static Future check_credentials({
    required String username,
    required String password,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/check-credentials.php"),
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
          print("result :${result}");
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
      print('create_user catch error $error');
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
}
