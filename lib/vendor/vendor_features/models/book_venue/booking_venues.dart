import 'slot_model.dart';
import 'user_model.dart';
import 'vendor_model.dart';
import 'venue_models.dart';

class Booking {
  String id;
  Venue venue;
  String pitch;
  Vendor vendor;
  User user;
  String? slotId;
  DateTime date; 
  Slot slot; 

  Booking({
    required this.id,
    required this.venue,
    required this.pitch,
    required this.vendor,
    required this.user,
    this.slotId,
    required this.date, 
    required this.slot, 
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["_id"],
        venue: Venue.fromJson(json["venue"]),
        pitch: json["pitch"],
        vendor: Vendor.fromJson(json["vendor"]),
        user: User.fromJson(json["user"]),
        slotId: json["slotId"],
        date: DateTime.parse(json["date"]), 
        slot: Slot.fromJson(json["slot"])  , 
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "venue": venue.toJson(),
        "pitch": pitch ,
        "vendor": vendor.toJson(),
        "user": user.toJson(),
        "slotId": slotId,
        "date": date.toIso8601String(), 
        "slot": slot.toJson(), 
      };
}
