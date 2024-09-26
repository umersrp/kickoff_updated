import 'dart:convert';

// Converts JSON string to LoginModel object
LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

// Converts LoginModel object to JSON string
String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String message;
  String token;
  User user;

  LoginModel({
    required this.message,
    required this.token,
    required this.user,
  });

  // Factory constructor to create an instance from JSON
  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    message: json["message"] ?? '', // Default to empty string if null
    token: json["token"] ?? '', // Default to empty string if null
    user: User.fromJson(json["user"] ?? {}), // Use empty map if user is null
  );

  // Converts the instance back to JSON format
  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token,
    "user": user.toJson(),
  };
}

class User {
  String feestatus;
  List<dynamic> schedules;
  String id;
  String name;
  String email;
  String password;
  String type;
  String status;
  List<dynamic> courses;
  DateTime date;
  int v;

  User({
    required this.feestatus,
    required this.schedules,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    required this.status,
    required this.courses,
    required this.date,
    required this.v,
  });

  // Factory constructor to create User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) => User(
    feestatus: json["feestatus"] ?? '', // Default to empty string if null
    schedules: json["schedules"] != null
        ? List<dynamic>.from(json["schedules"].map((x) => x)) // Safely map schedules
        : [], // Default to empty list if null
    id: json["_id"] ?? '', // Default to empty string if null
    name: json["name"] ?? '', // Default to empty string if null
    email: json["email"] ?? '', // Default to empty string if null
    password: json["password"] ?? '', // Default to empty string if null
    type: json["type"] ?? '', // Default to empty string if null
    status: json["status"] ?? '', // Default to empty string if null
    courses: json["courses"] != null
        ? List<dynamic>.from(json["courses"].map((x) => x)) // Safely map courses
        : [], // Default to empty list if null
    date: json["date"] != null
        ? DateTime.parse(json["date"]) // Parse date if not null
        : DateTime.now(), // Default to current date if null
    v: json["__v"] ?? 0, // Default to 0 if null
  );

  // Converts the User instance back to JSON format
  Map<String, dynamic> toJson() => {
    "feestatus": feestatus,
    "schedules": List<dynamic>.from(schedules.map((x) => x)),
    "_id": id,
    "name": name,
    "email": email,
    "password": password,
    "type": type,
    "status": status,
    "courses": List<dynamic>.from(courses.map((x) => x)),
    "date": date.toIso8601String(),
    "__v": v,
  };
}
