import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../personalization/controllers/schedule_controller.dart';
import '../../../personalization/models/schedule_model.dart';

class ShiftsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScheduleController scheduleController = Get.put(ScheduleController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff2e2d77),
        title: Text(
          'Groups',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (scheduleController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (scheduleController.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              scheduleController.errorMessage.value,
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        } else if (scheduleController.scheduleData.isEmpty) {
          return Center(
            child: Text(
              "No data available.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          );
        } else {
          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: scheduleController.scheduleData.length,
            itemBuilder: (context, index) {
              final schedule = scheduleController.scheduleData[index];
              return _buildScheduleItem(schedule);
            },
          );
        }
      }),
    );
  }

  Widget _buildScheduleItem(ScheduleModel schedule) {
    // Format the start and end times into a single string
    final timeRange = '${schedule.startTime ?? 'No Start Time'} - ${schedule.endTime ?? 'No End Time'}';

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: Icon(
          Icons.schedule,
          color: Color(0xff2e2d77),
          size: 40,
        ),
        title: Text(
          schedule.group ?? 'No Name',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          timeRange,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
