import 'package:appkickoff/vendor/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
 

class MyFormDivider extends StatelessWidget {
  const MyFormDivider({
    super.key,
    required this.dividerText,
    this.color,
  });

  final String dividerText;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: AppColors.gray100,
            thickness: 0.5,
            // indent: 60,
            endIndent: 5,
          ),
        ),
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: color,
              ),
        ),
        Flexible(
          child: Divider(
            color: AppColors.gray100,
            thickness: 0.5,
            indent: 5,
            // endIndent: 60,
          ),
        ),
      ],
    );
  }
}
