import 'dart:developer';

import 'package:appkickoff/vendor/authentication/views/login/widgets/login_form.dart';
import 'package:appkickoff/vendor/authentication/views/sign_up/signup.dart';
import 'package:appkickoff/vendor/common/divider/divider.dart';
import 'package:appkickoff/vendor/common/headers/login_header.dart';
import 'package:appkickoff/vendor/common/social_media/social_media.dart';
import 'package:appkickoff/vendor/utils/constants/app_colors.dart';
import 'package:appkickoff/vendor/utils/constants/bg_image.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorLoginScreen extends StatelessWidget {
  const VendorLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BgImage(),
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
                  const LoginHeader(title: 'Log in'),
                  const SizedBox(height: 40),

                  /// 2. Form...
                  const LoginForm(),
                  const SizedBox(height: 30),

                  ///3.  Divider
                  MyFormDivider(
                    dividerText: 'or Log in with'.capitalize!,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),

                  /// 4. Social Login Buttons
                  SocialButton(),
                  const SizedBox(height: 80),

                  /// 7. Sign Up Link
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontSize: 15.h,
                              color: AppColors.gray100,
                            ),
                        children: [
                          TextSpan(
                            text: "Sign up",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  fontSize: 16.h,
                                  color: Colors.white,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                log('Sign up text tapped!');
                                Get.to(() => VendorSignupScreen(),
                                    transition: Transition.rightToLeft);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
