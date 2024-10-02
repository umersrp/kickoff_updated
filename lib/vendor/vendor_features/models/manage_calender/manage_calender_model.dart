import 'package:flutter/material.dart';

class DaySchedule {
  String day;
  bool isSelected;
  TimeOfDay startTime;
  TimeOfDay endTime;

  DaySchedule({
    required this.day,
    this.isSelected = false,
    required this.startTime,
    required this.endTime,
  });
}

