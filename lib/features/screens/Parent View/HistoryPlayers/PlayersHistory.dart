import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class AttendanceData {
  AttendanceData({
    required this.date,
    required this.present,
  });
  final DateTime date;
  final bool present;
}
class PlayersHistory extends StatefulWidget {
  PlayersHistory({required this.stdname,required this.parentemail});

  String stdname;
  String parentemail;
  @override
  _PlayersHistoryState createState() => _PlayersHistoryState();
}

late String parentemail;

class _PlayersHistoryState extends State<PlayersHistory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff2e2d77),
          centerTitle: true,
          title: Text('Player Attendance History'),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('Academy')
                    .doc(widget.parentemail)
                    .collection('Admission')
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }

                  // if (!snapshot.hasData || !snapshot.data.exists) {
                  //   return Text("No attendance data available.");
                  // }

                  List<AttendanceData> attendanceList = [];

                  return ListView.builder(
                    itemCount: attendanceList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          'Date: ${DateFormat('yyyy-MM-dd').format(attendanceList[index].date)}',
                        ),
                        subtitle: Text(
                          'Present: ${attendanceList[index].present ? 'Yes' : 'No'}',
                        ),
                      );
                    },
                  );
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
