import 'dart:developer';

import 'package:appkickoff/vendor/common/text_form_field/text_form_field.dart';
import 'package:appkickoff/vendor/utils/constants/app_colors.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:appkickoff/vendor/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controllers/login_controller/login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VendorLoginController());

    return Form(
      key: controller.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Email.
          Text(
            'Email Address',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(height: 5),
          CustomTextFormField(
            controller: controller.emailController,
            textInputType: TextInputType.emailAddress,
            hintText: 'Email Address',
            // textInputAction: TextInputAction.done,
            validator: (value) => MyValidator.validateEmail(value),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.h, vertical: 18.h),
            filled: true,
            fillColor: AppColors.gray50,
            // borderDecoration: InputBorder.none,
          ),

          const SizedBox(height: 20),

          /// password
          Text(
            'Password',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(height: 5),
          Obx(
            () => CustomTextFormField(
              controller: controller.passwordController,
              obscureText: controller.hidePassword.value,
              hintText: '********',
              // textInputAction: TextInputAction.done,
              validator: (value) =>
                  MyValidator.validateEmptyText('Password', value),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 18.h, vertical: 18.h),
              filled: true,
              fillColor: AppColors.gray50,
              suffix: IconButton(
                onPressed: () => controller.hidePassword.value =
                    !controller.hidePassword.value,
                icon: Icon(controller.hidePassword.value
                    ? Iconsax.eye_slash
                    : Iconsax.eye),
              ),
            ),
          ),

          /// forget password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {}, // => Get.to(() => ForgetPassword()),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: Text(
                'Forgot password?',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),

          /// login button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                log('Login Button pressed!');
                controller.buildLogin();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gray100,
              ),
              child: Text(
                'Log In',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.primary,
                      fontSize: 16.h,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),

          ///
        ],
      ),
    );
  }
}
