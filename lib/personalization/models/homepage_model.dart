// To parse this JSON data, do
//
//     final homepageModel = homepageModelFromJson(jsonString);

import 'dart:convert';

List<HomepageModel> homepageModelFromJson(String str) => List<HomepageModel>.from(json.decode(str).map((x) => HomepageModel.fromJson(x)));

String homepageModelToJson(List<HomepageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomepageModel {
  String id;
  String logo;
  String header;
  String aboutus;
  String termsandconditions;
  int v;

  HomepageModel({
    required this.id,
    required this.logo,
    required this.header,
    required this.aboutus,
    required this.termsandconditions,
    required this.v,
  });

  factory HomepageModel.fromJson(Map<String, dynamic> json) => HomepageModel(
    id: json["_id"],
    logo: json["logo"],
    header: json["header"],
    aboutus: json["aboutus"],
    termsandconditions: json["termsandconditions"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "logo": logo,
    "header": header,
    "aboutus": aboutus,
    "termsandconditions": termsandconditions,
    "__v": v,
  };
}
