// To parse this JSON data, do
//
//     final venusModel = venusModelFromJson(jsonString);

import 'dart:convert';

VenusModel venusModelFromJson(String str) => VenusModel.fromJson(json.decode(str));

String venusModelToJson(VenusModel data) => json.encode(data.toJson());

class VenusModel {
    List<Venue> venues;
    Pagination pagination;

    VenusModel({
        required this.venues,
        required this.pagination,
    });

    factory VenusModel.fromJson(Map<String, dynamic> json) => VenusModel(
        venues: List<Venue>.from(json["venues"].map((x) => Venue.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "venues": List<dynamic>.from(venues.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
    };
}

class Pagination {
    int totalVenues;
    int totalPages;
    int currentPage;
    int pageSize;

    Pagination({
        required this.totalVenues,
        required this.totalPages,
        required this.currentPage,
        required this.pageSize,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalVenues: json["totalVenues"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        pageSize: json["pageSize"],
    );

    Map<String, dynamic> toJson() => {
        "totalVenues": totalVenues,
        "totalPages": totalPages,
        "currentPage": currentPage,
        "pageSize": pageSize,
    };
}

class Venue {
    String id;
    String name;
    String location;
    String days;
    Address address;
    int capacity;
    Sport sports;
    List<String> timings;
    int price;
    List<dynamic> images;
    int numberOfPitches;
    List<Pitch> pitches;
    VendorId vendorId;
    List<String> amenities;
    String status;
    DateTime date;
    int v;

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
        required this.v,
    });

    factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        id: json["_id"],
        name: json["name"],
        location: json["location"],
        days: json["days"],
        address: Address.fromJson(json["address"]),
        capacity: json["capacity"],
        sports: sportValues.map[json["sports"]]!,
        timings: List<String>.from(json["timings"].map((x) => x)),
        price: json["price"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        numberOfPitches: json["numberOfPitches"],
        pitches: List<Pitch>.from(json["pitches"].map((x) => Pitch.fromJson(x))),
        vendorId: VendorId.fromJson(json["vendorId"]),
        amenities: List<String>.from(json["amenities"].map((x) => x)),
        status: json["status"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "location": location,
        "days": days,
        "address": address.toJson(),
        "capacity": capacity,
        "sports": sportValues.reverse[sports],
        "timings": List<dynamic>.from(timings.map((x) => x)),
        "price": price,
        "images": List<dynamic>.from(images.map((x) => x)),
        "numberOfPitches": numberOfPitches,
        "pitches": List<dynamic>.from(pitches.map((x) => x.toJson())),
        "vendorId": vendorId.toJson(),
        "amenities": List<dynamic>.from(amenities.map((x) => x)),
        "status": status,
        "date": date.toIso8601String(),
        "__v": v,
    };
}

class Address {
    String address;
    String city;
    String id;

    Address({
        required this.address,
        required this.city,
        required this.id,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        city: json["city"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "_id": id,
    };
}

class Pitch {
    String pitchName;
    Sport sportType;
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
        sportType: sportValues.map[json["sportType"]]!,
        size: json["size"],
        availability: List<Availability>.from(json["availability"].map((x) => Availability.fromJson(x))),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "pitchName": pitchName,
        "sportType": sportValues.reverse[sportType],
        "size": size,
        "availability": List<dynamic>.from(availability.map((x) => x.toJson())),
        "_id": id,
    };
}

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

enum Sport {
    CRICKET,
    FOOTBALL
}

final sportValues = EnumValues({
    "cricket": Sport.CRICKET,
    "football": Sport.FOOTBALL
});

class VendorId {
    String id;
    String name;
    String email;
    String type;
    String status;
    String phone;
    DateTime date;
    int v;

    VendorId({
        required this.id,
        required this.name,
        required this.email,
        required this.type,
        required this.status,
        required this.phone,
        required this.date,
        required this.v,
    });

    factory VendorId.fromJson(Map<String, dynamic> json) => VendorId(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        type: json["type"],
        status: json["status"],
        phone: json["phone"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "type": type,
        "status": status,
        "phone": phone,
        "date": date.toIso8601String(),
        "__v": v,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
