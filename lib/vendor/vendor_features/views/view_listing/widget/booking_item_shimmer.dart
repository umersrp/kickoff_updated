import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/shimmer/shimmer_effect.dart';

class BookingListItemShimmer extends StatelessWidget {
  const BookingListItemShimmer({super.key});

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
        children: [
          /// 1. Shimmer for Venue Name
          Row(
            children: [
              AppShimmerEffect(
                width: 24.h,
                height: 24.h,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmerEffect(
                    width: 100,
                    height: 10,
                  ),
                  SizedBox(height: 5),
                  AppShimmerEffect(
                    width: 150,
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),

          /// 2. Shimmer for Venue Address
          Row(
            children: [
              AppShimmerEffect(
                width: 24.h,
                height: 24.h,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmerEffect(
                    width: 100,
                    height: 10,
                  ),
                  SizedBox(height: 5),
                  AppShimmerEffect(
                    width: 150,
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),

          /// 3. Shimmer for Sports
          Row(
            children: [
              AppShimmerEffect(
                width: 24.h,
                height: 24.h,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmerEffect(
                    width: 100,
                    height: 10,
                  ),
                  SizedBox(height: 5),
                  AppShimmerEffect(
                    width: 150,
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),

          /// only number of pitches
          Row(
            children: [
              AppShimmerEffect(
                width: 24.h,
                height: 24.h,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmerEffect(
                    width: 100,
                    height: 10,
                  ),
                  SizedBox(height: 5),
                  AppShimmerEffect(
                    width: 150,
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),

          /// 4. Shimmer for Capacity
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    AppShimmerEffect(
                      width: 24.h,
                      height: 24.h,
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppShimmerEffect(
                          width: 100,
                          height: 10,
                        ),
                        SizedBox(height: 5),
                        AppShimmerEffect(
                          width: 150,
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppShimmerEffect(
                width: 100,
                height: 34,
                radius: 12,
              )
            ],
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
