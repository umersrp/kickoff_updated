import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Parent View/admission_form.dart';
import 'Parent View/parentschedule.dart';

String email="";

class ShiftsListPage extends StatefulWidget {
  @override
  _ShiftsListPageState createState() => _ShiftsListPageState();
}

final user = FirebaseAuth.instance.currentUser;

class _ShiftsListPageState extends State<ShiftsListPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff2e2d77),
          title: Text('Book And Play',style: TextStyle(color: Colors.white),),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            image: DecorationImage(image:  AssetImage('assets/bg.png'),fit:BoxFit.fill )
          ),
          // child: StreamBuilder<QuerySnapshot>(
          //   stream: FirebaseFirestore.instance
          //       .collection('Academy')
          //       .doc('taha@gmail.com')
          //       .collection('Shifts')
          //       .snapshots(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     List<ShiftItem> shifts = snapshot.data.docs
          //         .map((doc) => ShiftItem(
          //       startTime: doc.get('startTime'),
          //       endTime: doc.get('endTime'),
          //       position: doc.get('position'),
          //     ))
          //         .toList();
          //
          //     // return ListView.builder(
          //     //   itemCount: shifts.length,
          //     //   itemBuilder: (context, index) {
          //     //     return GestureDetector  (
          //     //       onTap: () {
          //     //         // Navigate to the shift details page
          //     //
          //     //          // Navigator.push(
          //     //          //   context,
          //     //          //   MaterialPageRoute(
          //     //          //     builder: (context) => SignupPage(),
          //     //          //   ),
          //     //          // );
          //     //
          //     //
          //     //         // Navigator.push(
          //     //         //   context,
          //     //         //   MaterialPageRoute(
          //     //         //     builder: (context) => AdmissionForm(),
          //     //         //   ),
          //     //         // );
          //     //       },
          //     //       child: Card(
          //     //           color: Colors.black,
          //     //         child: ListTile(
          //     //           title: Text(
          //     //             shifts[index].position,
          //     //             style: TextStyle(
          //     //               color: Colors.white,
          //     //               fontWeight: FontWeight.bold,
          //     //             ),
          //     //           ),
          //     //           subtitle: Text(
          //     //             '${shifts[index].startTime} - ${shifts[index].endTime}',
          //     //             style: TextStyle(
          //     //               color: Colors.white,
          //     //             ),
          //     //           ),
          //     //         ),
          //     //       ),
          //     //     );
          //     //   },
          //     // );
          //   },
          // ),
        ),
      ),
    );
  }
}

class ShiftDetailsPage extends StatelessWidget {
  final ShiftItem shift;

  ShiftDetailsPage(this.shift);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('${shift.position} Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Position: ${shift.position}',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Start Time: ${shift.startTime}',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'End Time: ${shift.endTime}',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShiftItem {
  final String startTime;
  final String endTime;
  final String position;

  ShiftItem({required this.startTime, required this.endTime, required this.position});
}
