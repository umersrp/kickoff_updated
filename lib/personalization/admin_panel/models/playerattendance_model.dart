// To parse this JSON data, do
//
//     final playerattendanceModel = playerattendanceModelFromJson(jsonString);

import 'dart:convert';

PlayerattendanceModel playerattendanceModelFromJson(String str) => PlayerattendanceModel.fromJson(json.decode(str));

String playerattendanceModelToJson(PlayerattendanceModel data) => json.encode(data.toJson());

class PlayerattendanceModel {
    List<AttendanceRecord> attendanceRecords;
    Pagination pagination;

    PlayerattendanceModel({
        required this.attendanceRecords,
        required this.pagination,
    });

    factory PlayerattendanceModel.fromJson(Map<String, dynamic> json) => PlayerattendanceModel(
        attendanceRecords: List<AttendanceRecord>.from(json["attendanceRecords"].map((x) => AttendanceRecord.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "attendanceRecords": List<dynamic>.from(attendanceRecords.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
    };
}

class AttendanceRecord {
    String id;
    Schedules schedules;
    User user;
    List<Attendance> attendance;
    int v;

    AttendanceRecord({
        required this.id,
        required this.schedules,
        required this.user,
        required this.attendance,
        required this.v,
    });

    factory AttendanceRecord.fromJson(Map<String, dynamic> json) => AttendanceRecord(
        id: json["_id"],
        schedules: Schedules.fromJson(json["schedules"]),
        user: User.fromJson(json["user"]),
        attendance: List<Attendance>.from(json["attendance"].map((x) => Attendance.fromJson(x))),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "schedules": schedules.toJson(),
        "user": user.toJson(),
        "attendance": List<dynamic>.from(attendance.map((x) => x.toJson())),
        "__v": v,
    };
}

class Attendance {
    Status status;
    DateTime date;
    String id;

    Attendance({
        required this.status,
        required this.date,
        required this.id,
    });

    factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        status: statusValues.map[json["status"]]!,
        date: DateTime.parse(json["date"]),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "status": statusValues.reverse[status],
        "date": date.toIso8601String(),
        "_id": id,
    };
}

enum Status {
    ABSENT,
    PRESENT
}

final statusValues = EnumValues({
    "absent": Status.ABSENT,
    "present": Status.PRESENT
});

class Schedules {
    String id;
    Location location;
    String group;
    List<String> days;
    String startTime;
    String endTime;
    String ages;
    List<String> users;
    DateTime date;
    int v;

    Schedules({
        required this.id,
        required this.location,
        required this.group,
        required this.days,
        required this.startTime,
        required this.endTime,
        required this.ages,
        required this.users,
        required this.date,
        required this.v,
    });

    factory Schedules.fromJson(Map<String, dynamic> json) => Schedules(
        id: json["_id"],
        location: locationValues.map[json["location"]]!,
        group: json["group"],
        days: List<String>.from(json["days"].map((x) => x)),
        startTime: json["start_time"],
        endTime: json["end_time"],
        ages: json["ages"],
        users: List<String>.from(json["users"].map((x) => x)),
        date: DateTime.parse(json["date"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "location": locationValues.reverse[location],
        "group": group,
        "days": List<dynamic>.from(days.map((x) => x)),
        "start_time": startTime,
        "end_time": endTime,
        "ages": ages,
        "users": List<dynamic>.from(users.map((x) => x)),
        "date": date.toIso8601String(),
        "__v": v,
    };
}

enum Location {
    THE_66_C2_E7_D27554630_D69_D8_F911,
    THE_66_C2_FABC88_F2_FD3_D22_B4556_B
}

final locationValues = EnumValues({
    "66c2e7d27554630d69d8f911": Location.THE_66_C2_E7_D27554630_D69_D8_F911,
    "66c2fabc88f2fd3d22b4556b": Location.THE_66_C2_FABC88_F2_FD3_D22_B4556_B
});

class User {
    String id;
    String name;
    String email;
    bool isPresent; // Add this line
    bool isMarked; // New property


    User({
        required this.id,
        required this.name,
        required this.email,
        this.isPresent = false, // Initialize it with a default value
        this.isMarked = false, // Initialize with default value


    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        isPresent: json['isPresent'] ?? false,
        isMarked: json['isMarked'] ?? false, // Add this line


    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        'isPresent': isPresent, // Add this line

    };
}

class Pagination {
    String page;
    String limit;
    int total;
    bool hasNextPage;

    Pagination({
        required this.page,
        required this.limit,
        required this.total,
        required this.hasNextPage,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        limit: json["limit"],
        total: json["total"],
        hasNextPage: json["hasNextPage"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "total": total,
        "hasNextPage": hasNextPage,
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

