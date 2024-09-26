// To parse this JSON data, do
//
//     final aboutModel = aboutModelFromJson(jsonString);

import 'dart:convert';

List<AboutModel> aboutModelFromJson(String str) => List<AboutModel>.from(json.decode(str).map((x) => AboutModel.fromJson(x)));

String aboutModelToJson(List<AboutModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AboutModel {
  String id;
  String whoWeAre;
  String ourVision;
  String ourMission;
  String images;
  int v;

  AboutModel({
    required this.id,
    required this.whoWeAre,
    required this.ourVision,
    required this.ourMission,
    required this.images,
    required this.v,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
    id: json["_id"],
    whoWeAre: json["WhoWeAre"],
    ourVision: json["OurVision"],
    ourMission: json["OurMission"],
    images: json["images"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "WhoWeAre": whoWeAre,
    "OurVision": ourVision,
    "OurMission": ourMission,
    "images": images,
    "__v": v,
  };
}
