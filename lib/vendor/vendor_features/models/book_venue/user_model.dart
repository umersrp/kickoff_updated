class User {
  String id;
  String email;
  String phone;

  User({
    required this.id,
    required this.email,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "phone": phone,
      };
}
