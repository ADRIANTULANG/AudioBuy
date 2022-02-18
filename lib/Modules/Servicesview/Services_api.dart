import 'dart:async';
import 'dart:convert';

import 'package:audiobuy/Constant/endpoints.dart';
import 'package:audiobuy/Modules/Servicesview/Services_model.dart';
import 'package:http/http.dart' as http;

class ServicesViewApi {
//
  static Future<List<ServicesModel>> get_services({
    required String servicesstoreid,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-services.php"),
        body: {
          'servicesStoreId': servicesstoreid,
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
          return servicesModelFromJson(result);
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

//$customerid = $_POST['customerid'];
//   $servicesID =  $_POST['servicesID'];
// $serviceName =  $_POST['serviceName'];
// $servicePrice =  $_POST['servicePrice'];
// $serviceDescription =  $_POST['serviceDescription'];
// $serviceStoreID =  $_POST['serviceStoreID'];
// $serviceImage=  $_POST['serviceImage'];
// $serviceRentalDate_from=  $_POST['serviceRentalDate_from'];
// $serviceRentalDate_to=  $_POST['serviceRentalDate_to'];
// $note=  $_POST['note'];

  static Future create_rental({
    required String customerid,
    required String servicesID,
    required String serviceName,
    required String servicePrice,
    required String serviceDescription,
    required String serviceStoreID,
    required String serviceImage,
    required String serviceRentalDate_from,
    required String serviceRentalDate_to,
    required String note,
    required String customercontactno,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/create-services-order.php"),
        body: {
          'customerid': customerid,
          'servicesID': servicesID,
          'serviceName': serviceName,
          'servicePrice': servicePrice,
          'serviceDescription': serviceDescription,
          'serviceStoreID': serviceStoreID,
          'serviceImage': serviceImage,
          'serviceRentalDate_from': serviceRentalDate_from,
          'serviceRentalDate_to': serviceRentalDate_to,
          'note': note,
          'customercontactno': customercontactno,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          return true;
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('create_rental catch error $error');
      return Future.error(true);
    }
  }
}
