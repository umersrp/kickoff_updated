import 'package:flutter/material.dart';

import 'app_images.dart'; 

class BgImage extends StatelessWidget {
  const BgImage({
    super.key,
    this.height = double.infinity,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
  });

  final double height;
  final double width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.bg),
          fit: fit,
        ),
      ),
    );
  }
}
