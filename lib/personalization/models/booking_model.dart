
import 'dart:convert';

BookUserModel bookuserModelFromJson(String str) => BookUserModel.fromJson(json.decode(str));

String bookuserModelToJson(BookUserModel data) => json.encode(data.toJson());

class BookUserModel {
  String name;
  String lastname;
  String email;
  String password;
  String phone;
  String regestrationtype;

  BookUserModel({
    required this.name,
    required this.lastname,
    required this.email,
    required this.password,
    required this.phone,
    required this.regestrationtype,
  });

  factory BookUserModel.fromJson(Map<String, dynamic> json) => BookUserModel(
    name: json["name"],
    lastname: json["lastname"],
    email: json["email"],
    password: json["password"],
      phone: json['phone'],
      regestrationtype: json['regestrationtype'],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "lastname": lastname,
    "email": email,
    "password": password,
    "phone" : phone,
    "regestrationtype":   regestrationtype,
  };
}
