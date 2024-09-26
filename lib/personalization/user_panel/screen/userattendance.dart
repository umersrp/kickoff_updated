import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constant/colors.dart';
import '../controller/userattendance_controller.dart';

class UserAttendanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserAttendanceController controller = Get.put(UserAttendanceController());

    return Scaffold(
      appBar: AppBar(
        title: Text('User Attendance',style: TextStyle(color: Colors.white),),
        backgroundColor: MyColors.primary,
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color of all icons, including the back button
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(
            controller.errorMessage.value,
            style: TextStyle(color: Colors.red, fontSize: 16),
          ));
        }

        // Flatten the list of attendance items
        final allAttendances = controller.userAttendanceList
            .expand((userAttendance) => userAttendance.attendance)
            .toList();

        return allAttendances.isEmpty
            ? Center(child: Text('No attendance records found', style: TextStyle(fontSize: 18, color: Colors.grey)))
            : ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: allAttendances.length,
          itemBuilder: (context, index) {
            final attendance = allAttendances[index];
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(
                  attendance.status == 'Present' ? Icons.check_circle : Icons.cancel,
                  color: attendance.status == 'Present' ? Colors.green : Colors.red,
                ),
                title: Text(
                  'Status: ${attendance.status}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Date: ${attendance.date.toLocal()}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                contentPadding: EdgeInsets.all(16.0),
              ),
            );
          },
        );
      }),
    );
  }
}
