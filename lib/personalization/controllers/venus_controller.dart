import 'package:appkickoff/personalization/controllers/aboutUs_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/venus_model.dart';

class VenuesController extends GetxController {
  // Observable variables for state management
  var isLoading = true.obs;
  var venuesList = <Venue>[].obs;
  var address = <Address>[].obs;

  var errorMessage = ''.obs;

  // API endpoint
  final String apiUrl = '$baseUrl/user/venue/get-venues?limit=100';

  // Method to fetch venues from API
  Future<void> fetchVenues() async {
    isLoading(true); // Set loading state to true
    try {
      // API call
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response
        final VenusModel venusModel = venusModelFromJson(response.body);

        // Update state with the list of venues
        venuesList.assignAll(venusModel.venues);
      } else {
        errorMessage('Failed to load venues');
      }
    } catch (e) {
      errorMessage('Error occurred while fetching venues: $e');
    } finally {
      isLoading(false); // Stop loading
    }
  }

  // Refresh or reload data
  Future<void> refreshVenues() async {
    venuesList.clear();
    fetchVenues(); // Fetch the venues again
  }
}
