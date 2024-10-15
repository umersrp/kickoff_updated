import 'dart:developer';
import 'dart:io';

import 'package:appkickoff/vendor/common/dropdown_button/dropdown_button.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:appkickoff/vendor/vendor_features/views/view_listing/view_listing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/app_snackbars/snackbars.dart';
import '../../../common/custom_image_view/custom_image_view.dart';
import '../../../common/text_form_field/text_form_field.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/helpers/http_helper.dart';
import '../view_listing_controller/view_listing_controller.dart';
import 'widgets/time_selection.dart';

class AddVenueController extends GetxController {
  static AddVenueController get instance => Get.find();

  /// vars
  final addVenueFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final dayController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final capacityController = TextEditingController();
  final startTimingController = TextEditingController();
  final endTimingController = TextEditingController();
  final priceController = TextEditingController();
  final numberOfPitchesController = TextEditingController();
  final amenitiesController = TextEditingController();

  // File? selectedImage;
  var selectedImage = Rx<File?>(null);
  var selectedCategory = ''.obs;
  var selectedDay = ''.obs;
  var pitches = [].obs;

  final isLoading = false.obs;
  final token = ''.obs;

  /// oninit
  @override
  Future<void> onInit() async {
    super.onInit();
    token.value = await getToken();
    // log('token.value == ${token.value}');
  }

  /// get token
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken') ?? '';
    // log('Token In Create Venue: $token');
    return token;
  }

  /// Function to pick image from gallery
  Future<void> pickImage() async {
    try {
      final pickedImage = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (pickedImage == null) return;
      selectedImage.value = File(pickedImage.path);
      update(); // To update UI after image is picked
    } catch (e) {
      log('picked Image Funtion ::: $e');
    }
  }

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

      /// Authorization headers
      var headers = {
        'Authorization': 'Bearer ${token.value}',
        'Content-Type': 'multipart/form-data',
      };

      /// Create the Multipart request
      var _baseUrl = VendorHttpHelper.baseUrl;
      var url = Uri.parse('$_baseUrl/vendor/venue/create-venue');

      var request = http.MultipartRequest('POST', url);

      /// Add the form fields
      request.fields.addAll({
        'name': nameController.text.trim(),
        'location': locationController.text.trim(),
        'days': dayController.text.trim(),
        // 'days': selectedDay.value.isNotEmpty ? selectedDay.value : 'Monday',
        'address[address]': addressController.text.trim(),
        'address[city]': cityController.text.trim(),
        'capacity': capacityController.text.trim(),
        // 'sports': selectedCategory.value,
        'sports': selectedCategory.value.isNotEmpty
            ? selectedCategory.value
            : 'football',
        'timings[0]': startTimingController.text.trim(),
        'timings[1]': endTimingController.text.trim(),
        'price': priceController.text.trim(),
        'numberOfPitches': numberOfPitchesController.text.trim(),
        // 'vendorId': '66fbf10fa333a95cfea62b67',
        // 'amenities[]': '66ec131c1da9ed250e2ff36b',
      });

      for (int i = 0; i < pitches.length; i++) {
        var pitch = pitches[i];

        // Ensure the fields are not null or empty
        // String pitchName = pitch['pitchName']; // ?? 'Pitch A';
        // String sportType = pitch['sportType']; //?? 'football';
        // String size = pitch['size']; // ?? '20x50';
        // String slotDuration = pitch['slotduration']; //?? '1';
        String pitchName = pitch['pitchName'] ?? 'Pitch A';
        String sportType = pitch['sportType'] ?? 'football';
        String size = pitch['size'] ?? '20x50';
        String slotDuration = pitch['slotduration'] ?? '1';

        log('Pitch Name :: $pitchName');
        log('Pitch Sport Type:: $sportType');
        log('Pitch Size :: $size');
        log('Pitch Slot Duration :: $slotDuration');

        request.fields.addAll({
          'pitches[$i][pitchName]': pitchName,
          'pitches[$i][sportType]': sportType,
          'pitches[$i][size]': size,
          'pitches[$i][slotduration]': slotDuration,
        });

        // Add availability details for each pitch
        for (int j = 0; j < pitch['availability'].length; j++) {
          var availability = pitch['availability'][j];

          String day = availability['day'] ?? 'Monday';
          String startTime = availability['startTime'] ?? '09:00';
          String endTime = availability['endTime'] ?? '18:00';

          request.fields.addAll({
            'pitches[$i][availability][$j][day]': day,
            'pitches[$i][availability][$j][startTime]': startTime,
            'pitches[$i][availability][$j][endTime]': endTime,
          });
        }
      }

      /// Add image to the request if selected
      if (selectedImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          selectedImage.value!.path,
        ));
      }
      // Add headers to request
      request.headers.addAll(headers);
      // Send the request
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        isLoading(false);
        log(await response.stream.bytesToString());
        // Return to the home screen with a result
        Get.back(result: true);
        // Get.off(() => ViewListingScreen(), transition: Transition.leftToRight);
      } else {
        log('Failed: ${response.reasonPhrase}');
        // Error handling
      }

      ///
    } catch (e) {
      log('Error: $e');
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

  void showMultiPitchDialog(int numberOfPitches) {
    List<TextEditingController> pitchNameControllers =
        List.generate(numberOfPitches, (index) => TextEditingController());
    List<TextEditingController> sportTypeControllers =
        List.generate(numberOfPitches, (index) => TextEditingController());
    List<TextEditingController> sizeControllers =
        List.generate(numberOfPitches, (index) => TextEditingController());
    List<TextEditingController> slotdurationControllers =
        List.generate(numberOfPitches, (index) => TextEditingController());

    var availabilityDays =
        List.generate(numberOfPitches, (index) => <String>['Select day']).obs;

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
                      CustomDropDown(
                        icon: Container(
                          child: CustomImageView(
                              imagePath: AppImages.imgArrowdown),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 18.h, vertical: 13.h),
                        hintText: "Select Sport",
                        items: ['Select Sport', 'football', 'cricket'],
                        value: sportTypeControllers[index].text.isEmpty
                            ? 'Select Sport'
                            : sportTypeControllers[index].text,
                        onChanged: (value) {
                          sportTypeControllers[index].text = value;
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        controller: sizeControllers[index],
                        hintText: 'Pitch Size (e.g., 50x100)',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                      ),
                      SizedBox(height: 10),

                      /// slot duration
                      CustomTextFormField(
                        controller: slotdurationControllers[index],
                        hintText: 'Slot Duration (e.g. 1)',
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

                /// Add the pitch data including slot duration
                pitches.add({
                  'pitchName': pitchNameControllers[i].text,
                  'sportType': sportTypeControllers[i].text,
                  'size': sizeControllers[i].text,
                  'slotduration':
                      slotdurationControllers[i].text, // Fix: add slotduration
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
}

  