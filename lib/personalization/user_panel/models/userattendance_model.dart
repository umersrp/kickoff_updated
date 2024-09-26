  import 'dart:convert';

  List<UserattendanceModel> userattendanceModelFromJson(String str) => List<UserattendanceModel>.from(json.decode(str).map((x) => UserattendanceModel.fromJson(x)));

  String userattendanceModelToJson(List<UserattendanceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  class UserattendanceModel {
    String id;
    dynamic schedules;
    String user;
    List<Attendance> attendance;
    int v;

    UserattendanceModel({
      required this.id,
      required this.schedules,
      required this.user,
      required this.attendance,
      required this.v,
    });

    factory UserattendanceModel.fromJson(Map<String, dynamic> json) => UserattendanceModel(
      id: json["_id"],
      schedules: json["schedules"],
      user: json["user"],
      attendance: List<Attendance>.from(json["attendance"].map((x) => Attendance.fromJson(x))),
      v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
      "_id": id,
      "schedules": schedules,
      "user": user,
      "attendance": List<dynamic>.from(attendance.map((x) => x.toJson())),
      "__v": v,
    };
  }

  class Attendance {
    String status;
    DateTime date;
    String id;

    Attendance({
      required this.status,
      required this.date,
      required this.id,
    });

    factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
      status: json["status"],
      date: DateTime.parse(json["date"]),
      id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
      "status": status,
      "date": date.toIso8601String(),
      "_id": id,
    };
  }
