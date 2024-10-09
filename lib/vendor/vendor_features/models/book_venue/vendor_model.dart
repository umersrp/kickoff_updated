class Vendor {
  String id;
  String name;
  String email;
  String phone;

  Vendor({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
 }