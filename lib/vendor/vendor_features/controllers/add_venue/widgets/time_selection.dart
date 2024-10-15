import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../common/text_form_field/text_form_field.dart';
import '../../../../utils/constants/app_colors.dart';

class TimeSelectionField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? suffix;
  final EdgeInsets? contentPadding;

  TimeSelectionField({
    required this.controller,
    required this.hintText,
    this.suffix,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      hintText: hintText,
      hintStyle: Theme.of(context)
          .textTheme
          .titleSmall!
          .copyWith(color: AppColors.blueGray100),
      filled: true,
      readOnly: true, // Make it read-only
      suffix: suffix,
      contentPadding: contentPadding,
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(), // You can set an initial time if needed
        );

        if (pickedTime != null) {
          // Format the picked time and update the controller
          final now = DateTime.now();
          final formattedTime = DateFormat('hh:mm a').format(
            DateTime(now.year, now.month, now.day, pickedTime.hour,
                pickedTime.minute),
          );
          controller.text =
              formattedTime; // Update the controller with selected time
        }
      },
    );
  }
}
