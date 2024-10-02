import 'dart:developer';

import 'package:appkickoff/vendor/vendor_features/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../features/screens/Parent View/Parent_dashboard.dart';
import '../../../features/screens/Parent View/parent_homepage.dart';
import '../../../features/screens/coaches_Screen/coaches_Dashboard.dart';
import '../../controllers/aboutUs_controller.dart';
import '../../service/controller/aboutUs_controller.dart';
import '../models/login_model.dart';

class LoginController extends GetxController {
  // Observable variables
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var username = ''.obs;

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var obscurePassword = true.obs;

  final AuthService authService =
      Get.find<AuthService>(); // Get the AuthService

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void logout() {
    username.value = ''; // Reset username on logout
    // Additional logout logic (e.g., clearing tokens, navigating to login page)
  }

  @override
  void onInit() {
    super.onInit();
    _loadUserName();
  }

  Future<void> loginUser(
      BuildContext context, String username, String password) async {
    // Check if email or password is empty
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'All fields are required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
      return;
    }

    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        log('Login successful: $responseData');
        final loginModel = loginModelFromJson(response.body);
        final userType = loginModel.user.type;
        final token = loginModel.token;
        final name = loginModel.user.name;
        final status = loginModel.user.status;

        this.username.value = name;
        await authService.saveToken(token);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userType', userType);
        await prefs.setString('name', name);
        await prefs.setString('status', status);

        navigateBasedOnUserType(context, userType, status);
      } else {
        // Extract error message from the response
        final errorResponse = jsonDecode(response.body);
        String errorMsg =
            errorResponse['message'] ?? 'Failed to load user data';

        Get.snackbar(
          'Error',
          errorMsg,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        errorMessage.value.isNotEmpty
            ? errorMessage.value
            : 'An unknown error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Helper function to handle navigation based on userType and status
  void navigateBasedOnUserType(
      BuildContext context, String userType, String status) {
    if (status == 'active') {
      if (userType == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Parenthomepage()),
        );
      } else if (userType == 'vendor') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VendorHomeScreen()),
        );
      } else if (userType == 'coaches') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CoachesDashboard()),
        );
      } else if (userType == 'user') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ParentDashboard()),
        );
      } else {
        throw Exception('Unknown user type');
      }
    } else if (status == 'inactive') {
      // Show a dialog indicating the user is inactive
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Account Inactive'),
            content: Text('Your account is Inactive. Please Contact Support.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      throw Exception('Unknown account status');
    }
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('name') ?? '';
  }
}
