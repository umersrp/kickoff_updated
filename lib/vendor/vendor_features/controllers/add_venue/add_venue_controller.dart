import 'dart:developer';

import 'package:appkickoff/vendor/common/dropdown_button/dropdown_button.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:appkickoff/vendor/vendor_features/views/view_listing/view_listing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common/app_snackbars/snackbars.dart';
import '../../../common/custom_image_view/custom_image_view.dart';
import '../../../common/text_form_field/text_form_field.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/helpers/http_helper.dart';
import 'widgets/time_selection.dart';

class AddVenueController extends GetxController {
  static AddVenueController get instance => Get.find();

  /// vars
  final addVenueFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final locationController = TextEditingController();
  // final amenitiesController = TextEditingController();
  final daysController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final capacityController = TextEditingController();
  final priceController = TextEditingController();
  final timingsController = TextEditingController();
  final numberOfPitchesController = TextEditingController();
  var selectedCategory = ''.obs;

  // var pitches = <Map<String, dynamic>>[].obs;
  var pitches = [].obs;

  final isLoading = false.obs;

  /// oninit

  /// build SignUp
  Future<void> buildSubmit() async {
    try {
      /// Start Loading
      isLoading(true);

      /// Check Internet Connectivity
      /// Form Validation
      if (!addVenueFormKey.currentState!.validate()) {
        isLoading(false);
        return;
      }

      /// prepare sign up data
      final data = {
        'name': nameController.text.trim(),
        'location': locationController.text.trim(),
        'days': daysController.text.trim(),
        'address': {
          'address': addressController.text.trim(),
          'city': cityController.text.trim(),
        },
        'capacity': int.parse(capacityController.text.trim()),
        'timings': [timingsController.text.trim()],
        'price': int.parse(priceController.text.trim()),
        'numberOfPitches': int.parse(numberOfPitchesController.text.trim()),
        'sports': selectedCategory.value,
        'pitches': pitches,
      };

      log('Body Data ::: ${data.toString()}');

      /// Send login request
      final response =
          await VendorHttpHelper.post2('vendor/venue/create-venue', data);
      log(response.body);

      if (response.statusCode == 201) {
        Get.off(
          () => ViewListingScreen(),
          transition: Transition.rightToLeft,
        );
      } else {
        log('Status Code ::: ${response.body}');
        // AppSnackbars.errorSnackBar(title: 'Oh Snap!', message: errorMessage);
      }
    } catch (e) {
      log('Error in Login $e');
    } finally {
      isLoading(false);
    }
  }

  /// Function to show the dialog for adding pitches
  Future<void> addPitches() async {
    int numberOfPitches = int.tryParse(numberOfPitchesController.text) ?? 0;
    log('numberOfPitches ::: $numberOfPitches');

    if (numberOfPitches <= 0) {
      AppSnackbars.errorSnackBar(
          title: 'Oh Snap', message: 'Please enter a valid number of pitches');
      return;
    }
    showMultiPitchDialog(numberOfPitches);
  }

