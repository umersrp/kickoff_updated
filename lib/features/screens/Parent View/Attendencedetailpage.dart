import 'package:flutter/material.dart';

import '../HomePage/homepage.dart';
import '../Reports.dart';

class AttendanceDataPage extends StatefulWidget {
  List<NameAndEmail> emailss;

  AttendanceDataPage({
    required  this.emailss,
  });

  @override
  _AttendanceDataPageState createState() => _AttendanceDataPageState();
}

class _AttendanceDataPageState extends State<AttendanceDataPage> {
  late DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('Attendance Data'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              _showDatePicker(context);
            },
          ),
        ],
      ),
      body: widget.emailss == null
          ? Center(child: Text('No data available'))
          : ListView.builder(
        itemCount: widget.emailss.length,
        itemBuilder: (context, index) {
          // Display the attendance data for each email
          return ListTile(
            title: Text(widget.emailss[index].name),
            subtitle: Text(widget.emailss[index].email),
            // ...
          );
        },
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });

      // Add code to update attendance data based on selected date
    }
  }
}

