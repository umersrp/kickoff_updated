// To parse this JSON data, do
//
//     final galleryModel = galleryModelFromJson(jsonString);

import 'dart:convert';

List<GalleryModel> galleryModelFromJson(String str) => List<GalleryModel>.from(json.decode(str).map((x) => GalleryModel.fromJson(x)));

String galleryModelToJson(List<GalleryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GalleryModel {
  String id;
  String title;
  List<String> images;
  int v;

  GalleryModel({
    required this.id,
    required this.title,
    required this.images,
    required this.v,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) => GalleryModel(
    id: json["_id"],
    title: json["title"],
    images: List<String>.from(json["images"].map((x) => x)),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "images": List<dynamic>.from(images.map((x) => x)),
    "__v": v,
  };
}
