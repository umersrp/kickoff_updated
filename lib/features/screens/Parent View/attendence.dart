import 'package:appkickoff/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../personalization/admin_panel/controllers/playersattendance_controller.dart';
import '../../../personalization/admin_panel/models/playerattendance_model.dart';
import '../../../personalization/controllers/schedule_controller.dart';
import '../../../personalization/models/schedule_model.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

final PlayerattendanceController controller = Get.put(PlayerattendanceController());

class _AttendanceState extends State<Attendance> {
  DateTime now = DateTime.now();
  final ScheduleController scheduleController = Get.put(ScheduleController());

  String? selectedSchedule;
  ScheduleModel? selectedScheduleItem;
  final TextEditingController _searchController = TextEditingController();
  final List<User> attendanceUpdates = [];

  void dispose() {
    controller.clearUsers();
    _searchController.dispose();
    super.dispose();
  }

  int currentPage = 1;
  int recordsPerPage = 10;

  String capitalize(String text) {
    if (text == null || text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }

  void handleCheckboxChange(User user, bool? isChecked) {
    if (user.isMarked) {
      // Do nothing if attendance is already marked
      return;
    }

    // Toggle the attendance state and mark the user as present or absent
    setState(() {
      user.isPresent = isChecked ?? false;

      // Add or remove the user from the attendanceUpdates list based on the new state
      if (isChecked == true) {
        attendanceUpdates.add(user);
      } else {
        attendanceUpdates.remove(user);
      }
    });
  }


  Future<void> submitAttendance() async {
    if (selectedScheduleItem == null) return;

    try {
      await Future.wait(attendanceUpdates.map((user) {
        return controller.changeAttendanceStatus(
          user.id,
          selectedScheduleItem!.id,
          user.isPresent,
        );
      }));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Attendance updated successfully.')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update attendance.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String formattedDate = "${now.month}-${now.day}-${now.year}";

    bool canShowNextButton = controller.filteredPlayers.length > currentPage * recordsPerPage;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: <Widget>[
            Text("Player Attendance", style: TextStyle(fontSize: 20, color: Colors.white)),
            Text("Date: $formattedDate", style: TextStyle(fontSize: 14, color: Colors.white)),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Color(0xff2e2d77),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.calendar, color: MyColors.primary),
                        hintText: 'Select a schedule',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
                        ),
                      ),
                      isExpanded: true,
                      value: selectedSchedule,
                      items: scheduleController.scheduleData.map((schedule) {
                        return DropdownMenuItem<String>(
                          value: schedule!.group,
                          child: Text(schedule.group),
                        );
                      }).toList(),
                      onChanged: (value) async {
                        setState(() {
                          selectedSchedule = value;
                        });

                        selectedScheduleItem = scheduleController.scheduleData.firstWhere(
                              (schedule) => schedule.group == value,
                          orElse: () => ScheduleModel(
                            id: '',
                            group: '',
                            days: [],
                            startTime: '',
                            endTime: '',
                            ages: '',
                            location: '',
                            v: 0,
                            date: DateTime.now(),
                          ),
                        );

                        print('Selected Schedule ID: ${selectedScheduleItem!.id}');

                        // Fetch users for the selected schedule
                        await controller.fetchUsersForSchedule(selectedScheduleItem!.id);
                      },
                    ),
                  ],
                );
              }),
              SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (controller.filteredPlayers.isEmpty) {
                    return Center(child: Text('No users available'));
                  }

                  return ListView.builder(
                    itemCount: controller.filteredPlayers.length,
                    itemBuilder: (context, index) {
                      final user = controller.filteredPlayers[index];
                      Color cardColor = user.isPresent ? Colors.green.shade100 : Colors.white;

                      return Card(
                        color: cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                child: Text((index + 1).toString()),
                                backgroundColor: MyColors.primary,
                                foregroundColor: Colors.white,
                                radius: 24,
                              ),
                              SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.name,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      'Email: ${user.email}',
                                      style: TextStyle(color: Colors.grey[600], fontSize: 12.0),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      'Status: ${user.isPresent ? "Present" : "Absent"}',
                                      style: TextStyle(color: user.isPresent ? Colors.green : Colors.red, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              user.isMarked
                                  ? Icon(Icons.check, color: Colors.green, size: 24.0)
                                  : Checkbox(
                                value: user.isPresent,
                                onChanged: (bool? value) {
                                  if (user.isMarked) {
                                    return;
                                  }
                                  handleCheckboxChange(user, value);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: controller.currentPage.value > 1
                        ? () {
                      setState(() {
                        controller.currentPage.value--;
                        controller.fetchUsersForSchedule(selectedScheduleItem!.id);
                      });
                    }
                        : null,
                    child: Text('Previous'),
                  ),
                  ElevatedButton(
                    onPressed: controller.canShowNextButton
                        ? () {
                      setState(() {
                        controller.currentPage.value++;
                        controller.fetchUsersForSchedule(selectedScheduleItem!.id);
                      });
                    }
                        : null,
                    child: Text('Next'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: submitAttendance,
                child: Text('Submit Attendance'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShiftItem {
  final String startTime;
  final String endTime;
  final String position;

  ShiftItem({
    required this.startTime,
    required this.endTime,
    required this.position,
  });
}
