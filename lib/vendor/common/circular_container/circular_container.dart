import 'package:flutter/material.dart';

class AppCircularContainer extends StatelessWidget {
  const AppCircularContainer({
    super.key,
    this.width,
    this.height,
    this.radius = 400,
    this.padding,
    this.margin,
    this.child,
    this.backgroundColor = Colors.white,
  });

  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
