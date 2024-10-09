import 'package:appkickoff/vendor/common/app_bar/app_bar.dart';
import 'package:appkickoff/vendor/common/circular_container/circular_container.dart';
import 'package:appkickoff/vendor/common/rounded_image/rounded_image.dart';
import 'package:appkickoff/vendor/utils/constants/app_colors.dart';
import 'package:appkickoff/vendor/utils/constants/bg_image.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:appkickoff/vendor/vendor_features/models/booking_list/venue_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/shimmer/shimmer_effect.dart';
import '../../../utils/constants/app_images.dart';
import '../../controllers/view_listing_controller/view_listing_controller.dart';

class VenueDetailScreen extends StatelessWidget {
  final Venue venue;

  const VenueDetailScreen({Key? key, required this.venue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ViewListingController());
    return Stack(
      children: [
        BgImage(),
        Scaffold(
          backgroundColor: AppColors.primary.withOpacity(0.5),
          appBar: CustomAppBar(
            centerTitle: true,
            paddingTop: 10,
            leadingIcon: AppImages.arrow_back,
            leadingOnPressed: () => Get.back(),
            bgColor: Colors.transparent,
            title: Text(
              venue.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white, fontSize: 20.h),
            ),
          ),

          /// Main Contents
          body: SingleChildScrollView(
            child: Padding(
              // padding: const EdgeInsets.only(left: 24, right: 24),
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Carousel for displaying images
                  if (venue.images.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: _buildCarouselSlider(controller),
                    ),
                  const SizedBox(height: 16),

                  /// Venue details
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(14.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.h),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // name
                          DataItem(
                              title: 'Venue Name:',
                              value: venue.name,
                              fontSize: 16),
                          const SizedBox(height: 8),
                          // location
                          DataItem(title: 'Location:', value: venue.location),
                          const SizedBox(height: 5),
                          // days
                          // address
                          DataItem(
                              title: 'Address:',
                              value:
                                  '${venue.address.address}, ${venue.address.city}'),
                          const SizedBox(height: 5),
                          // capacity
                          DataItem(
                              title: 'Capacity:',
                              value: venue.capacity.toString()),
                          const SizedBox(height: 5),
                          // sports
                          DataItem(title: 'Sports:', value: venue.sports),
                          const SizedBox(height: 5),
                          // timing
                          DataItem(
                              title: 'Timings:',
                              value:
                                  '${venue.timings.first}, ${venue.timings.last}'),
                          const SizedBox(height: 5),
                          // price
                          DataItem(
                              title: 'Price:', value: venue.price.toString()),
                          const SizedBox(height: 5),
                          // number of pitches
                          DataItem(
                              title: 'Number Of Pitches:',
                              value: venue.numberOfPitches.toString()),
                          const SizedBox(height: 5),

                          // date

                          // Add more details as needed
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  /// pitches
                  ...venue.pitches
                      .map(
                        (pitch) => Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.all(14.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6.h),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // pitch name
                                    DataItem(
                                      title: 'Pitch Name:',
                                      value: '${pitch.pitchName}',
                                      fontSize: 16,
                                    ),
                                    const SizedBox(height: 8),
                                    DataItem(
                                        title: 'Sport Type:',
                                        value: pitch.sportType),
                                    DataItem(title: 'Size:', value: pitch.size),
                                    // Text(
                                    //     'Availability: ${pitch.availability.map((a) => "${a.day}: ${a.startTime} - ${a.endTime}").join(", ")}'),
                                    Text('Availability:',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    ...pitch.availability.map((e) => Column(
                                          children: [
                                            Text(
                                              'Day : ${e.day}, Start Time: ${e.startTime}, End Time: ${e.endTime}',
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16)
                          ],
                        ),
                      )
                      .toList(),

                  /// amenities
                  ///
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildCarouselSlider(ViewListingController controller) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
          items: venue.images.map((imageUrl) {
            return MyRoundedImage(
              width: double.maxFinite,
              fit: BoxFit.cover,
              backgroundColor: Colors.white,
              applyImageRadius: true,
              borderRadius: 6,
              imageUrl: imageUrl,
              isNetworkImage: true,
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < venue.images.length; i++)
                  AppCircularContainer(
                    width: 22,
                    height: 6,
                    margin: EdgeInsets.only(right: 10),
                    backgroundColor: controller.carousalCurrentIndex.value == i
                        ? AppColors.primary
                        : Colors.white,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DataItem extends StatelessWidget {
  const DataItem({
    super.key,
    required this.title,
    required this.value,
    this.fontSize = 14,
  });

  final String title;
  final String value;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
