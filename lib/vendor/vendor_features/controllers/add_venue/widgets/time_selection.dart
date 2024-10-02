import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../common/text_form_field/text_form_field.dart';

class TimeSelectionField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  TimeSelectionField({
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      filled: true,
      readOnly: true, // Make it read-only
      // suffix: Icon(Icons.timer, size: 14),
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(), // You can set an initial time if needed
        );

        if (pickedTime != null) {
          // Format the picked time and update the controller
          final now = DateTime.now();
          final formattedTime = DateFormat('HH:mm').format(
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
