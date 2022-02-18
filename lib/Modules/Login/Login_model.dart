import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  Users({
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

  factory Users.fromJson(Map<String, dynamic> json) => Users(
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
