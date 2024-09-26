import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/homepage_model.dart';
import 'aboutUs_controller.dart';



class HomepageController extends GetxController {
  // Observable variables
  var HomepageData = <HomepageModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;



  void fetchHomepageData() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('${baseUrl}/user/homepage'),
      );

      if (response.statusCode == 200) {
        print('Response data: ${response.body}');
        HomepageData.value = homepageModelFromJson(response.body);
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
    fetchHomepageData();
  }
}
