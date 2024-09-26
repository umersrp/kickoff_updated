import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class ShowAttendPage extends StatefulWidget {
  ShowAttendPage({required this.stdname, required this.parentemail});
  final String stdname;
  final String parentemail;

  @override
  _ShowAttendPageState createState() => _ShowAttendPageState();
}

class _ShowAttendPageState extends State<ShowAttendPage> {
  List<AttendanceData> originalAttendanceDataList = [];
  List<AttendanceData> filteredAttendanceDataList = [];
  late DateTime selectedStartDate;
  late DateTime selectedEndDate;
  List<Userinfo> list = [];
  int totalPresent = 0;
  int totalAbsent = 0;

  fetchAttendanceData() async {
    try {
      final admissionCollection = FirebaseFirestore.instance
          .collection('Academy')
          .doc(widget.parentemail)
          .collection('Admission');

      final admissionSnapshot = await admissionCollection.get();
      print('Total Admission Documents: ${admissionSnapshot.docs.length}');
      for (var admissionDoc in admissionSnapshot.docs) {
        String name = admissionDoc.get('child_name');
        String groupname = admissionDoc.get('selectedShift');


        print('Child Name: $name, Group Name: $groupname');

        if (widget.stdname == name) {
          final attendanceCollection = admissionDoc.reference.collection('Attendance');
          final attendanceSnapshot = await attendanceCollection.get();
          print('Total Attendance Documents: ${attendanceSnapshot.docs.length}');

          for (var attendanceDoc in attendanceSnapshot.docs) {
              print('Document ID: ${attendanceDoc.id}, Data: ${attendanceDoc.data()}');  // Debugging

            if (attendanceDoc.exists) {
              String date = attendanceDoc.id;
              bool present = attendanceDoc.get('present');
              print('Date: $date, Present: $present');

              AttendanceData attendanceData = AttendanceData(
                email: widget.parentemail,
                date: date,
                present: present,
                groupname: groupname,
                name: name,
                parentemail: '',
              );
              originalAttendanceDataList.add(attendanceData);
              if (present) {
                totalPresent++;
              } else {
                totalAbsent++;
              }
            } else {
              print("Attendance document doesn't exist.");
            }
          }
          setState(() {
            filteredAttendanceDataList = originalAttendanceDataList;
          });
        }
      }
      print("Total Attendance Data fetched: ${filteredAttendanceDataList.length}");
    } catch (e) {
      print("Error fetching attendance data: $e");
    }
  }

  List<AttendanceData> getAttendanceDataForSelectedDateRange() {
    return originalAttendanceDataList.where((data) {
      final DateTime dataDate = DateTime.parse(data.date);
      return (selectedStartDate == null ||
          dataDate.isAfter(selectedStartDate.subtract(Duration(days: 1)))) &&
          (selectedEndDate == null ||
              dataDate.isBefore(selectedEndDate.add(Duration(days: 1))));
    }).toList();
  }

  Future<void> exportToCsv(List<Userinfo> data) async {
    try {
      final List<List<dynamic>> csvData = [];
      // Add header row
      csvData.add([
        'Parent Name',
        'Email',
        'Phone Number',
        'Address',
        'First Name',
        'Last Name',
        'Groups',
        'Attendance',
      ]);

      // Add data rows
      for (final userinfo in data) {
        csvData.add([
          userinfo.fullName ?? '',
          userinfo.parentemail ?? '',
          userinfo.phoneNumber ?? '',
          userinfo.address ?? '',
          userinfo.childName ?? '',
          userinfo.last_name ?? '',
          userinfo.selectedShift ?? '',
          userinfo.present ? 'Present' : 'Absent',
        ]);
      }

      // Generate CSV string
      final csvString = const ListToCsvConverter().convert(csvData);

      // Save CSV string to a file
      final directory = await getApplicationDocumentsDirectory();
      final csvFilePath = '${directory.path}/exported_data.csv';
      final csvFile = File(csvFilePath);
      await csvFile.writeAsString(csvString);

      print('CSV file saved at: $csvFilePath');
    } catch (e) {
      print('Error exporting to CSV: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAttendanceData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff4a148c),
          centerTitle: true,
          title: Text(
            'Player Attendances',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.solidFileExcel, color: Colors.green),
              onPressed: () async {
                await exportToCsv(list);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  color: Color(0xff4a148c),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Total Present',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '$totalPresent',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'Total Absent',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '$totalAbsent',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: filteredAttendanceDataList.isEmpty
                      ? Center(child: Text("No attendance data available"))
                      : ListView.builder(
                    itemCount: filteredAttendanceDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var attendanceData = filteredAttendanceDataList[index];
                      String date = attendanceData.date;
                      bool present = attendanceData.present;

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: present
                                ? [Colors.green, Colors.lightGreen]
                                : [Colors.red, Colors.redAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            'Email: ${attendanceData.email}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8.0),
                              Text(
                                'Date: $date',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                present ? 'Present' : 'Absent',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AttendanceData {
  AttendanceData({
    required this.email,
    required this.groupname,
    required this.name,
    required this.parentemail,
    required this.date,
    required this.present,
  });

  String email;
  String groupname;
  String name;
  String parentemail;
  String date;
  bool present;
}

class Userinfo {
  String? fullName;
  String? parentemail;
  String? phoneNumber;
  String? address;
  String? childName;
  String? last_name;
  String? selectedShift;
  bool present;

  Userinfo({
    this.fullName,
    this.parentemail,
    this.phoneNumber,
    this.address,
    this.childName,
    this.last_name,
    this.selectedShift,
    required this.present,
  });
}

String formatDate(String date) {
  try {
    final parsedDate = DateTime.parse(date);
    return DateFormat('d, MMMM y').format(parsedDate);
  } catch (e) {
    List<String> dateParts = date.split('-');
    if (dateParts.length == 3) {
      int year = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int day = int.parse(dateParts[2]);
      return DateFormat('d, MMMM y').format(DateTime(year, month, day));
    } else {
      return date;
    }
  }
}
