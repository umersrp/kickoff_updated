import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../controllers/aboutUs_controller.dart';
import '../../service/controller/aboutUs_controller.dart';
import '../models/playerrecords_model.dart';

class PlayerrecordsController extends GetxController {
  // Observable list to hold user data
  var users = <User>[].obs;

  // Loading state
  var isLoading = false.obs;

  // Error state
  var errorMessage = ''.obs;

  final AuthService authService = Get.find<AuthService>(); // Get the AuthService

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  // Function to fetch users from the API
  Future<void> fetchUsers() async {
    try {
      isLoading(true);

      // Construct the API URL
      final url = Uri.parse('$baseUrl/admin/user/get-users');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authService.token.value}', // Use the token from AuthService
      };
      print('Bearer Token: ${authService.token.value}');

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final playerrecordsModel = PlayerrecordsModel.fromJson(data);

        // Update the users state
        users.assignAll(playerrecordsModel.users);
      } else {
        // Handle the error
        errorMessage('Failed to load users');
      }
    } catch (e) {
      // Handle the error
      errorMessage(e.toString());
    } finally {
      // Stop the loading state
      isLoading(false);
    }
  }

  Future<void> updateUserStatus(String userId, bool isActive) async {
    final String status = isActive ? 'active' : 'inactive';

    try {
      print('Using token: ${authService.token.value}');  // Print the token here
      final response = await http.put(
        Uri.parse('${baseUrl}/admin/user/change-status/$userId'),
        headers: {
          'Authorization': 'Bearer ${authService.token.value}', // Use the token from AuthService
          'Content-Type': 'application/json',
        },
        body: '{"status": "$status"}',
      );

      if (response.statusCode == 200) {
        // Update the status locally
        final userIndex = users.value.indexWhere((user) => user.id == userId);
        if (userIndex != -1) {
          users.value[userIndex].status = status;
          users.refresh(); // Refresh the UI
        }
      } else {
        print('Failed to update status: ${response.statusCode}');
        errorMessage.value = 'Failed to update user status';
      }
    } catch (e) {
      print('Error occurred: $e');
      errorMessage.value = 'Error: $e';
    }
  }
}
