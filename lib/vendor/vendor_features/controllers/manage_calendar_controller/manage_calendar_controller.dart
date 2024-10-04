import 'package:appkickoff/vendor/vendor_features/models/manage_calender/manage_calender_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 

class ManageCalendarController extends GetxController {
  static ManageCalendarController get instance => Get.find();

  ///vars
  final List<DaySchedule> days = <DaySchedule>[
    DaySchedule(
        isSelected: true,
        day: 'SUN',
        startTime: TimeOfDay(hour: 9, minute: 0),
        endTime: TimeOfDay(hour: 9, minute: 0)),
    DaySchedule(
        day: 'MON',
        startTime: TimeOfDay(hour: 9, minute: 0),
        endTime: TimeOfDay(hour: 9, minute: 0)),
    DaySchedule(
        isSelected: true,
        day: 'TUE',
        startTime: TimeOfDay(hour: 9, minute: 0),
        endTime: TimeOfDay(hour: 9, minute: 0)),
    DaySchedule(
        day: 'WED',
        startTime: TimeOfDay(hour: 9, minute: 0),
        endTime: TimeOfDay(hour: 9, minute: 0)),
    DaySchedule(
        isSelected: true,
        day: 'THU',
        startTime: TimeOfDay(hour: 9, minute: 0),
        endTime: TimeOfDay(hour: 9, minute: 0)),
    DaySchedule(
        day: 'FRI',
        startTime: TimeOfDay(hour: 9, minute: 0),
        endTime: TimeOfDay(hour: 9, minute: 0)),
    DaySchedule(
        isSelected: true,
        day: 'SAT',
        startTime: TimeOfDay(hour: 9, minute: 0),
        endTime: TimeOfDay(hour: 9, minute: 0)),
  ];

  /// oninit
}
