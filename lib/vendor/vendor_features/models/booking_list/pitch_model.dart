import 'package:appkickoff/vendor/vendor_features/models/booking_list/availability_model.dart';

class Pitch {
  String pitchName;
  String sportType;
  String size;
  List<Availability> availability;
  String id;

  Pitch({
    required this.pitchName,
    required this.sportType,
    required this.size,
    required this.availability,
    required this.id,
  });

  factory Pitch.fromJson(Map<String, dynamic> json) => Pitch(
        pitchName: json["pitchName"],
        sportType: json["sportType"],
        size: json["size"],
        availability: List<Availability>.from(
            json["availability"].map((x) => Availability.fromJson(x))),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "pitchName": pitchName,
        "sportType": sportType,
        "size": size,
        "availability": List<dynamic>.from(availability.map((x) => x.toJson())),
        "_id": id,
      };
}
