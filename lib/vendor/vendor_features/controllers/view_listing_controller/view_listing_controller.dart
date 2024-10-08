import 'dart:developer';

import 'package:appkickoff/vendor/vendor_features/models/booking_list/venue_model.dart';
import 'package:appkickoff/vendor/vendor_features/models/page/page_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/app_snackbars/snackbars.dart';
import '../../../utils/helpers/http_helper.dart';
import '../../models/booking_list/booking_list_model_org.dart';

class ViewListingController extends GetxController {
  static ViewListingController get instance => Get.find();

  /// vars
  var vendorVenues = <Venue>[].obs;
  var currentPage = 1.obs;
  var hasNextPage = true.obs;
  var isLoading = false.obs;
  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    fetchVenues();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isLoading.value && hasNextPage.value) {
        fetchVenues();
      }
    }
  }

  /// fetch all venders venue
  Future<void> fetchVenues() async {
    if (isLoading.value || !hasNextPage.value) return; 
    try {
      isLoading(true);

      final response = await VendorHttpHelper.get('vendor/venue/get-venues');
      log("Response: $response");
      final data = BookingListItemModelOrg.fromJson(response);
      vendorVenues.addAll(
          data.venues.where((element) => element.status == 'active').toList());
      
      // currentPage.value++;
      // hasNextPage.value = data.pagination.ha
      final paginationData = response['pagination'];
      if(paginationData != null ){
        final pagination = Pagination.fromJson(paginationData);
         currentPage.value = pagination.currentPage + 1;
         hasNextPage.value = currentPage.value <= pagination.totalPages;
      } else{
        hasNextPage.value = false;
      }
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
