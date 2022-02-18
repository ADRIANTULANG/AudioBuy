import 'dart:convert';

List<ServicesModel> servicesModelFromJson(String str) =>
    List<ServicesModel>.from(
        json.decode(str).map((x) => ServicesModel.fromJson(x)));

String servicesModelToJson(List<ServicesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServicesModel {
  ServicesModel({
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

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
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
