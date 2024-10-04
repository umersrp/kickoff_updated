class VendorId {
  String id;
  String name;
  String email;
  String type;
  String status;
  String phone;
  DateTime date;

  VendorId({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    required this.status,
    required this.phone,
    required this.date,
  });

  factory VendorId.fromJson(Map<String, dynamic> json) => VendorId(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        type: json["type"],
        status: json["status"],
        phone: json["phone"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "type": type,
        "status": status,
        "phone": phone,
        "date": date.toIso8601String(),
      };
}
