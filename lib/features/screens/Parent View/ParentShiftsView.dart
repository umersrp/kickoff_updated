import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'admission_form.dart';

String email="";

class ParentShiftsListPage extends StatefulWidget {
  @override
  State<ParentShiftsListPage> createState() => _ParentShiftsListPageState();
}

class _ParentShiftsListPageState extends State<ParentShiftsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Shifts'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Color(0xff2e2d77),
            ],
          ),
        ),
        child:
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Academy')
              .doc('asad@timetokickoff.com')
              .collection('Shifts')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<ShiftItem> shifts = snapshot.data!.docs
                .map((doc) => ShiftItem(
              startTime: doc.get('startTime'),
              endTime: doc.get('endTime'),
              position: doc.get('position'),
            ))
                .toList();

            return ListView.builder(
              itemCount: shifts.length,
              itemBuilder: (context, index) {
                return GestureDetector  (
                  onTap: () {
                    // Navigate to the shift details page


                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdmissionForm(),
                        ),
                      );
                        // else{
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => LoginPage(),
                    //     ),
                    //   );
                    // }

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => AdmissionForm(),
                    //   ),
                    // );
                  },
                  child: Card(
                    color: Colors.grey[800],
                    child: ListTile(
                      title: Text(
                        shifts[index].position,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${shifts[index].startTime} - ${shifts[index].endTime}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

final user = FirebaseAuth.instance.currentUser;

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
