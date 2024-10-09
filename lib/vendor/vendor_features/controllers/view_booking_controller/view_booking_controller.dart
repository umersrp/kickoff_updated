import 'dart:developer';

import 'package:appkickoff/vendor/common/app_snackbars/snackbars.dart';
import 'package:appkickoff/vendor/utils/helpers/http_helper.dart';
import 'package:appkickoff/vendor/vendor_features/models/book_venue/book_venue_model.dart'; 
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/book_venue/booking_venues.dart';

class ViewBookingController extends GetxController {
  static ViewBookingController get instance => Get.find();

  /// vars
  var bookingVenue = <Booking>[].obs;
  var currentPage = 1.obs;
  var hasNextPage = true.obs;
  var isLoading = false.obs;
  final scrollController = ScrollController();

  /// oninit
  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    fetchBookedVenues();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isLoading.value && hasNextPage.value) {
        fetchBookedVenues();
      }
    }
  }

  /// fetch all booked venue
  Future<void> fetchBookedVenues() async {
    if (isLoading.value || !hasNextPage.value) return;
    try {
      isLoading(true);

      final response = await VendorHttpHelper.get(
          'vendor/booking/get-bookings?page=${currentPage.value}&limit=10');
      log("Response: $response");
      final data = BookVenueModel.fromJson(response);
      bookingVenue.addAll(data.bookings);

      currentPage.value++;
      hasNextPage.value = data.pagination.hasNextPage;  
      
    } catch (e) {
      log("Error fetching Featured Vendors: $e");
      AppSnackbars.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading(false);
    }
  }

  ///
  @override
  void onClose() {
    super.onClose();
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
  }
}
