
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String name;
  String lastname;
  String parentname;
  String email;
  String password;
  String phone;
  String address;
  String scheduleIds;
  String dacc;
  String dob;
  String gender;
  String clubmembership;
  String clubcardcopy;
  String regestrationtype;

  UserModel({
    required this.name,
    required this.lastname,
    required this.parentname,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.scheduleIds,
    required this.dacc,
    required this.dob,
    required this.gender,
    required this.clubmembership,
    required this.clubcardcopy,
    required this.regestrationtype,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    lastname: json["lastname"],
    parentname: json["parentname"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    address: json["address"],
    scheduleIds: json["scheduleIds"],
    dacc: json["dacc"],
    dob: json["dob"],
    gender: json["gender"],
    clubmembership: json["clubmembership"],
    clubcardcopy: json["clubcardcopy"],
      regestrationtype: json['regestrationtype'],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "lastname": lastname,
    "parentname": parentname,
    "email": email,
    "password": password,
    "phone": phone,
    "address": address,
    "scheduleIds": scheduleIds,
    "dacc": dacc,
    "dob": dob,
    "gender": gender,
    "clubmembership": clubmembership,
    "clubcardcopy": clubcardcopy,
    "regestrationtype":   regestrationtype,
  };
}
