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
