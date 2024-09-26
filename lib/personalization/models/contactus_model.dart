import 'dart:convert';

List<ContactusModel> contactusModelFromJson(String str) => List<ContactusModel>.from(json.decode(str).map((x) => ContactusModel.fromJson(x)));

String contactusModelToJson(List<ContactusModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContactusModel {
  Contact contact;
  String id;
  String title;
  int v;

  ContactusModel({
    required this.contact,
    required this.id,
    required this.title,
    required this.v,
  });

  factory ContactusModel.fromJson(Map<String, dynamic> json) => ContactusModel(
    contact: Contact.fromJson(json["contact"]),
    id: json["_id"],
    title: json["title"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "contact": contact.toJson(),
    "_id": id,
    "title": title,
    "__v": v,
  };
}

class Contact {
  String email;
  String phone;

  Contact({
    required this.email,
    required this.phone,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "phone": phone,
  };
}
