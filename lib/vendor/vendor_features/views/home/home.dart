import 'dart:developer';

import 'package:appkickoff/vendor/common/app_bar/app_bar.dart';
import 'package:appkickoff/vendor/common/custom_image_view/custom_image_view.dart';
import 'package:appkickoff/vendor/utils/constants/app_colors.dart';
import 'package:appkickoff/vendor/utils/constants/app_images.dart';
import 'package:appkickoff/vendor/utils/constants/bg_image.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:appkickoff/vendor/vendor_features/controllers/home_controller/home_controller.dart';
import 'package:appkickoff/vendor/vendor_features/views/add_venue/add_venue.dart';
import 'package:appkickoff/vendor/vendor_features/views/view_booking/view_booking.dart';
import 'package:appkickoff/vendor/vendor_features/views/view_listing/view_listing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/bottom_nav.dart';
import 'widgets/custom_button.dart';
import 'widgets/home_header.dart';

class VendorHomeScreen extends StatelessWidget {
  const VendorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Stack(
      children: [
        /// Background Image
        BgImage(),

        /// Scaffold with semi-transparent background
        Scaffold(
          backgroundColor: AppColors.primary.withOpacity(0.5),

          /// appbar
          appBar: CustomAppBar(
            paddingTop: 10,
            bgColor: Colors.transparent,
            leadingIcon: AppImages.arrow_back,
            centerTitle: true,
            title: CustomImageView(
              // height: 50,
              width: 60,
              // imagePath: AppImages.imgKickOffAcademy,
              imagePath: AppImages.logo5000x5000,
            ),
          ),

          ////
          body: Padding(
            padding: EdgeInsets.all(24.h),
            child: Column(
              children: [
                /// Header Section
                const HomeHeader(),
                SizedBox(height: 120.h),

                /// Main Buttons
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        text: 'Venue Listings',
                        onTap: () => Get.to(
                          () => ViewListingScreen(),
                          transition: Transition.rightToLeft,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: 'View Bookings',
                        onTap: () {
                          log('Tapped on Button');
                          Get.to(
                            () => ViewBookingScreen(),
                            transition: Transition.rightToLeft,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// Bottom Navigation Bar
          // bottomNavigationBar: Padding(
          //   padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
          //   child: CustomBottomNavBar(),
          // ),
        ),
      ],
    );
  }
}
