class Availability {
  String day;
  String startTime;
  String endTime;
  String id;

  Availability({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.id,
  });

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        day: json["day"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "startTime": startTime,
        "endTime": endTime,
        "_id": id,
      };
}
