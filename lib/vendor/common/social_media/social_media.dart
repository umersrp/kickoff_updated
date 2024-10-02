import 'dart:developer';

import 'package:flutter/material.dart';
import '../../utils/constants/app_images.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSocialButton(AppImages.facebook),
        _buildSocialButton(AppImages.google),
        _buildSocialButton(AppImages.apple),
      ],
    );
  }

  Widget _buildSocialButton(String assetPath) {
    return GestureDetector(
      onTap: () {
        log('Social Button tapped!');
      },
      child: Container(
        width: 110,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        // child: Ass(assetPath),
        child: Image(
          height: 20,
          width: 20,
          // fit: BoxFit.cover,
          image: AssetImage(assetPath),
        ),
      ),
    );
  }
}
