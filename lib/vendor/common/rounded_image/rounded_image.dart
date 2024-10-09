import 'package:appkickoff/vendor/common/shimmer/shimmer_effect.dart';
import 'package:appkickoff/vendor/utils/constants/app_images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyRoundedImage extends StatelessWidget {
  const MyRoundedImage({
    super.key,
    this.border,
    this.padding,
    this.onPressed,
    this.width,
    this.height,
    this.applyImageRadius = true,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.backgroundColor,
    this.isNetworkImage = false,
    this.borderRadius = 16,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        // make radius
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: fit,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: AppShimmerEffect(
                      width: width ?? double.infinity,
                      height: height ?? 158,
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    AppImages.venueTest,
                    fit: fit,
                    width: width,
                    height: height,
                  ),
                )
              : Image.asset(
                  imageUrl,
                  fit: fit,
                  width: width,
                  height: height,
                ),
        ),
      ),
    );
  }
}
