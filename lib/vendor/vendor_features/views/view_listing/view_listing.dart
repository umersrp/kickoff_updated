import 'dart:developer';

import 'package:appkickoff/vendor/common/app_bar/app_bar.dart';
import 'package:appkickoff/vendor/common/filter_btn_img/filter_btn_img.dart';
import 'package:appkickoff/vendor/common/text_form_field/text_form_field.dart';
import 'package:appkickoff/vendor/utils/constants/app_colors.dart';
import 'package:appkickoff/vendor/utils/constants/app_images.dart';
import 'package:appkickoff/vendor/utils/constants/bg_image.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:appkickoff/vendor/vendor_features/controllers/view_listing_controller/view_listing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../add_venue/add_venue.dart';
import 'widget/booking_item_shimmer.dart';
import 'widget/booking_list_item.dart';

class ViewListingScreen extends StatelessWidget {
  const ViewListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ViewListingController());
    return Stack(
      children: [
        /// bg image
        BgImage(),

        ///  Mian Content
        Scaffold(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),

          /// appbar
          appBar: CustomAppBar(
            paddingTop: 10,
            bgColor: Colors.transparent,
            leadingIcon: AppImages.arrow_back,
            leadingOnPressed: () => Get.back(),
            centerTitle: true,
            title: Text(
              'View Listings',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white, fontSize: 20.h),
            ),
            actions: [
              IconButton.filled(
                onPressed: () async {
                  var result = await Get.to(() => AddVenueScreen());
                  //transition: Transition.rightToLeft,
                  if (result == true) {
                    controller.fetchVenues(isRefresh: true);
                  }
                },
                icon: Icon(
                  Iconsax.add_circle,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 12)
            ],
          ),

          /// main content
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchSection(),
                SizedBox(height: 14.h),
                // _buildFilterSection(),
                // SizedBox(height: 20.h),
                _buildBookingList(controller),
              ],
            ),
          ),

          ///
        ),
      ],
    );
  }

  _buildBookingList(ViewListingController controller) {
    return Obx(
      () {
        if (controller.isLoading.value && controller.currentPage.value == 1) {
          // return const Text('Data loading');
          return Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (_, __) {
                return BookingListItemShimmer();
              },
            ),
          );
        } else {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent &&
                  !controller.isLoading.value &&
                  controller.hasNextPage.value) {
                controller.fetchVenues();
              }
              return false;
            },
            child: Expanded(
              child: ListView.separated(
                controller: controller.scrollController,
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.vendorVenues.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (_, index) {
                  return BookingListItemWidget(
                    bookingItem: controller.vendorVenues[index],
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  _buildFilterSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomFilterButtonWithImage(
          title: 'Filter',
          imagePath: AppImages.filter_1,
        ),

        /// 2.
        CustomFilterButtonWithImage(
          title: 'Filter',
          imagePath: AppImages.icon8_4,
        ),

        /// 3. downArrow
        CustomFilterButtonWithImage(
          title: 'Filter',
          imagePath: AppImages.downArrow,
        ),

        /// 4. downArrow
        CustomFilterButtonWithImage(
          title: 'Filter',
          imagePath: AppImages.downArrow,
        ),

        /// 5. downArrow
        CustomFilterButtonWithImage(
          title: 'Filter',
          imagePath: AppImages.downArrow,
        ),
      ],
    );
  }

  _buildSearchSection() {
    return Container(
      width: double.infinity,
      // margin: EdgeInsets.only(right: 6.h),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              textStyle: Theme.of(Get.context!)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white),
              borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.h),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              prefix: Icon(Icons.search, color: Colors.white),
              hintText: 'Type here to search something',
              hintStyle: Theme.of(Get.context!)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white),
            ),
          ),
          SizedBox(width: 8.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gray100,
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: () {},
            child: Text('Search'),
          ),
        ],
      ),
    );
  }
}
