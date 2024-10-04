import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart'; 
 
import '../../utils/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.paddingTop = 0.0,
      this.paddingBottom = 0.0,
      this.paddingleft = 0.0,
      this.paddingright = 0.0,
      this.showBackground = false,
      this.title,
      this.actions,
      this.leadingIcon,
      this.leadingOnPressed,
      this.showBackArrow = false,
      this.centerTitle = false,
      this.bgColor = Colors.white});

  final double? paddingTop;
  final double? paddingBottom;
  final double? paddingleft;
  final double? paddingright;
  final Widget? title;
  final Color? bgColor;

  final bool showBackground;
  final bool showBackArrow;
  final bool centerTitle;
  final dynamic leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: paddingleft!,
        top: paddingTop!,
        right: paddingright!,
        bottom: paddingBottom!,
      ),
      child: AppBar(
        backgroundColor: bgColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: AppColors.primary,
        ),
        automaticallyImplyLeading: false,
        centerTitle: centerTitle,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Iconsax.arrow_left,
                  color: Colors.black,
                ),
              )
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed,
                    icon: leadingIcon is String
                        ? SvgPicture.asset(
                            leadingIcon, // Agar String ho to SVG load karega
                            color: Colors.white,
                            width: 10.0,
                            height: 20.0,
                          )
                        : Icon(
                            leadingIcon, // Agar IconData ho to Icon load karega
                            color: showBackground ? Colors.white : Colors.black,
                          ),
                  )
                : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(getAppBarHeight() + paddingTop!);

  static double getAppBarHeight() {
    return kToolbarHeight;
  }
}
