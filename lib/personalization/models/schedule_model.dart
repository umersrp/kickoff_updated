// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);

import 'dart:convert';

List<ScheduleModel> scheduleModelFromJson(String str) => List<ScheduleModel>.from(json.decode(str).map((x) => ScheduleModel.fromJson(x)));

String scheduleModelToJson(List<ScheduleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScheduleModel {
  String id;
  String location;
  String group;
  List<String> days;
  String startTime;
  String endTime;
  String ages;
  int v;
  DateTime date;

  ScheduleModel({
    required this.id,
    required this.location,
    required this.group,
    required this.days,
    required this.startTime,
    required this.endTime,
    required this.ages,
    required this.v,
    required this.date,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
    id: json["_id"],
    location: json["location"],
    group: json["group"],
    days: List<String>.from(json["days"].map((x) => x)),
    startTime: json["start_time"],
    endTime: json["end_time"],
    ages: json["ages"],
    v: json["__v"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "location": location,
    "group": group,
    "days": List<dynamic>.from(days.map((x) => x)),
    "start_time": startTime,
    "end_time": endTime,
    "ages": ages,
    "__v": v,
    "date": date.toIso8601String(),
  };
}
