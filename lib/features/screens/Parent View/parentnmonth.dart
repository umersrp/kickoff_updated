import 'package:flutter/material.dart';

import 'HistoryPlayers/AttendanceParent.dart';

class NameAndEmail{
  NameAndEmail({required this.name,required this.email,required this.last_name,required this.emails,required this.groupname,required this.documentId,required this.position
  });
  String name;
  String email;
  String last_name;
  String emails;
  String groupname;
  String documentId;
  String position;
}


class ParentMonths extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Records'),
        centerTitle: true,
        backgroundColor: Color(0xff2e2d77),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            Text(
              'Months',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            buildMonthCard('November', context),
            buildMonthCard('December', context),
          ],
        ),
      ),
    );
  }

  Widget buildMonthCard(String month, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get the current month
        DateTime now = DateTime.now();
        String currentMonth = "${now.year}-${now.month.toString().padLeft(2, '0')}";

        // Check if the selected month is equal to the current month
        if (month.toLowerCase() == currentMonth.toLowerCase()) {
          // Navigate to Reports if the selected month is equal to the current month
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AttendanceParent(parentemail: '', stdname: '',)),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Please select the current month.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Card(
        color: Colors.grey[800],
        child: ListTile(
          leading: Icon(
            Icons.calendar_month,
            color: Colors.white,
            size: 40,
          ),
          title: Text(
            month,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ParentMonths(),
  ));
}