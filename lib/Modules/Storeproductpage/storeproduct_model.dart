import 'dart:convert';

import 'package:get/get.dart';

List<StoreDetails> StoreDetailsFromJson(String str) => List<StoreDetails>.from(
    json.decode(str).map((x) => StoreDetails.fromJson(x)));

String StoreDetailsToJson(List<StoreDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreDetails {
  StoreDetails({
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

  factory StoreDetails.fromJson(Map<String, dynamic> json) => StoreDetails(
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

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  Products({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productStoreId,
    required this.productImage,
    required this.productCount,
    required this.productQuantity,
  });

  String productId;
  String productName;
  String productPrice;
  String productDescription;
  String productStoreId;
  String productImage;
  String productCount;
  RxInt productQuantity;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        productQuantity: 0.obs,
        productId: json["productID"],
        productName: json["productName"],
        productPrice: json["productPrice"],
        productDescription: json["ProductDescription"],
        productStoreId: json["productStoreID"],
        productCount: json["productCount"],
        productImage: json["productImage"],
      );

  Map<String, dynamic> toJson() => {
        "productQuantity": productQuantity,
        "productID": productId,
        "productName": productName,
        "productPrice": productPrice,
        "ProductDescription": productDescription,
        "productStoreID": productStoreId,
        "productCount": productCount,
        "productImage": productImage,
      };
}

List<CartModel> cartModelFromJson(String str) =>
    List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
  CartModel({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productStoreId,
    required this.productImage,
    required this.productQuantity,
  });

  String productId;
  String productName;
  String productPrice;
  String productDescription;
  String productStoreId;
  String productImage;
  int productQuantity;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        productId: json["productId"],
        productName: json["productName"],
        productPrice: json["productPrice"],
        productDescription: json["productDescription"],
        productStoreId: json["productStoreId"],
        productImage: json["productImage"],
        productQuantity: json["productQuantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "productPrice": productPrice,
        "productDescription": productDescription,
        "productStoreId": productStoreId,
        "productImage": productImage,
        "productQuantity": productQuantity,
      };
}

List<ChatModel> chatModelFromJson(String str) =>
    List<ChatModel>.from(json.decode(str).map((x) => ChatModel.fromJson(x)));

String chatModelToJson(List<ChatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatModel {
  ChatModel({
    required this.chatid,
    required this.message,
    required this.sender,
    required this.receiver,
    required this.seen,
    required this.date,
  });

  String chatid;
  String message;
  String sender;
  String receiver;
  String seen;
  DateTime date;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        chatid: json["chatid"],
        message: json["message"],
        sender: json["sender"],
        receiver: json["receiver"],
        seen: json["seen"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "chatid": chatid,
        "message": message,
        "sender": sender,
        "receiver": receiver,
        "seen": seen,
        "date": date.toIso8601String(),
      };
}

List<NotAvailableItemListModel> notAvailableItemListModelFromJson(String str) =>
    List<NotAvailableItemListModel>.from(
        json.decode(str).map((x) => NotAvailableItemListModel.fromJson(x)));

String notAvailableItemListModelToJson(List<NotAvailableItemListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotAvailableItemListModel {
  NotAvailableItemListModel({
    required this.productName,
  });

  String productName;

  factory NotAvailableItemListModel.fromJson(Map<String, dynamic> json) =>
      NotAvailableItemListModel(
        productName: json["productName"],
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
      };
}
