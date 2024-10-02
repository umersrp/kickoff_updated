import 'dart:developer';

import 'package:appkickoff/vendor/common/text_form_field/text_form_field.dart';
import 'package:appkickoff/vendor/utils/constants/app_colors.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:appkickoff/vendor/vendor_features/models/manage_calender/manage_calender_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart'; 

class CalenderItem extends StatelessWidget {
  const CalenderItem({
    super.key,
    required this.daySchedule,
  });

  final DaySchedule daySchedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Row(
        children: [
          /// checkbox
          SizedBox(
            height: 24.0,
            width: 24.0,
            child: Checkbox(
              value: daySchedule.isSelected,
              activeColor: Colors.white,
              side: BorderSide.none,
              checkColor: AppColors.primary,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.white;
                  }
                  return Colors.white;
                },
              ),
              onChanged: (value) {},
            ),
          ),
          SizedBox(width: 5.h),

          /// day name
          SizedBox(
            width: 35,
            child: Text(
              daySchedule.day,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 14.fSize,
                  ),
            ),
          ),
          SizedBox(width: 10.h),

          /// start time
          Expanded(
            child: CustomTextFormField(
              onTap: () {
                log('time clicked');
                // controller.onTapTimeInput(context);
              },
              isDense: true,
              hintText: '9:00 am',
              readOnly: true,
              filled: true,
              // borderDecoration: InputBorder.none,
              borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.h),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.h, vertical: 8),
            ),
          ),
          SizedBox(width: 5.h),
          Text(
            '-',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Colors.white,
                  fontSize: 14.fSize,
                ),
          ),
          SizedBox(width: 5.h),

          /// End time
          Expanded(
            child: CustomTextFormField(
              onTap: () {
                log('time clicked');
                // controller.onTapTimeInput(context);
              },
              isDense: true,
              hintText: '9:00 am',
              readOnly: true,
              filled: true,
              borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.h),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.h, vertical: 8),
            ),
          ),

          /// Cross Icon
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 20.h),

          ///  add button
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              icon: Icon(
                Iconsax.add_circle,
                color: Colors.white,
              ),
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 10.h),

          ///
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              icon: Icon(
                // Iconsax.copy_success,
                Icons.content_copy_rounded,
                color: Colors.white,
              ),
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {},
            ),
          ),

          ///
        ],
      ),
    );
  }
}
