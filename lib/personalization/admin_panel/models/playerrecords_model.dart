import 'dart:convert';

PlayerrecordsModel playerrecordsModelFromJson(String str) => PlayerrecordsModel.fromJson(json.decode(str));
String playerrecordsModelToJson(PlayerrecordsModel data) => json.encode(data.toJson());

class PlayerrecordsModel {
  List<User> users;
  Pagination pagination;

  PlayerrecordsModel({
    required this.users,
    required this.pagination,
  });

  factory PlayerrecordsModel.fromJson(Map<String, dynamic> json) => PlayerrecordsModel(
    users: json["users"] != null
        ? List<User>.from(json["users"].map((x) => User.fromJson(x)))
        : [],
    pagination: json["pagination"] != null
        ? Pagination.fromJson(json["pagination"])
        : Pagination(page: 0, limit: 0, total: 0, hasNextPage: false),
  );

  Map<String, dynamic> toJson() => {
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}

class Pagination {
  int page;
  int limit;
  int total;
  bool hasNextPage;

  Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.hasNextPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    page: json["page"] ?? 0,
    limit: json["limit"] ?? 0,
    total: json["total"] ?? 0,
    hasNextPage: json["hasNextPage"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "hasNextPage": hasNextPage,
  };
}

class User {
  String id;
  String parentname;
  String name;
  String lastname;
  String email;
  String phone;
  String type;
  String status;
  String address;
  String feestatus;
  List<String> courses;
  DateTime date;
  int v;
  List<dynamic> schedules;
  String? dacc;
  String dob;
  String gender;
  String clubmembership;
  String clubcardcopy;

  User({
    required this.id,
    required this.parentname,
    required this.name,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.type,
    required this.status,
    required this.address,
    required this.feestatus,
    required this.courses,
    required this.date,
    required this.v,
    required this.schedules,
    this.dacc,
    required this.dob,
    required this.gender,
    required this.clubmembership,
    required this.clubcardcopy,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"] ?? '',
    parentname: json["parentname"] ?? '',
    name: json["name"] ?? '',
    lastname: json["lastname"] ?? '',
    email: json["email"] ?? '',
    phone: json["phone"] ?? '',
    type: json["type"] ?? '',
    status: json["status"] ?? '',
    address: json["address"] ?? '',
    feestatus: json["feestatus"] ?? '',
    courses: json["courses"] != null
        ? List<String>.from(json["courses"].map((x) => x))
        : [],
    date: json["date"] != null
        ? DateTime.parse(json["date"])
        : DateTime(1970, 1, 1),
    v: json["__v"] ?? 0,
    schedules: json["schedules"] != null
        ? List<dynamic>.from(json["schedules"].map((x) => x))
        : [],
    dacc: json["dacc"],
    dob: json["dob"],
    gender: json["gender"],
    clubmembership: json["clubmembership"],
    clubcardcopy: json["clubcardcopy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "parentname": parentname,
    "name": name,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "type": type,
    "status": status,
    "address": address,
    "feestatus": feestatus,
    "courses": List<dynamic>.from(courses.map((x) => x)),
    "date": date.toIso8601String(),
    "__v": v,
    "schedules": List<dynamic>.from(schedules.map((x) => x)),
    "dacc": dacc,
    "dob": dob,
    "gender": gender,
    "clubmembership": clubmembership,
    "clubcardcopy": clubcardcopy,
  };
}
