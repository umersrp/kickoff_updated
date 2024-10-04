import 'dart:convert';
import 'package:appkickoff/personalization/controllers/aboutUs_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../features/screens/bookandplay/listing_ground/ground_listing.dart';
import '../models/bookingslot_model.dart';
import '../service/controller/aboutUs_controller.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class BookingController extends GetxController {
  var isLoading = false.obs;

  final AuthService authService = Get.find<AuthService>();

  Future<void> createBooking(BuildContext context,
      BookslotModel bookslotModel,
      String venueName, // Add venue name parameter
      String venuePrice, // Add venue price parameter
      String startTime, // Add start time
      String endTime // Add end time
      ) async {
    isLoading.value = true;

    String? token = authService.token.value;

    try {
      if (token == null || token.isEmpty) {
        // Show dialog using passed context
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          title: 'Error',
          desc: 'Please first login then book the slot.',
          btnOkOnPress: () {},
        ).show();
        return;
      }

      final String url = '$baseUrl/user/booking/create-booking';
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final body = json.encode(bookslotModel.toJson());

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final message = responseData['message'];

        if (message != null && message == "Booking Created Successfully") {
          // Construct the dialog message with venue name, price, and times
          final dialogMessage = "Your booking has been created successfully for venue: $venueName.\n"
              "Time: $startTime - $endTime\n"
              "Price: Rs $venuePrice";

          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            title: 'Booking Successful',
            desc: dialogMessage,
            // Display the formatted message
            btnOkOnPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GroundListingUI()),
              );
            },
          ).show();
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: 'Error',
            desc: 'Unexpected response received',
            btnOkOnPress: () {},
          ).show();
        }
      } else {
        final errorResponse = json.decode(response.body);
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          title: 'Error',
          desc: errorResponse['message'] ?? 'Failed to create booking',
          btnOkOnPress: () {},
        ).show();
      }
    } catch (error) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Error',
        desc: 'An error occurred while creating booking: $error',
        btnOkOnPress: () {},
      ).show();
    } finally {
      isLoading.value = false;
    }
  }
}