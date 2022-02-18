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
    required this.productQuantity,
  });

  String productId;
  String productName;
  String productPrice;
  String productDescription;
  String productStoreId;
  String productImage;
  RxInt productQuantity;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        productQuantity: 0.obs,
        productId: json["productID"],
        productName: json["productName"],
        productPrice: json["productPrice"],
        productDescription: json["ProductDescription"],
        productStoreId: json["productStoreID"],
        productImage: json["productImage"],
      );

  Map<String, dynamic> toJson() => {
        "productQuantity": productQuantity,
        "productID": productId,
        "productName": productName,
        "productPrice": productPrice,
        "ProductDescription": productDescription,
        "productStoreID": productStoreId,
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
