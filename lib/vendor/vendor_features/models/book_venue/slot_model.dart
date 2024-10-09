class Slot {
  bool? isBooked;
  String? time;
  String? id;

  Slot({
    this.isBooked,
    this.time,
    this.id,
  });

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        isBooked: json["isBooked"],
        time: json["time"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "isBooked": isBooked,
        "time": time,
        "_id": id,
      };
}
