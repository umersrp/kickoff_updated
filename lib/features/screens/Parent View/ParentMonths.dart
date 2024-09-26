import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

class ParentsMonths extends StatelessWidget {
  final List<String> allMonths = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Records',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color(0xff2e2d77),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
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
          Expanded(
            child: ListView.builder(
              itemCount: allMonths.length,
              itemBuilder: (context, index) {
                return buildMonthCard(allMonths[index], context);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget buildMonthCard(String month, BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => NumberOfStudent(parentemail: '', stdname: '',)),
  //       );
  //     },
  //     child: Card(
  //       color: Colors.grey[800],
  //       child: ListTile(
  //         leading: Icon(
  //           Icons.calendar_month,
  //           color: Colors.white,
  //           size: 40,
  //         ),
  //         title: Text(
  //           month,
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  // Widget buildMonthCard2(String month, BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       // Get the current month
  //       DateTime now = DateTime.now();
  //       String currentMonth = "${now.year}-${now.month.toString().padLeft(2, '0')}";
  //
  //       // Extract the month name from the selected month
  //       String selectedMonthName = month.toLowerCase();
  //
  //       // Check if the selected month is equal to the current month
  //       if (selectedMonthName == currentMonth.toLowerCase()) {
  //         // Navigate to Reports if the selected month is equal to the current month
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => Reports()),
  //         );
  //       } else {
  //         showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               title: Text('Error'),
  //               content: Text('Please select the current month.'),
  //               actions: [
  //                 TextButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: Text('OK'),
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //       }
  //     },
  //     child: Card(
  //       color: Colors.grey[800],
  //       child: ListTile(
  //         leading: Icon(
  //           Icons.calendar_month,
  //           color: Colors.white,
  //           size: 40,
  //         ),
  //         title: Text(
  //           month,
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget buildMonthCard(String month, BuildContext context) {
    return GestureDetector(
      onTap: () {

        String currentMonth =
        DateFormat('MMMM').format(DateTime.now()).toLowerCase();

        String selectedMonthName = month.toLowerCase();
        if (selectedMonthName == currentMonth) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NumberOfStudent()),
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
    home: ParentsMonths(),
  ));
}

