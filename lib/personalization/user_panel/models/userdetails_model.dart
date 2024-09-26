// To parse this JSON data, do
//
//     final userdetailsModel = userdetailsModelFromJson(jsonString);

import 'dart:convert';

UserdetailsModel userdetailsModelFromJson(String str) => UserdetailsModel.fromJson(json.decode(str));

String userdetailsModelToJson(UserdetailsModel data) => json.encode(data.toJson());

class UserdetailsModel {
    String id;
    String parentname;
    String name;
    String lastname;
    String email;
    String phone;
    String type;
    String status;
    String address;
    String dacc;
    String dob;
    String gender;
    String clubmembership;
    String clubcardcopy;
    String feestatus;
    List<dynamic> schedules;
    DateTime date;
    int v;

    UserdetailsModel({
        required this.id,
        required this.parentname,
        required this.name,
        required this.lastname,
        required this.email,
        required this.phone,
        required this.type,
        required this.status,
        required this.address,
        required this.dacc,
        required this.dob,
        required this.gender,
        required this.clubmembership,
        required this.clubcardcopy,
        required this.feestatus,
        required this.schedules,
        required this.date,
        required this.v,
    });

    factory UserdetailsModel.fromJson(Map<String, dynamic> json) => UserdetailsModel(
        id: json["_id"],
        parentname: json["parentname"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        type: json["type"],
        status: json["status"],
        address: json["address"],
        dacc: json["dacc"],
        dob: json["dob"],
        gender: json["gender"],
        clubmembership: json["clubmembership"],
        clubcardcopy: json["clubcardcopy"],
        feestatus: json["feestatus"],
        schedules: List<dynamic>.from(json["schedules"].map((x) => x)),
        date: DateTime.parse(json["date"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "parentname": parentname,
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "type": type,
        "status": status,
        "address": address,
        "dacc": dacc,
        "dob": dob,
        "gender": gender,
        "clubmembership": clubmembership,
        "clubcardcopy": clubcardcopy,
        "feestatus": feestatus,
        "schedules": List<dynamic>.from(schedules.map((x) => x)),
        "date": date.toIso8601String(),
        "__v": v,
    };
}
