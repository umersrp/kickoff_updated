import 'dart:developer';

import 'package:appkickoff/vendor/authentication/controllers/signup_controller/signup_controller.dart';
import 'package:appkickoff/vendor/authentication/views/login/vendor_login.dart';
import 'package:appkickoff/vendor/common/text_form_field/text_form_field.dart';
import 'package:appkickoff/vendor/utils/constants/app_colors.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:appkickoff/vendor/utils/validator/validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Form(
      key: controller.signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// name.
          Text(
            'Vendor Name',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(height: 5),
          CustomTextFormField(
            controller: controller.vendorNameController,
            hintText: 'Vendor Name',
            validator: (value) =>
                MyValidator.validateEmptyText('Vendor Name', value),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.h, vertical: 18.h),
            filled: true,
            fillColor: AppColors.gray100,
            
          ),
          const SizedBox(height: 10),

          /// phone number.
          Text(
            'Phone Number',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(height: 5),
          CustomTextFormField(
            controller: controller.phoneNumberController,
            hintText: 'Phone Number',
            textInputType: TextInputType.number,
            validator: (value) {
              if (!MyValidator.isValidPhone(value)) {
                return 'please enter valid phone number';
              }
              return null;
            },
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.h, vertical: 18.h),
            filled: true,
            fillColor: AppColors.gray100,
          ),
          const SizedBox(height: 10),

          /// email.
          Text(
            'Email',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(height: 5),
          CustomTextFormField(
            controller: controller.emailAddressController,
            hintText: 'Email Address',
            textInputType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null ||
                  (!MyValidator.isValidEmail(value, isRequired: true))) {
                return "Please enter valid email";
              }
              return null;
            },
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.h, vertical: 18.h),
            filled: true,
            fillColor: AppColors.gray100,
          ),
          const SizedBox(height: 10),

          /// password.
          Text(
            'Create a password',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(height: 5),
          Obx(() => CustomTextFormField(
                controller: controller.passwordController,
                obscureText: controller.hidePassword.value,
                hintText: 'Password',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 18.h, vertical: 18.h),
                filled: true,
                fillColor: AppColors.gray100,
                suffix: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
              )),
          const SizedBox(height: 10),

          /// confirm password.
          Text(
            'Confirm password',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(height: 5),
          Obx(() => CustomTextFormField(
                controller: controller.confirmPasswordController,
                obscureText: controller.confirmPassword.value,
                hintText: 'Confirm Password',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 18.h, vertical: 18.h),
                filled: true,
                fillColor: AppColors.gray100,
                suffix: IconButton(
                  onPressed: () => controller.confirmPassword.value =
                      !controller.confirmPassword.value,
                  icon: Icon(controller.confirmPassword.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != controller.passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              )),
          const SizedBox(height: 30),

          /// sign up button.
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                log('Login Button pressed!');
                controller.buildSignUp();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gray100,
              ),
              child: Text(
                'Sign Up',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.primary,
                      fontSize: 16.h,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 30),

          /// login text
          Center(
            child: RichText(
              text: TextSpan(
                text: "Already have an account? ",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: 15.h,
                      color: AppColors.gray100,
                    ),
                children: [
                  TextSpan(
                    text: "Log in",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 16.h,
                          color: Colors.white,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        log('Sign up text tapped!');
                        Get.back();
                        // Get.to(() => VendorLoginScreen(),
                        //     transition: Transition.rightToLeft);
                      },
                  ),
                ],
              ),
            ),
          ),

          ///
        ],
      ),
    );
  }
}
