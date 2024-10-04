import 'dart:developer';

import 'package:appkickoff/vendor/common/custom_image_view/custom_image_view.dart';
import 'package:appkickoff/vendor/common/dropdown_button/dropdown_button.dart';
import 'package:appkickoff/vendor/common/text_form_field/text_form_field.dart';
import 'package:appkickoff/vendor/utils/constants/app_colors.dart';
import 'package:appkickoff/vendor/utils/constants/app_images.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:appkickoff/vendor/utils/validator/validator.dart';
import 'package:appkickoff/vendor/vendor_features/controllers/add_venue/add_venue_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controllers/add_venue/widgets/time_selection.dart';

class AddVenueForm extends StatelessWidget {
  const AddVenueForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddVenueController());
    return Form(
      key: controller.addVenueFormKey,
      child: Column(
        children: [
          /// name
          CustomTextFormField(
            controller: controller.nameController,
            hintText: 'Venue Name',
            hintStyle: Theme.of(Get.context!)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.blueGray100),
            validator: (value) =>
                MyValidator.validateEmptyText('Vendor Name', value),
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.h, vertical: 18),
          ),
          SizedBox(height: 10.h),

          /// location
          CustomTextFormField(
            controller: controller.locationController,
            hintText: 'Location',
            hintStyle: Theme.of(Get.context!)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.blueGray100),
            validator: (value) =>
                MyValidator.validateEmptyText('Location', value),
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.h, vertical: 18),
          ),
          SizedBox(height: 10.h),

          /// Image Picker (Add this section)

          Row(
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () async {
                  await controller.pickImage();
                },
                icon: Icon(Icons.image, size: 24),
                label: Text('Pick Image'),
              ),
              SizedBox(width: 10),
              Obx(() => Expanded(
                    child: controller.selectedImage.value != null
                        ? Container(
                            decoration: BoxDecoration(
                                color: AppColors.gray100,
                                borderRadius: BorderRadius.circular(12)
                                // color: Colors.white,
                                ),
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Center(
                              child: Text(
                                '${controller.selectedImage.value!.path.split('/').last}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.green),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          )
                        : Container(
                            // color: Colors.amber,
                            decoration: BoxDecoration(
                                color: AppColors.gray100,
                                borderRadius: BorderRadius.circular(12)
                                // color: Colors.white,
                                ),
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Center(
                              child: Text(
                                'No Image Selected',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ),
                  )),
            ],
          ),
          SizedBox(height: 10.h),

          /// Days
          CustomDropDown(
            icon: Container(
              child: CustomImageView(imagePath: AppImages.imgArrowdown),
            ),
            hintText: "Select Day",
            value: 'Select Day',
            items: [
              'Select Day',
              'Monday',
              'Tuesday',
              'Wednesday',
              'Thursday',
              'Friday',
              'Saturday',
              'Sunday',
            ],
            onChanged: (value) {
              controller.selectedDay.value = value;
            },
            boxDecoration:
                BoxDecoration(borderRadius: BorderRadius.circular(12)),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.h, vertical: 18.h),
          ),
          SizedBox(height: 10.h),

          /// Street Address
          CustomTextFormField(
            controller: controller.addressController,
            hintText: 'Street Address',
            hintStyle: Theme.of(Get.context!)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.blueGray100),
            validator: (value) =>
                MyValidator.validateEmptyText('Street Address', value),
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.h, vertical: 18),
          ),
          SizedBox(height: 10.h),

          /// City
          CustomTextFormField(
            controller: controller.cityController,
            hintText: 'City',
            hintStyle: Theme.of(Get.context!)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.blueGray100),
            validator: (value) => MyValidator.validateEmptyText('City', value),
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.h, vertical: 18),
          ),
          SizedBox(height: 10.h),

          /// Capacity
          CustomTextFormField(
            controller: controller.capacityController,
            hintText: 'Capacity',
            hintStyle: Theme.of(Get.context!)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.blueGray100),
            validator: (value) =>
                MyValidator.validateEmptyText('Capacity', value),
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.h, vertical: 18),
            textInputType: TextInputType.number,
          ),
          SizedBox(height: 10.h),

          /// Sports
          CustomDropDown(
            icon: Container(
              child: CustomImageView(imagePath: AppImages.imgArrowdown),
            ),
            hintText: "Select Sport",
            value: 'Select Sport',
            items: ['Select Sport', 'football', 'cricket'],
            onChanged: (value) {
              controller.selectedCategory.value = value;
            },
            boxDecoration:
                BoxDecoration(borderRadius: BorderRadius.circular(12)),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.h, vertical: 18.h),
          ),
          SizedBox(height: 10.h),

          /// Timings
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TimeSelectionField(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 18.h, vertical: 18),
                  suffix: Icon(Iconsax.timer_1, size: 24),
                  controller: controller.startTimingController,
                  hintText: 'Start Time',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: TimeSelectionField(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 18.h, vertical: 18),
                  suffix: Icon(Iconsax.timer_1, size: 24),
                  controller: controller.endTimingController,
                  hintText: 'End Time',
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          /// Price
          CustomTextFormField(
            controller: controller.priceController,
            hintText: 'Price (e.g. 5000)',
            hintStyle: Theme.of(Get.context!)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.blueGray100),
            validator: (value) => MyValidator.validateEmptyText('Price', value),
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.h, vertical: 18),
          ),
          SizedBox(height: 10.h),

          /// Number of Pitches
          CustomTextFormField(
            controller: controller.numberOfPitchesController,
            hintText: 'Number of Pitches',
            hintStyle: Theme.of(Get.context!)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.blueGray100),
            validator: (value) =>
                MyValidator.validateEmptyText('Number of Pitches', value),
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.h, vertical: 18),
            textInputType: TextInputType.number,
            // onTap: () {
            //   controller.addPitches();
            // },
            suffix: IconButton(
              icon: Icon(
                size: 24,
                Icons.add_circle_outline,
              ),
              onPressed: () {
                controller.addPitches();
              },
            ),
          ),
          SizedBox(height: 10.h),

          // /// amenities
          // CustomTextFormField(
          //   controller: controller.amenitiesController,
          //   hintText: 'Amenities',
          //   hintStyle: Theme.of(Get.context!)
          //       .textTheme
          //       .titleSmall!
          //       .copyWith(color: AppColors.blueGray100),
          //   validator: (value) =>
          //       MyValidator.validateEmptyText('Amenities', value),
          //   filled: true,
          //   contentPadding:
          //       EdgeInsets.symmetric(horizontal: 18.h, vertical: 18),
          // ),
          SizedBox(height: 10.h),

          /// submit button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                log('Login Button pressed!');
                controller.buildSubmit();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Obx(
                () => controller.isLoading.value
                    ? CircularProgressIndicator()
                    : Text(
                        'Submit',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Colors.white,
                              fontSize: 16.h,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
