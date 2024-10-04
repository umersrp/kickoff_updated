import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/app_snackbars/snackbars.dart';
import '../../../utils/helpers/http_helper.dart';
import '../../../vendor_features/views/home/home.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// vars
  final signupFormKey = GlobalKey<FormState>();
  final vendorNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final hidePassword = true.obs;
  final confirmPassword = true.obs;
  final isLoading = false.obs;

  /// oninit
  /// build SignUp
  Future<void> buildSignUp() async {
    try {
      /// Start Loading
      isLoading(true);

      /// Check Internet Connectivity
      /// Form Validation
      if (!signupFormKey.currentState!.validate()) {
        isLoading(false);
        return;
      }

      /// Save Data if Remember Me is selected
      // if (rememberMe.value) {
      //   localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
      //   localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      // }

      /// prepare sign up data
      final data = {
        'name': vendorNameController.text.trim(),
        'email': emailAddressController.text.trim(),
        'phone': phoneNumberController.text.trim(),
        'password': passwordController.text.trim(),
      };

      /// Send login request
      // Call the signup API
      final response = await VendorHttpHelper.post2('vendor/signup', data);
      // log(response.body);
      if (response.statusCode == 201) {
        // log('message ::: $response');
        Get.to(
          () => VendorHomeScreen(),
          transition: Transition.rightToLeft,
        );
      } else { 
         // Extract the message from the response body
        final responseBody = json.decode(response.body);
        final errorMessage = responseBody['message'] ?? 'Signup failed';
         
        AppSnackbars.errorSnackBar(
            title: 'Oh Snap!', message: errorMessage);
      }
    } catch (e) {
      log('Error in Login $e');
    } finally {
      isLoading(false);
    }
  }

  ///
}
