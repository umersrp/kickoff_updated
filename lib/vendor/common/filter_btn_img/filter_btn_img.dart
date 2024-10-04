import 'package:appkickoff/vendor/common/custom_image_view/custom_image_view.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:flutter/material.dart'; 
 
class CustomFilterButtonWithImage extends StatelessWidget {
  const CustomFilterButtonWithImage({
    super.key,
    required this.title,
    this.imagePath,
  });

  final String title;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.h),
        border: Border.all(
          color: Colors.white,
          width: 1.h,
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 10.h),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12.fSize,
                  color: Colors.white,
                ),
          ),
          SizedBox(width: 10.h),
          CustomImageView(
            imagePath: imagePath,
            height: 18.h,
            width: 20.h,
          ),
          SizedBox(width: 2.h),
        ],
      ),
    );
  }
}
