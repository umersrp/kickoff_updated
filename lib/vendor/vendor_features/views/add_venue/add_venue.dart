import 'package:appkickoff/vendor/common/app_bar/app_bar.dart';
import 'package:appkickoff/vendor/common/custom_image_view/custom_image_view.dart';
import 'package:appkickoff/vendor/utils/constants/app_colors.dart';
import 'package:appkickoff/vendor/utils/constants/app_images.dart';
import 'package:appkickoff/vendor/utils/constants/bg_image.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/widgets/bottom_nav.dart';
import 'widgets/add_venue_form.dart';

class AddVenueScreen extends StatelessWidget {
  const AddVenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// bg image
        BgImage(),

        /// main content
        Scaffold(
          backgroundColor: AppColors.primary.withOpacity(0.5),

          /// appbar
          appBar: CustomAppBar(
            paddingTop: 20,
            bgColor: Colors.transparent,
            leadingIcon: AppImages.arrow_back,
            leadingOnPressed: () => Get.back(),
            centerTitle: true,
            title: CustomImageView(
              height: 50,
              width: 60,
              imagePath: AppImages.logo5000x5000,
            ),
          ),

          ////
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  // SizedBox(height: 30.h),

                  /// 1. Logo, Title & SubTitle
                  Text(
                    'Add Venue',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 20.h,
                        ),
                  ),
                  SizedBox(height: 14.h),

                  /// 2. Form...
                  const AddVenueForm(),

                  ///
                ],
              ),
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
