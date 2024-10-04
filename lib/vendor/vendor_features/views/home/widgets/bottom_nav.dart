// Custom Bottom Navigation Bar Widget
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';


class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(50.h)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5.h,
            offset: Offset(0, -3.h),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: AppColors.primary,
              size: 30.h,
            ),
            onPressed: () {
              // Handle home button press
            },
          ),
          IconButton(
            icon: Icon(
              Icons.calendar_today,
              color: AppColors.primary,
              size: 30.h,
            ),
            onPressed: () {
              // Handle calendar button press
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: AppColors.primary,
              size: 30.h,
            ),
            onPressed: () {
              // Handle delete button press
            },
          ),
        ],
      ),
    );
  }
}
