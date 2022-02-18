import 'dart:async';
import 'dart:convert';

import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Modules/Login/Login_model.dart';
import 'package:http/http.dart' as http;

class LoginApi {
// Future<List<Users> >
  static Future<List<Users>> login({
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
      print('login catch error $error');
      return Future.error(true);
    }
  }
}
