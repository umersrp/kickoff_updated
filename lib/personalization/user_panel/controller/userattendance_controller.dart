import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../controllers/aboutUs_controller.dart';
import '../../service/controller/aboutUs_controller.dart';
import '../models/userattendance_model.dart'; // Adjust based on your file structure

class UserAttendanceController extends GetxController {
  var isLoading = true.obs;
  var userAttendanceList = <UserattendanceModel>[].obs;
  var errorMessage = ''.obs;

  final AuthService authService = Get.find<AuthService>(); // Retrieve the AuthService instance

  UserAttendanceController(); // Constructor to initialize baseUrl

  @override
  void onInit() {
    fetchUserAttendance(); // Fetch attendance data when the controller is initialized
    super.onInit();
  }

  Future<void> fetchUserAttendance() async {
    isLoading.value = true;
    errorMessage.value = '';

    String token = authService.token.value; // Get the authentication token

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/attendance/get-attendance'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        userAttendanceList.value = userattendanceModelFromJson(json.encode(responseData));
      } else {
        errorMessage.value = 'Failed to load attendance data';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
