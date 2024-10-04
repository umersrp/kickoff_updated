import 'package:appkickoff/vendor/vendor_features/models/booking_list/address_model.dart';
import 'package:appkickoff/vendor/vendor_features/models/booking_list/pitch_model.dart';
import 'package:appkickoff/vendor/vendor_features/models/booking_list/vendorId_model.dart';

class Venue {
  String id;
  String name;
  String location;
  String days;
  Address address;
  int capacity;
  String sports;
  List<String> timings;
  int price;
  List<dynamic> images;
  int numberOfPitches;
  List<Pitch> pitches;
  VendorId vendorId;
  List<dynamic> amenities;
  String status;
  DateTime date; 

  Venue({
    required this.id,
    required this.name,
    required this.location,
    required this.days,
    required this.address,
    required this.capacity,
    required this.sports,
    required this.timings,
    required this.price,
    required this.images,
    required this.numberOfPitches,
    required this.pitches,
    required this.vendorId,
    required this.amenities,
    required this.status,
    required this.date, 
  });

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        id: json["_id"],
        name: json["name"],
        location: json["location"],
        days: json["days"],
        address: Address.fromJson(json["address"]),
        capacity: json["capacity"],
        sports: json["sports"],
        timings: List<String>.from(json["timings"].map((x) => x)),
        price: json["price"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        numberOfPitches: json["numberOfPitches"],
        pitches:
            List<Pitch>.from(json["pitches"].map((x) => Pitch.fromJson(x))),
        vendorId: VendorId.fromJson(json["vendorId"]),
        amenities: List<dynamic>.from(json["amenities"].map((x) => x)),
        status: json["status"],
        date: DateTime.parse(json["date"]), 
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "location": location,
        "days": days,
        "address": address.toJson(),
        "capacity": capacity,
        "sports": sports,
        "timings": List<dynamic>.from(timings.map((x) => x)),
        "price": price,
        "images": List<dynamic>.from(images.map((x) => x)),
        "numberOfPitches": numberOfPitches,
        "pitches": List<dynamic>.from(pitches.map((x) => x.toJson())),
        "vendorId": vendorId.toJson(),
        "amenities": List<dynamic>.from(amenities.map((x) => x)),
        "status": status,
        "date": date.toIso8601String(),
         
      };
}
