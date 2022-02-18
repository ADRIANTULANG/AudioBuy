import 'dart:convert';

List<Services> servicesFromJson(String str) =>
    List<Services>.from(json.decode(str).map((x) => Services.fromJson(x)));

String servicesToJson(List<Services> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Services {
  Services({
    required this.servicesId,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceDescription,
    required this.serviceStoreId,
    required this.serviceImage,
  });

  String servicesId;
  String serviceName;
  String servicePrice;
  String serviceDescription;
  String serviceStoreId;
  String serviceImage;

  factory Services.fromJson(Map<String, dynamic> json) => Services(
        servicesId: json["servicesID"],
        serviceName: json["serviceName"],
        servicePrice: json["servicePrice"],
        serviceDescription: json["serviceDescription"],
        serviceStoreId: json["serviceStoreID"],
        serviceImage: json["serviceImage"],
      );

  Map<String, dynamic> toJson() => {
        "servicesID": servicesId,
        "serviceName": serviceName,
        "servicePrice": servicePrice,
        "serviceDescription": serviceDescription,
        "serviceStoreID": serviceStoreId,
        "serviceImage": serviceImage,
      };
}

List<ServicesForApproval> servicesForApprovalFromJson(String str) =>
    List<ServicesForApproval>.from(
        json.decode(str).map((x) => ServicesForApproval.fromJson(x)));

String servicesForApprovalToJson(List<ServicesForApproval> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServicesForApproval {
  ServicesForApproval({
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

  factory ServicesForApproval.fromJson(Map<String, dynamic> json) =>
      ServicesForApproval(
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
