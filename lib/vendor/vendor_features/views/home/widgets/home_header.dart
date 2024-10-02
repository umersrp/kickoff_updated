import 'package:appkickoff/vendor/utils/constants/app_images.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:appkickoff/vendor/vendor_features/controllers/home_controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo and Welcome Text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Text(
                'Hey ${controller.username.value}!',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            SizedBox(height: 10.h),
            Text('Let us help you stay organized',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    )),
          ],
        ),

        // Profile Picture
        CircleAvatar(
          radius: 25.h,
          // backgroundImage: AssetImage(AppImages.logo), // Your profile pic
          backgroundImage: AssetImage(AppImages.logo5000x5000),
        ),
      ],
    );
  }
}
