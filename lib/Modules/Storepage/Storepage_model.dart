import 'dart:convert';

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
  });

  String productId;
  String productName;
  String productPrice;
  String productDescription;
  String productStoreId;
  String productImage;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        productId: json["productID"],
        productName: json["productName"],
        productPrice: json["productPrice"],
        productDescription: json["ProductDescription"],
        productStoreId: json["productStoreID"],
        productImage: json["productImage"],
      );

  Map<String, dynamic> toJson() => {
        "productID": productId,
        "productName": productName,
        "productPrice": productPrice,
        "ProductDescription": productDescription,
        "productStoreID": productStoreId,
        "productImage": productImage,
      };
}

List<OrdersForApproval> ordersForApprovalFromJson(String str) =>
    List<OrdersForApproval>.from(
        json.decode(str).map((x) => OrdersForApproval.fromJson(x)));

String ordersForApprovalToJson(List<OrdersForApproval> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrdersForApproval {
  OrdersForApproval({
    required this.orderid,
    required this.ordernumber,
    required this.timeStamp,
    required this.customerid,
    required this.storeid,
    required this.customercontactno,
    required this.status,
    required this.seen,
  });

  String orderid;
  String ordernumber;
  DateTime timeStamp;
  String customerid;
  String storeid;
  String customercontactno;
  String status;
  String seen;

  factory OrdersForApproval.fromJson(Map<String, dynamic> json) =>
      OrdersForApproval(
        orderid: json["orderid"],
        ordernumber: json["ordernumber"],
        timeStamp: DateTime.parse(json["timeStamp"]),
        customerid: json["customerid"],
        storeid: json["storeid"],
        customercontactno: json["customercontactno"],
        status: json["status"],
        seen: json["seen"],
      );

  Map<String, dynamic> toJson() => {
        "orderid": orderid,
        "ordernumber": ordernumber,
        "timeStamp": timeStamp.toIso8601String(),
        "customerid": customerid,
        "storeid": storeid,
        "customercontactno": customercontactno,
        "status": status,
        "seen": seen,
      };
}

List<OrdersForApprovalDetails> ordersForApprovalDetailsFromJson(String str) =>
    List<OrdersForApprovalDetails>.from(
        json.decode(str).map((x) => OrdersForApprovalDetails.fromJson(x)));

String ordersForApprovalDetailsToJson(List<OrdersForApprovalDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrdersForApprovalDetails {
  OrdersForApprovalDetails({
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

  factory OrdersForApprovalDetails.fromJson(Map<String, dynamic> json) =>
      OrdersForApprovalDetails(
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

List<ChatModelOfStore> chatModelOfStoreFromJson(String str) =>
    List<ChatModelOfStore>.from(
        json.decode(str).map((x) => ChatModelOfStore.fromJson(x)));

String chatModelOfStoreToJson(List<ChatModelOfStore> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatModelOfStore {
  ChatModelOfStore({
    required this.sender,
  });

  String sender;

  factory ChatModelOfStore.fromJson(Map<String, dynamic> json) =>
      ChatModelOfStore(
        sender: json["sender"],
      );

  Map<String, dynamic> toJson() => {
        "sender": sender,
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
