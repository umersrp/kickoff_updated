import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/feedback_model.dart';
import 'aboutUs_controller.dart';

class FeedbackController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> postFeedback(FeedbackModel feedback) async {
    try {
      isLoading(true);

      final response = await http.post(
        Uri.parse('${baseUrl}/user/feedback/create-feedback'),
        headers: {
          'Content-Type': 'application/json',
          // Add any other headers if needed
        },
        body: json.encode(feedback.toJson()),
      );

      if (response.statusCode == 200) {
        print('Feedback posted successfully: ${response.body}');
        // Handle successful response, maybe clear the form or show a success message
      } else {
        print('Failed to post feedback: ${response.statusCode}');
        errorMessage.value = 'Failed to post feedback: ${response.statusCode}';
      }
    } catch (e) {
      print('Error occurred: $e');
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }
}
