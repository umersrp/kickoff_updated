import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Parent View/ShowAttendence.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';


class NameAndEmail{
  NameAndEmail({required this.name,required this.email,required this.last_name,required this.emails,required this.groupname,required this.documentId,required this.position,required this.status
  });
  String name;
  String email;
  String last_name;
  String emails;
  String groupname;
  String documentId;
  String position;
  bool status;

}

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {

  final user = FirebaseAuth.instance.currentUser;
  bool aChecked = false;
  bool bChecked = false;
  bool isPresent = false;
  bool isAbsent = false;
  bool _isGoodMood = true;
  List<Map<String, dynamic>> emails = [];
  String date='';
  DateTime now=DateTime.now();
  List<NameAndEmail> emailss=[];
  StreamController<NameAndEmail> streamController = StreamController();

  Future<void> submitAttendanceData(bool isPresent, bool isAbsent, String email) async {
    try {
      // Get the document reference for the email in the Academy collection
      final docRef = FirebaseFirestore.instance.collection('Academy').doc(email).collection('Attendence').doc(('${now.year}-${now.month}-${now.day}'));
      await docRef.set({

        "present":isPresent,
        "date":"${('${now.year}-${now.month}-${now.day}')}"
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Attendance submitted successfully!'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to submit attendance. Please try again.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future getAttendanceData() async {
    var docSnapshot = await FirebaseFirestore.instance.collection('Academy').get().then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection('Academy').doc(element.id).collection('Attendance').get().then((value) {
          value.docs.forEach((element) {
            print(":::::::::::::::: ${element.id}");
          });
        });
      });
    });
    if (docSnapshot.exists) {
      var data = docSnapshot.data();
      return data;
    } else {

      return null;
    }
  }

  initState(){
    // print("mawa ");
    fetchShifts();
  }

  fetchShifts() {
    FirebaseFirestore.instance.collection('Academy').doc('asad@timetokickoff.com').collection('Shifts').get().then((shiftsSnapshot) {
      shiftsSnapshot.docs.forEach((shiftDoc) {

        String shiftDocumentId = shiftDoc.id;
        String position = shiftDoc.get('position');
        String groupname = shiftDoc.get('selectedShift');
        emailss.add(NameAndEmail(documentId: shiftDocumentId, position: position,groupname:groupname, name: '', email: '', last_name: '', emails: '', status: true,  ));
        streamController.add(NameAndEmail(documentId: shiftDocumentId, position: position,groupname: groupname, name: '', email: '', last_name: '', emails: '', status: true ));
        print("Shift Document ID: $shiftDocumentId, Position: $position");
        setState(() {});

      });
    });
  }

  // fetchemails(){
  //   FirebaseFirestore.instance.collection('Academy').get().then((value) {
  //     value.docs.forEach((element) {
  //       String name;
  //       String last_name;
  //       String groupname;
  //       name= element.get('child_name');
  //       last_name= element.get('last_name');
  //       groupname=element.get('selectedShift');
  //
  //
  //       emailss.add(NameAndEmail(name: name,email: element.id,last_name:last_name,groupname: groupname));
  //       streamController.add(NameAndEmail(name: name,email: element.id,last_name:last_name,groupname: groupname));
  //       print(":::::::: $name");
  //       setState(() {
  //       });
  //     });
  //   });
  // }

  String capitalizeFirstLetter(String text) {
    if (text == null || text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    String currentMonth = DateFormat('MMMM yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff2e2d77),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text('Attendance Records',style: TextStyle(color: Colors.white),),
            Text(
              currentMonth,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal,color: Colors.white),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: StreamBuilder(
          stream: streamController.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                Text(
                  'Groups',
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
                    itemCount: emailss.length,
                    itemBuilder: (context, index) {
                      if (emailss[index].email.toString() == "asad@timetokickoff.com" ||
                          emailss[index].email.toString() == "coach1@kickoff.com" ||
                          emailss[index].email.toString() == "coach2@kickoff.com" ||
                          emailss[index].email.toString() == "coach3@kickoff.com" ||
                          emailss[index].email.toString() == "coach4@kickoff.com")
                      {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () {
                            print('::::::${emailss[index].groupname}');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NumberOfStudentReports(
                                  parentemail: emailss[index].emails.toString(),
                                  stdname: emailss[index].position ?? '',
                                  groupName: emailss[index].groupname,

                                ),
                              ),
                            );
                          },
                          child:
                          Card(
                            color: Colors.grey[800],
                            child: ListTile(
                              leading: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 40,
                              ),
                              title: Text(
                                '${emailss[index].position}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // subtitle: Text(
                              //   '${emailss[index].groupname ?? ''}',
                              //   style: TextStyle(
                              //     color: Colors.white,
                              //     fontWeight: FontWeight.bold,
                              //
                              //   ),
                              // ),
                              // trailing: GestureDetector(
                              //   onTap: () {
                              //     setState(() {
                              //       _isGoodMood = !_isGoodMood;
                              //     });
                              //   },
                              //   child: Icon(
                              //     _isGoodMood ? Icons.sentiment_satisfied : Icons.sentiment_dissatisfied,
                              //     color: _isGoodMood ? Colors.green : Colors.red,
                              //     size: 30,
                              //   ),
                              // ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class NumberOfStudentReports extends StatefulWidget {
  NumberOfStudentReports({required this.parentemail, required this.stdname, required this.groupName}) : super();
  String stdname;
  String parentemail;
  final String groupName;

  @override
  State<NumberOfStudentReports> createState() => _NumberOfStudentReportsState();
}

class _NumberOfStudentReportsState extends State<NumberOfStudentReports> {
  final user = FirebaseAuth.instance.currentUser;

  bool isLoading = true; // Loader state
  bool aChecked = false;
  bool bChecked = false;
  bool isPresent = false;
  bool isAbsent = false;
  List<Map<String, dynamic>> emails = [];
  String date = '';
  DateTime now = DateTime.now();
  List<NameAndEmail> emailss = [];
  final TextEditingController _searchController = TextEditingController();
  List<NameAndEmail> filteredList = [];
  List<NameAndEmail> list = [];
  List<dateandpresent> datepresent = [];
  StreamController<dateandpresent> streamControllers = StreamController();
  StreamController<NameAndEmail> streamController = StreamController();
  List<String> studentsinG = [];
  int countdownTime = 8;
  Timer? countdownTimer;


  @override
  void initState() {
    super.initState();
    startCountdown();
    fetchemails();
    _searchController.addListener(() {
      _filterList(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    countdownTimer?.cancel();
    super.dispose();
  }

  studentingroup() {
    FirebaseFirestore.instance.collection('Academy').get().then((value) {
      value.docs.forEach((element) {
        String a = element.get("selectedShift");
        if (a == widget.groupName) {
          String b = element.get("field");
          studentsinG.add(b);
        }
      });
    });
  }

  Future<void> submitAttendanceData(bool isPresent, bool isAbsent, String email) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('Academy').doc(email).collection('Attendance').doc('${now.year}-${now.month}-${now.day}');
      await docRef.set({
        "present": isPresent,
        "date": "${now.year}-${now.month}-${now.day}"
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Attendance submitted successfully!'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to submit attendance. Please try again.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future getAttendanceData() async {
    var docSnapshot = await FirebaseFirestore.instance.collection('Academy').get().then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection('Academy').doc(element.id).collection('Attendance').get().then((value) {
          value.docs.forEach((element) {
            print(":::::::::::::::: ${element.id}");
          });
        });
      });
    });
    if (docSnapshot.exists) {
      var data = docSnapshot.data();
      return data;
    } else {
      return null;
    }
  }

  Future<void> fetchemails() async {
    try {
      QuerySnapshot academySnapshot = await FirebaseFirestore.instance.collection('Academy').get();

      List<Future<void>> tasks = [];

      for (var element in academySnapshot.docs) {
        String selectedgroup = element.get('selectedShift');

        if (selectedgroup == widget.groupName) {
          tasks.add(_processAdmission(element));
        }
      }

      await Future.wait(tasks);  // Wait for all admission data to be processed

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      // Handle errors
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to fetch student data. Please try again.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _processAdmission(DocumentSnapshot element) async {
    try {
      QuerySnapshot admissionSnapshot = await FirebaseFirestore.instance
          .collection('Academy')
          .doc(element.id)
          .collection('Admission')
          .get();

      String name = element.get('child_name');
      String last_name = element.get('last_name');
      String emails = element.get('email');
      String selectedgroup = element.get('selectedShift');

      for (var admissionDoc in admissionSnapshot.docs) {
        bool status = admissionDoc.get('status');
        if (status) {
          emailss.add(NameAndEmail(
            name: name,
            email: element.id,
            last_name: last_name,
            emails: emails,
            groupname: selectedgroup,
            status: status,
            documentId: '',
            position: '',
          ));
          streamController.add(NameAndEmail(
            name: name,
            email: element.id,
            last_name: last_name,
            emails: emails,
            groupname: selectedgroup,
            status: status,
            documentId: '',
            position: '',
          ));
        }
      }
    } catch (e) {
      // Handle errors for this specific admission
    }
  }


  String capitalizeFirstLetter(String text) {
    if (text == null || text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  void _filterList(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredList = emailss;
      } else {
        filteredList = emailss.where((element) {
          final emailLower = element.name.toLowerCase();
          final firstNameLower = element.emails.toLowerCase();
          final lastNameLower = element.last_name.toLowerCase();
          final queryLower = query.toLowerCase();
          return emailLower.contains(queryLower) || firstNameLower.contains(queryLower) || lastNameLower.contains(queryLower);
        }).toList();
      }
    });
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdownTime > 0) {
        setState(() {
          countdownTime--;
        });
      } else {
        countdownTimer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff2e2d77),
        title: Text('Reports', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.white],
          ),
        ),
        child: isLoading // Check if data is still loading
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Loading data... Please wait ($countdownTime seconds)',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        )
            : StreamBuilder(
          stream: streamController.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<NameAndEmail> activeStudents = emailss.where(isStudentActive).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: _filterList,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Student Names',
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
                    itemCount: _searchController.text.isEmpty ? activeStudents.length : filteredList.length,
                    itemBuilder: (context, index) {
                      if (emailss[index].email.toString() == "asad@timetokickoff.com" ||
                          emailss[index].email.toString() == "coach1@kickoff.com" ||
                          emailss[index].email.toString() == "coach2@kickoff.com" ||
                          emailss[index].email.toString() == "coach3@kickoff.com" ||
                          emailss[index].email.toString() == "coach4@kickoff.com") {
                        return Container();
                      } else {
                        return GestureDetector(
                          onTap: () {
                            int originalIndex = emailss.indexWhere((student) =>
                            student.emails == (_searchController.text.isEmpty ? emailss[index].emails : filteredList[index].emails));
                            if (originalIndex != -1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShowAttendPage(
                                    stdname: emailss[originalIndex].name.toString(),
                                    parentemail: emailss[originalIndex].emails,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Card(
                            color: Colors.grey[800],
                            child: ListTile(
                              leading: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 40,
                              ),
                              title: Text(
                                '${_searchController.text.isEmpty ? emailss[index].name : filteredList[index].name} ${_searchController.text.isEmpty ? emailss[index].last_name : filteredList[index].last_name}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '${_searchController.text.isEmpty ? emailss[index].emails : filteredList[index].emails}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class dateandpresent {
  dateandpresent({required this.date, required this.present});
  String date;
  bool present;
}

bool isStudentActive(NameAndEmail student) {
  return student.status ?? false;
}