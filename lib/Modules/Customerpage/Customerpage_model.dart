import 'dart:convert';

List<Stores> storesFromJson(String str) =>
    List<Stores>.from(json.decode(str).map((x) => Stores.fromJson(x)));

String storesToJson(List<Stores> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stores {
  Stores({
    required this.userid,
    required this.user,
    required this.pass,
    required this.name,
    required this.contactno,
    required this.image,
    required this.address,
    required this.usertype,
  });

  String userid;
  String user;
  String pass;
  String name;
  String contactno;
  String image;
  String address;
  String usertype;

  factory Stores.fromJson(Map<String, dynamic> json) => Stores(
        userid: json["userid"],
        user: json["user"],
        pass: json["pass"],
        name: json["name"],
        contactno: json["contactno"],
        image: json["image"],
        address: json["address"],
        usertype: json["usertype"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "user": user,
        "pass": pass,
        "name": name,
        "contactno": contactno,
        "image": image,
        "address": address,
        "usertype": usertype,
      };
}

List<TrackOrder> trackOrderFromJson(String str) =>
    List<TrackOrder>.from(json.decode(str).map((x) => TrackOrder.fromJson(x)));

String trackOrderToJson(List<TrackOrder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrackOrder {
  TrackOrder({
    required this.orderid,
    required this.ordernumber,
    required this.timeStamp,
    required this.customerid,
    required this.storeid,
    required this.status,
  });

  String orderid;
  String ordernumber;
  DateTime timeStamp;
  String customerid;
  String storeid;
  String status;

  factory TrackOrder.fromJson(Map<String, dynamic> json) => TrackOrder(
        orderid: json["orderid"],
        ordernumber: json["ordernumber"],
        timeStamp: DateTime.parse(json["timeStamp"]),
        customerid: json["customerid"],
        storeid: json["storeid"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "orderid": orderid,
        "ordernumber": ordernumber,
        "timeStamp": timeStamp.toIso8601String(),
        "customerid": customerid,
        "storeid": storeid,
        "status": status,
      };
}

List<RentalHistorModel> rentalHistorModelFromJson(String str) =>
    List<RentalHistorModel>.from(
        json.decode(str).map((x) => RentalHistorModel.fromJson(x)));

String rentalHistorModelToJson(List<RentalHistorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RentalHistorModel {
  RentalHistorModel({
    required this.orderservicesid,
    required this.transactionNo,
    required this.servicesId,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceDescription,
    required this.serviceStoreId,
    required this.serviceImage,
    required this.serviceRentalDateFrom,
    required this.serviceRentalDateTo,
    required this.status,
    required this.note,
    required this.customerid,
    required this.customercontactno,
  });

  String orderservicesid;
  String transactionNo;
  String servicesId;
  String serviceName;
  String servicePrice;
  String serviceDescription;
  String serviceStoreId;
  String serviceImage;
  DateTime serviceRentalDateFrom;
  DateTime serviceRentalDateTo;
  String status;
  String note;
  String customerid;
  String customercontactno;

  factory RentalHistorModel.fromJson(Map<String, dynamic> json) =>
      RentalHistorModel(
        orderservicesid: json["orderservicesid"],
        transactionNo: json["transactionNo"],
        servicesId: json["servicesID"],
        serviceName: json["serviceName"],
        servicePrice: json["servicePrice"],
        serviceDescription: json["serviceDescription"],
        serviceStoreId: json["serviceStoreID"],
        serviceImage: json["serviceImage"],
        serviceRentalDateFrom: DateTime.parse(json["serviceRentalDate_from"]),
        serviceRentalDateTo: DateTime.parse(json["serviceRentalDate_to"]),
        status: json["status"],
        note: json["note"],
        customerid: json["customerid"],
        customercontactno: json["customercontactno"],
      );

  Map<String, dynamic> toJson() => {
        "orderservicesid": orderservicesid,
        "transactionNo": transactionNo,
        "servicesID": servicesId,
        "serviceName": serviceName,
        "servicePrice": servicePrice,
        "serviceDescription": serviceDescription,
        "serviceStoreID": serviceStoreId,
        "serviceImage": serviceImage,
        "serviceRentalDate_from": serviceRentalDateFrom.toIso8601String(),
        "serviceRentalDate_to": serviceRentalDateTo.toIso8601String(),
        "status": status,
        "note": note,
        "customerid": customerid,
        "customercontactno": customercontactno,
      };
}

List<OrderHistoryDetails> orderHistoryDetailsFromJson(String str) =>
    List<OrderHistoryDetails>.from(
        json.decode(str).map((x) => OrderHistoryDetails.fromJson(x)));

String orderHistoryDetailsToJson(List<OrderHistoryDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderHistoryDetails {
  OrderHistoryDetails({
    required this.orderproductId,
    required this.ordernumber,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productStoreId,
    required this.productImage,
    required this.productQuantity,
  });

  String orderproductId;
  String ordernumber;
  String productId;
  String productName;
  String productPrice;
  String productDescription;
  String productStoreId;
  String productImage;
  String productQuantity;

  factory OrderHistoryDetails.fromJson(Map<String, dynamic> json) =>
      OrderHistoryDetails(
        orderproductId: json["orderproductID"],
        ordernumber: json["ordernumber"],
        productId: json["productID"],
        productName: json["productName"],
        productPrice: json["productPrice"],
        productDescription: json["productDescription"],
        productStoreId: json["productStoreID"],
        productImage: json["productImage"],
        productQuantity: json["productQuantity"],
      );

  Map<String, dynamic> toJson() => {
        "orderproductID": orderproductId,
        "ordernumber": ordernumber,
        "productID": productId,
        "productName": productName,
        "productPrice": productPrice,
        "productDescription": productDescription,
        "productStoreID": productStoreId,
        "productImage": productImage,
        "productQuantity": productQuantity,
      };
}
