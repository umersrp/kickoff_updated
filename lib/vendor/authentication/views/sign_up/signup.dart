import 'package:appkickoff/vendor/authentication/controllers/signup_controller/signup_controller.dart';
import 'package:appkickoff/vendor/common/app_bar/app_bar.dart';
import 'package:appkickoff/vendor/common/headers/login_header.dart';
import 'package:appkickoff/vendor/utils/constants/app_colors.dart';
import 'package:appkickoff/vendor/utils/constants/bg_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/app_images.dart';
import 'widgets/signup_form.dart';

class VendorSignupScreen extends StatelessWidget {
  const VendorSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<SignupController>(SignupController());

    return FutureBuilder(
      future: precacheImage(AssetImage(AppImages.bg), context),
      builder: (context, snapshot) {
        // Wait until the background image is fully loaded
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              /// bg image
              BgImage(),

              /// Scaffold
              Scaffold(
                key: UniqueKey(),
                backgroundColor: AppColors.primary.withOpacity(0.5),

                /// app bar
                appBar: CustomAppBar(
                  paddingTop: 10,
                  bgColor: Colors.transparent, //primary.withOpacity(0.5),
                  leadingIcon: AppImages.arrow_back,
                  leadingOnPressed: () => Get.back(),
                ),

                /// Main body
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 1. Logo, Title & SubTitle
                        // const SizedBox(height: 54),
                        const LoginHeader(title: 'Sign up'),
                        const SizedBox(height: 30),

                        /// 2. Form...
                        const SignupForm(),
                        const SizedBox(height: 30),

                        ///
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
          // While the background image is loading, show a loading indicator
          return Scaffold(
            backgroundColor: AppColors.primary.withOpacity(0.5),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