  /// Show the dialog to enter pitch details
  void showMultiPitchDialog2(int numberOfPitches) {
    /// Create TextEditingControllers for each pitch
    List<TextEditingController> pitchNameControllers =
        List.generate(numberOfPitches, (index) => TextEditingController());
    List<TextEditingController> sportTypeControllers =
        List.generate(numberOfPitches, (index) => TextEditingController());
    List<TextEditingController> sizeControllers =
        List.generate(numberOfPitches, (index) => TextEditingController());

    var availabilityDayControllers = List.generate(numberOfPitches,
        (index) => <TextEditingController>[TextEditingController()]).obs;
    var availabilityStartTimeControllers = List.generate(numberOfPitches,
        (index) => <TextEditingController>[TextEditingController()]).obs;
    var availabilityEndTimeControllers = List.generate(numberOfPitches,
        (index) => <TextEditingController>[TextEditingController()]).obs;

    ///
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: Colors.white, // Dialog background color
        child: Container(
          width: Get.width, //* 0.9, // Custom width (90% of the screen)
          height: Get.height * 0.85, // Custom height (85% of the screen)
          padding: EdgeInsets.all(16), // Padding inside the dialog
          child: Column(
            children: [
              Text(
                'Enter Details for Pitches',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent, // Title color
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(numberOfPitches, (index) {
                      int pitchNumber = index + 1;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pitch $pitchNumber Details',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.green, // Section title color
                              ),
                            ),
                            SizedBox(height: 8),

                            // Pitch Name
                            CustomTextFormField(
                              controller: pitchNameControllers[index],
                              hintText: 'Pitch Name',
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors
                                  .grey.shade200, // Input field background
                            ),
                            SizedBox(height: 10),

                            // Sport Type
                            CustomTextFormField(
                              controller: sportTypeControllers[index],
                              hintText: 'Sport Type',
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                            ),
                            SizedBox(height: 10),

                            // Pitch Size
                            CustomTextFormField(
                              controller: sizeControllers[index],
                              hintText: 'Pitch Size (e.g., 50x100)',
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                            ),
                            SizedBox(height: 10),

                            /// Availability fields for this pitch
                            Obx(
                              () => Column(
                                children: List.generate(
                                  availabilityDayControllers[index].length,
                                  (availIndex) => Row(
                                    children: [
                                      // Day
                                      Expanded(
                                        child: CustomTextFormField(
                                          controller:
                                              availabilityDayControllers[index]
                                                  [availIndex],
                                          hintText: 'Day (e.g., Monday)',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                        ),
                                      ),
                                      SizedBox(width: 10),

                                      // Start Time
                                      Expanded(
                                        child: CustomTextFormField(
                                          controller:
                                              availabilityStartTimeControllers[
                                                  index][availIndex],
                                          hintText: 'Start Time (e.g., 08:00)',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                        ),
                                      ),
                                      SizedBox(width: 10),

                                      // End Time
                                      Expanded(
                                        child: CustomTextFormField(
                                          controller:
                                              availabilityEndTimeControllers[
                                                  index][availIndex],
                                          hintText: 'End Time (e.g., 20:00)',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                availabilityDayControllers[index]
                                    .add(TextEditingController());
                                availabilityStartTimeControllers[index]
                                    .add(TextEditingController());
                                availabilityEndTimeControllers[index]
                                    .add(TextEditingController());

                                // Refresh to rebuild the UI
                                availabilityDayControllers.refresh();
                                availabilityStartTimeControllers.refresh();
                                availabilityEndTimeControllers.refresh();
                              },
                              child: Text(
                                'Add Another Availability',
                                style: TextStyle(
                                    color: Colors.blue), // Button text color
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      for (int i = 0; i < numberOfPitches; i++) {
                        List<Map<String, String>> availabilityList = [];
                        for (var j = 0;
                            j < availabilityDayControllers[i].length;
                            j++) {
                          availabilityList.add({
                            'day': availabilityDayControllers[i][j].text,
                            'startTime':
                                availabilityStartTimeControllers[i][j].text,
                            'endTime':
                                availabilityEndTimeControllers[i][j].text,
                          });
                        }
                        // Add pitch details to the pitches list
                        pitches.add({
                          'pitchName': pitchNameControllers[i].text,
                          'sportType': sportTypeControllers[i].text,
                          'size': sizeControllers[i].text,
                          'availability': availabilityList,
                        });
                      }
                      Get.back();
                    },
                    child: Text(
                      'Add Pitches',
                      style:
                          TextStyle(color: Colors.green), // Button text color
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red), // Button text color
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showMultiPitchDialogDONE(int numberOfPitches) {
    /// Create TextEditingControllers for each pitch
    List<TextEditingController> pitchNameControllers =
        List.generate(numberOfPitches, (index) => TextEditingController());
    List<TextEditingController> sportTypeControllers =
        List.generate(numberOfPitches, (index) => TextEditingController());
    List<TextEditingController> sizeControllers =
        List.generate(numberOfPitches, (index) => TextEditingController());

    /// Nested list of controllers for availability (day, startTime, endTime)
    /// Observable nested list of controllers for availability (day, startTime, endTime)

    var availabilityDayControllers = List.generate(numberOfPitches,
        (index) => <TextEditingController>[TextEditingController()]).obs;
    var availabilityStartTimeControllers = List.generate(numberOfPitches,
        (index) => <TextEditingController>[TextEditingController()]).obs;
    var availabilityEndTimeControllers = List.generate(numberOfPitches,
        (index) => <TextEditingController>[TextEditingController()]).obs;

    ///
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        title: Text('Enter Details for Pitches'),
        content: SizedBox(
          width: double.maxFinite,
          // height: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(numberOfPitches, (index) {
                int pitchNumber = index + 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// text title
                      Text(
                        'Pitch $pitchNumber Details',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),

                      /// Pitch Name
                      CustomTextFormField(
                        controller: pitchNameControllers[index],
                        hintText: 'Pitch Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                      ),
                      SizedBox(height: 10),

                      /// Sport Type
                      CustomTextFormField(
                        controller: sportTypeControllers[index],
                        hintText: 'Sport Type',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                      ),
                      SizedBox(height: 10),

                      /// Pitch Size
                      CustomTextFormField(
                        controller: sizeControllers[index],
                        hintText: 'Pitch Size (e.g., 50x100)',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                      ),
                      SizedBox(height: 10),

                      /// Reactive Availability fields for this pitch
                      Obx(
                        () => Column(
                          children: List.generate(
                            availabilityDayControllers[index].length,
                            (availIndex) => Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                children: [
                                  /// Day
                                  Expanded(
                                    flex: 1,
                                    child: CustomTextFormField(
                                      controller:
                                          availabilityDayControllers[index]
                                              [availIndex],
                                      hintText: 'Day (e.g., Monday)',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      filled: true,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  // Start Time
                                  Expanded(
                                    flex: 1,
                                    child: CustomTextFormField(
                                      controller:
                                          availabilityStartTimeControllers[
                                              index][availIndex],
                                      hintText: 'Start Time (e.g., 08:00)',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      filled: true,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  // End Time
                                  Expanded(
                                    flex: 1,
                                    child: CustomTextFormField(
                                      controller:
                                          availabilityEndTimeControllers[index]
                                              [availIndex],
                                      hintText: 'End Time (e.g., 20:00)',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      filled: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          log('Add Another Availability Button pressed!');
                          availabilityDayControllers[index]
                              .add(TextEditingController());
                          availabilityStartTimeControllers[index]
                              .add(TextEditingController());
                          availabilityEndTimeControllers[index]
                              .add(TextEditingController());
                          // Refresh to rebuild the UI
                          availabilityDayControllers.refresh();
                          availabilityStartTimeControllers.refresh();
                          availabilityEndTimeControllers.refresh();
                        },
                        child: Text('Add Another Availability'),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Collect all the pitch details and close dialog
              for (int i = 0; i < numberOfPitches; i++) {
                // Add pitch details logic here
                // Collect availability for each pitch
                List<Map<String, String>> availabilityList = [];
                for (var j = 0; j < availabilityDayControllers[i].length; j++) {
                  availabilityList.add({
                    'day': availabilityDayControllers[i][j].text,
                    'startTime': availabilityStartTimeControllers[i][j].text,
                    'endTime': availabilityEndTimeControllers[i][j].text,
                  });
                }
                // Add pitch details to the pitches list
                pitches.add({
                  'pitchName': pitchNameControllers[i].text,
                  'sportType': sportTypeControllers[i].text,
                  'size': sizeControllers[i].text,
                  'availability': availabilityList,
                });
              }
              Get.back();
            },
            child: Text('Add Pitches'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void showMultiPitchDialog(int numberOfPitches) {
    List<TextEditingController> pitchNameControllers =
        List.generate(numberOfPitches, (index) => TextEditingController());
    List<TextEditingController> sportTypeControllers =
        List.generate(numberOfPitches, (index) => TextEditingController());
    List<TextEditingController> sizeControllers =
        List.generate(numberOfPitches, (index) => TextEditingController());

    // List of strings for day selection
    var availabilityDays =
        List.generate(numberOfPitches, (index) => <String>['Select day']).obs;

    // Time controllers
    var availabilityStartTimeControllers = List.generate(numberOfPitches,
        (index) => <TextEditingController>[TextEditingController()]).obs;
    var availabilityEndTimeControllers = List.generate(numberOfPitches,
        (index) => <TextEditingController>[TextEditingController()]).obs;

    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        title: Text('Enter Details for Pitches'),
        content: SizedBox(
          width: double.maxFinite,
          // height: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(numberOfPitches, (index) {
                int pitchNumber = index + 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pitch $pitchNumber Details',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      CustomTextFormField(
                        controller: pitchNameControllers[index],
                        hintText: 'Pitch Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        controller: sportTypeControllers[index],
                        hintText: 'Sport Type',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        controller: sizeControllers[index],
                        hintText: 'Pitch Size (e.g., 50x100)',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => Column(
                          children: List.generate(
                            availabilityDays[index].length,
                            (availIndex) => Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                children: [
                                  /// Select day
                                  Expanded(
                                    flex: 1,
                                    child: CustomDropDown(
                                      icon: Container(
                                        child: CustomImageView(
                                            width: 14,
                                            imagePath: AppImages.imgArrowdown),
                                      ),
                                      hintText: "Select day",
                                      value: availabilityDays[index]
                                          [availIndex],
                                      items: [
                                        'Select day',
                                        'Monday',
                                        'Tuesday',
                                        'Wednesday',
                                        'Thursday',
                                        'Friday',
                                        'Saturday',
                                        'Sunday',
                                      ],
                                      boxDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 8.h, vertical: 14.h),
                                      onChanged: (value) {
                                        availabilityDays[index][availIndex] =
                                            value;
                                        availabilityDays.refresh();
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10),

                                  /// Start Time
                                  // Expanded(
                                  //   flex: 1,
                                  //   child: CustomTextFormField(
                                  //     controller:
                                  //         availabilityStartTimeControllers[
                                  //             index][availIndex],
                                  //     hintText: 'Start Time (e.g., 08:00)',
                                  //     hintStyle: TextStyle(color: Colors.grey),
                                  //     filled: true,
                                  //   ),
                                  // ),
                                  Expanded(
                                    flex: 1,
                                    child: TimeSelectionField(
                                      controller:
                                          availabilityStartTimeControllers[
                                              index][availIndex],
                                      hintText: 'Start Time (e.g., 08:00)',
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 1,
                                    child: TimeSelectionField(
                                      controller:
                                          availabilityEndTimeControllers[index]
                                              [availIndex],
                                      hintText: 'End Time (e.g., 20:00)',
                                    ),
                                    // child: CustomTextFormField(
                                    //   controller:
                                    //       availabilityEndTimeControllers[index]
                                    //           [availIndex],
                                    //   hintText: 'End Time (e.g., 20:00)',
                                    //   hintStyle: TextStyle(color: Colors.grey),
                                    //   filled: true,
                                    // ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          availabilityDays[index].add('Select day');
                          availabilityStartTimeControllers[index]
                              .add(TextEditingController());
                          availabilityEndTimeControllers[index]
                              .add(TextEditingController());
                          availabilityDays.refresh();
                          availabilityStartTimeControllers.refresh();
                          availabilityEndTimeControllers.refresh();
                        },
                        child: Text('Add Another Availability'),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              for (int i = 0; i < numberOfPitches; i++) {
                List<Map<String, String>> availabilityList = [];
                for (var j = 0; j < availabilityDays[i].length; j++) {
                  availabilityList.add({
                    'day': availabilityDays[i][j],
                    'startTime': availabilityStartTimeControllers[i][j].text,
                    'endTime': availabilityEndTimeControllers[i][j].text,
                  });
                }
                pitches.add({
                  'pitchName': pitchNameControllers[i].text,
                  'sportType': sportTypeControllers[i].text,
                  'size': sizeControllers[i].text,
                  'availability': availabilityList,
                });
              }
              Get.back();
            },
            child: Text('Add Pitches'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  ///
}
