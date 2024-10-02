import 'package:appkickoff/vendor/utils/constants/app_colors.dart';
import 'package:appkickoff/vendor/utils/constants/bg_image.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:flutter/material.dart'; 

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// bg image
        BgImage(),

        /// Mian Contents
        Scaffold(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
          body: Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 68, bottom: 24),
            child: Container(
              width: double.maxFinite,
              // height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.h),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),

                    /// booking detail
                    Center(
                      child: Text(
                        'Booking Details',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: AppColors.primary,
                              fontSize: 18.h,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    SizedBox(height: 30.h),

                    /// booking ID
                    _buildDetailItem(
                      context,
                      icon: Icons.confirmation_number,
                      title: 'Booking ID',
                      value: 'BN-8688854',
                    ),

                    /// Venue Name
                    _buildDetailItem(
                      context,
                      icon: Icons.location_on,
                      title: 'Venue Name',
                      value: 'Conference A',
                    ),

                    _buildDetailItem(
                      context,
                      icon: Icons.calendar_today,
                      title: 'Date',
                      value: '14/07/2024',
                    ),

                    /// Time
                    _buildDetailItem(
                      context,
                      icon: Icons.access_time,
                      title: 'Time',
                      value: '9:00 AM - 11:00 AM',
                    ),

                    /// Status
                    _buildDetailItem(
                      context,
                      icon: Icons.check_circle,
                      title: 'Status',
                      value: 'Confirmed',
                    ),

                    /// Created At
                    _buildDetailItem(
                      context,
                      icon: Icons.edit_calendar,
                      title: 'Created At',
                      value: '10/07/2024, 8:00 AM',
                    ),

                    /// Client Name
                    _buildDetailItem(
                      context,
                      icon: Icons.person,
                      title: 'Client Name',
                      value: 'John Doe',
                    ),

                    /// Client Contact
                    _buildDetailItem(
                      context,
                      icon: Icons.phone,
                      title: 'Client Contact',
                      value: '+1234567890',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///
  Widget _buildDetailItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(8.h),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Icon
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 24.h,
                  ),
                  SizedBox(width: 16.h),

                  /// Title and Value
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.fSize,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.fSize,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              // SizedBox(width: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  ///
}
