import 'address_model.dart';

class Venue {
  String id;
  String name;
  Address address;
  List<String> images;

  Venue({
    required this.id,
    required this.name,
    required this.address,
    required this.images,
  }); 

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['_id'],
      name: json['name'],
      address: Address.fromJson(json['address']),
      images: List<String>.from(json["images"].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "address": address.toJson(),
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
