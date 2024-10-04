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
    String sports;
    List<String> timings;
    int price;
    List<String> images;
    int numberOfPitches;
    List<Pitch> pitches;
    VendorId vendorId;
    List<Amenity> amenities;
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
        sports: json["sports"],
        timings: List<String>.from(json["timings"].map((x) => x)),
        price: json["price"],
        images: List<String>.from(json["images"].map((x) => x)),
        numberOfPitches: json["numberOfPitches"],
        pitches: List<Pitch>.from(json["pitches"].map((x) => Pitch.fromJson(x))),
        vendorId: VendorId.fromJson(json["vendorId"]),
        amenities: List<Amenity>.from(json["amenities"].map((x) => Amenity.fromJson(x))),
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
        "sports": sports,
        "timings": List<dynamic>.from(timings.map((x) => x)),
        "price": price,
        "images": List<dynamic>.from(images.map((x) => x)),
        "numberOfPitches": numberOfPitches,
        "pitches": List<dynamic>.from(pitches.map((x) => x.toJson())),
        "vendorId": vendorId.toJson(),
        "amenities": List<dynamic>.from(amenities.map((x) => x.toJson())),
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

class Amenity {
    String id;
    List<String> icon;
    String description;
    String? name;

    Amenity({
        required this.id,
        required this.icon,
        required this.description,
        this.name,
    });

    factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
        id: json["_id"],
        icon: List<String>.from(json["icon"].map((x) => x)),
        description: json["description"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "icon": List<dynamic>.from(icon.map((x) => x)),
        "description": description,
        "name": name,
    };
}

class Pitch {
    String pitchName;
    String sportType;
    String size;
    List<String> slot;
    int? slotduration;
    List<Availability> availability;
    String id;

    Pitch({
        required this.pitchName,
        required this.sportType,
        required this.size,
        required this.slot,
        this.slotduration,
        required this.availability,
        required this.id,
    });

    factory Pitch.fromJson(Map<String, dynamic> json) => Pitch(
        pitchName: json["pitchName"],
        sportType: json["sportType"],
        size: json["size"],
        slot: List<String>.from(json["slot"].map((x) => x)),
        slotduration: json["slotduration"],
        availability: List<Availability>.from(json["availability"].map((x) => Availability.fromJson(x))),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "pitchName": pitchName,
        "sportType": sportType,
        "size": size,
        "slot": List<dynamic>.from(slot.map((x) => x)),
        "slotduration": slotduration,
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
