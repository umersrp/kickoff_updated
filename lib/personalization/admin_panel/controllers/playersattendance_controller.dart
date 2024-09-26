import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../controllers/aboutUs_controller.dart';
import '../../models/schedule_model.dart';
import '../../service/controller/aboutUs_controller.dart';
import '../models/playerattendance_model.dart';

class PlayerattendanceController extends GetxController {
  var attendanceRecords = <Attendance>[].obs;
  var filteredPlayers = <User>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var currentPage = 1.obs;
  var totalRecords = 0.obs;
  var recordsPerPage = 50;
  String? selectedSchedule;
  ScheduleModel? selectedScheduleItem;
  final List<User> attendanceUpdates = [];

  final AuthService authService = Get.find<AuthService>();

  Future<void> fetchUsersForSchedule(String scheduleId) async {
    try {
      isLoading(true);

      String token = '${authService.token.value}';
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        Uri.parse('${baseUrl}/admin/attendence/get-attendence?scheduleId=$scheduleId&page=${currentPage.value}&limit=$recordsPerPage'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        // Safely handle potential null values
        totalRecords.value = decodedResponse['totalRecords'] ?? 0;

        List<User> users = [];
        if (decodedResponse['attendanceRecords'] != null) {
          for (var record in decodedResponse['attendanceRecords']) {
            if (record['user'] != null && record['user'] is Map<String, dynamic>) {
              var userJson = record['user'];
              users.add(User.fromJson(userJson));
            }
          }
        }

        if (currentPage.value == 1) {
          filteredPlayers.value = users;
        } else {
          filteredPlayers.addAll(users);
        }
      } else {
        print("Failed to load users: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching users: $e");
    } finally {
      isLoading(false);
    }
  }




  Future<void> changeAttendanceStatus(String userId, String scheduleId, bool isPresent) async {
    try {
      isLoading(true);

      String token = '${authService.token.value}';
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'userId': userId,
        'scheduleId': scheduleId,
        'isPresent': isPresent,
      });

      final response = await http.put(
        Uri.parse('${baseUrl}/admin/attendence/change-attendance-status'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        // Handle success response if needed
        print("Attendance status changed successfully.");
      } else {
        print("Failed to change attendance status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error changing attendance status: $e");
    } finally {
      isLoading(false);
    }
  }

  bool get canShowNextButton {
    return filteredPlayers.length < totalRecords.value;
  }

  void clearUsers() {
    filteredPlayers.clear();
    currentPage.value = 1;
  }
}
