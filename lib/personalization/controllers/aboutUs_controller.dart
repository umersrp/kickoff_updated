import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/aboutUs_model.dart';

// API URL
final String baseUrl = 'http://74.208.118.86/kickoff/api';

class AboutController extends GetxController {
  // Observable variables
  var aboutData = <AboutModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;



  void fetchAboutData() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('${baseUrl}/user/aboutus'),
      );

      if (response.statusCode == 200) {
        print('Response data: ${response.body}');
        aboutData.value = aboutModelFromJson(response.body);
      } else {
        print('Failed to load data: ${response.statusCode}');
        errorMessage.value = 'Failed to load about data';
      }
    } catch (e) {
      print('Error occurred: $e');
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }



  @override
  void onInit() {
    super.onInit();
    fetchAboutData();
  }
}
