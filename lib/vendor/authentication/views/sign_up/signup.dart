import 'package:appkickoff/vendor/authentication/controllers/signup_controller/signup_controller.dart';
import 'package:appkickoff/vendor/common/headers/login_header.dart';
import 'package:appkickoff/vendor/utils/constants/app_colors.dart';
import 'package:appkickoff/vendor/utils/constants/bg_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/signup_form.dart';

class VendorSignupScreen extends StatelessWidget {
  const VendorSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<SignupController>(SignupController());

    return Stack(
      children: [
        /// bg image
        BgImage(),

        /// Scaffold
        Scaffold(
          key: UniqueKey(),
          backgroundColor: AppColors.primary.withOpacity(0.5),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 1. Logo, Title & SubTitle
                  const SizedBox(height: 54),
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
  }
}
