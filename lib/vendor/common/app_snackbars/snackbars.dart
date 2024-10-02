import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/app_colors.dart';
 

class AppSnackbars {
  AppSnackbars._(); 

  /// success
  static successSnackBar({required title, message = '', duration = 5}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText:  Colors.white,
      backgroundColor: AppColors.success,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Iconsax.check, color:  Colors.white),
    );
  }

  /// Warning
  static warningSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText:  Colors.white,
      backgroundColor: AppColors.warning,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: Colors.white),
    );
  }

  /// errorSnackBar
  static errorSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText:  Colors.white,
      backgroundColor: AppColors.error,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: Colors.white),
    );
  }

  /// custom toast
  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: EdgeInsets.all(12.0),
          margin: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.darkerGrey.withOpacity(0.9)
          ),
          child: Center(
            child: Text(
              message,
              style: Theme.of(Get.context!).textTheme.labelLarge,
            ),
          ),
        ),
      ),
    );
  }

  ///
}