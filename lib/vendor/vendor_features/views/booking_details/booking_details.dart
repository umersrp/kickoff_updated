import 'package:appkickoff/vendor/utils/constants/app_colors.dart';
import 'package:appkickoff/vendor/utils/constants/bg_image.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/book_venue/booking_venues.dart';

class BookingDetailsScreen extends StatelessWidget {
  final Booking booking;

  const BookingDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(booking.date);
    String formattedTime = DateFormat('hh:mm a').format(booking.date);
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
                    // _buildDetailItem(
                    //   context,
                    //   icon: Icons.confirmation_number,
                    //   title: 'Booking ID',
                    //   value: '${booking.id}',
                    // ),

                    /// Venue Name
                    _buildDetailItem(
                      context,
                      icon: Icons.location_on,
                      title: 'Venue Name',
                      value: '${booking.venue.name}',
                    ),

                    _buildDetailItem(
                      context,
                      icon: Icons.calendar_today,
                      title: 'Date',
                      value: '${formattedDate}',
                    ),

                    /// Time
                    _buildDetailItem(
                      context,
                      icon: Icons.access_time,
                      title: 'Time',
                      value: '${booking.slot.time}',
                    ),

                    /// Status
                    // _buildDetailItem(
                    //   context,
                    //   icon: Icons.check_circle,
                    //   title: 'Status',
                    //   value: 'Confirmed',
                    // ),

                    /// Created At
                    _buildDetailItem(
                      context,
                      icon: Icons.edit_calendar,
                      title: 'Created At',
                      value: '${formattedDate} ${formattedTime}',
                    ),

                    /// Client Name
                    _buildDetailItem(
                      context,
                      icon: Icons.person,
                      title: 'Client Email',
                      // value: 'John Doe',
                      value: '${booking.user.email}',
                    ),

                    /// Client Contact
                    _buildDetailItem(
                      context,
                      icon: Icons.phone,
                      title: 'Client Contact',
                      value: '${booking.user.phone}',
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

                  /// Title
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

              /// Spacer to push the text to the end of the row
              SizedBox(width: 16),

              /// Value text
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.fSize,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
}
