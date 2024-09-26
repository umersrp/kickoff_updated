import 'dart:convert';

FeedbackModel feedbackModelFromJson(String str) => FeedbackModel.fromJson(json.decode(str));

String feedbackModelToJson(FeedbackModel data) => json.encode(data.toJson());

class FeedbackModel {
  int rating;
  String email;
  String message;
  String id;
  int v;

  FeedbackModel({
    required this.rating,
    required this.email,
    required this.message,
    required this.id,
    required this.v,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
    rating: json["rating"],
    email: json["email"],
    message: json["message"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "email": email,
    "message": message,
    "_id": id,
    "__v": v,
  };
}
