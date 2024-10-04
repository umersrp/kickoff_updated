import 'dart:developer';

import 'package:appkickoff/vendor/common/custom_image_view/custom_image_view.dart';
import 'package:appkickoff/vendor/utils/constants/app_colors.dart';
import 'package:appkickoff/vendor/utils/constants/app_images.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:appkickoff/vendor/vendor_features/models/booking_list/venue_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../manage_calender/manage_calender.dart';

class BookingListItemWidget extends StatelessWidget {
  const BookingListItemWidget({super.key, required this.bookingItem});

  final Venue bookingItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min ,
        children: [
          /// 1.  Venue Name
          Row(
            children: [
              CustomImageView(
                imagePath: AppImages.apple,
                height: 24.h,
                width: 24.h,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Venue Name',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14.fSize,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                        ),
                  ),
                  Text(
                    bookingItem.name,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.primary,
                          fontSize: 12.fSize,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                        ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10.h),

          /// 2.  address
          Row(
            children: [
              CustomImageView(
                imagePath: AppImages.apple,
                height: 24.h,
                width: 24.h,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Venue Address',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14.fSize,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  Text(
                    '${bookingItem.address.address}, ${bookingItem.address.city}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.primary,
                          fontSize: 12.fSize,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),

          /// Sports
          Row(
            children: [
              CustomImageView(
                imagePath: AppImages.apple,
                height: 24.h,
                width: 24.h,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14.fSize,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  Text(
                    bookingItem.date.toString(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.primary,
                          fontSize: 12.fSize,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),

          /// only number of pitches
          Row(
            children: [
              CustomImageView(
                imagePath: AppImages.apple,
                height: 24.h,
                width: 24.h,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14.fSize,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  Text(
                    bookingItem.location,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.primary,
                          fontSize: 12.fSize,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),

          /// Capacity
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: AppImages.apple,
                      height: 24.h,
                      width: 24.h,
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Created At',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 14.fSize,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                        Text(
                          bookingItem.numberOfPitches.toString(),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.primary,
                                    fontSize: 12.fSize,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// Manage Calendar Button
              SizedBox(
                height: 34,
                child: ElevatedButton(
                  onPressed: () {
                    log('Manage Calendar Button');
                    Get.to(() => ManageCalendarScreen(),
                        transition: Transition.rightToLeft);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.h),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  child: Text(
                    'Manage Calendar',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontSize: 12.fSize,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Hind',
                        ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
