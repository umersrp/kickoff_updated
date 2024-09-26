import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../controllers/aboutUs_controller.dart';
import '../../service/controller/aboutUs_controller.dart';

class AttendanceController extends GetxController {
  final authService = Get.find<AuthService>(); // Assuming you have an AuthService
  final RxString errorMessage = ''.obs;

  // Method to change attendance status
  Future<void> changeAttendanceStatus(String userId, String scheduleId, bool isPresent) async {
    final String status = isPresent ? 'present' : 'absent';

    try {
      print('Using token: ${authService.token.value}');  // Print the token here
      final response = await http.put(
        Uri.parse('${baseUrl}/admin/attendence/change-attendance-status'),
        headers: {
          'Authorization': 'Bearer ${authService.token.value}', // Use the token from AuthService
          'Content-Type': 'application/json',
        },
        body: '{"userId": "$userId", "scheduleId": "$scheduleId", "status": "$status"}',
      );

      if (response.statusCode == 200) {
        print('Attendance status updated successfully');
        // Handle success if needed, e.g., refresh the UI or show a message
      } else {
        print('Failed to update attendance status: ${response.statusCode}');
        errorMessage.value = 'Failed to update attendance status';
      }
    } catch (e) {
      print('Error occurred: $e');
      errorMessage.value = 'Error: $e';
    }
  }
}
