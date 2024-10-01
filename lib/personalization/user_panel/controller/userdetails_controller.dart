import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/userdetails_model.dart';
import '../../controllers/aboutUs_controller.dart';
import '../../service/controller/aboutUs_controller.dart';

class UserDetailsController extends GetxController {
  // State variables
  var userDetails = Rx<UserdetailsModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Dependency Injection

  final AuthService authService = Get.find<AuthService>();


  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    errorMessage.value = '';

    // Get the authentication token
    String token = authService.token.value;

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        userDetails.value = UserdetailsModel.fromJson(responseData);
      } else {
        errorMessage.value = 'Failed to load user profile data';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
