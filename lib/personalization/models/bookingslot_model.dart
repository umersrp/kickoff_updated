
import 'dart:convert';

BookslotModel BookslotModelFromJson(String str) => BookslotModel.fromJson(json.decode(str));

String BookslotModelToJson(BookslotModel data) => json.encode(data.toJson());

class BookslotModel {
  String venue;
  String pitch;
  String bookingDate;
  String startTime;
  String endTime;

  BookslotModel({
    required this.venue,
    required this.pitch,
    required this.bookingDate,
    required this.startTime,
    required this.endTime,
  });

  factory BookslotModel.fromJson(Map<String, dynamic> json) => BookslotModel(
    venue: json["venue"],
    pitch: json["pitch"],
    bookingDate: json["bookingDate"],
    startTime: json["startTime"],
    endTime: json['endTime'],
  );

  Map<String, dynamic> toJson() => {
    "venue": venue,
    "pitch": pitch,
    "bookingDate": bookingDate,
    "startTime": startTime,
    "endTime" : endTime,
  };
}
