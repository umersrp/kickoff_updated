import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../ShowAttendence.dart';

class NameAndEmail{
  NameAndEmail({required this.name,required this.email,required this.last_name,required this.emails,required this.parentemail,});
  String name;
  String parentemail;
  String email;
  String last_name;
  String emails;
}


class AttendanceParent extends StatefulWidget {
  AttendanceParent({required this.parentemail,required this.stdname,});
  String stdname;
  String parentemail;

  @override
  _AttendanceParentState createState() => _AttendanceParentState();
}

class _AttendanceParentState extends State<AttendanceParent> {


  String _userName = '';
  User? _firebaseAuth = FirebaseAuth.instance.currentUser;


  Future<void> fetchNames() async {
    FirebaseFirestore.instance.collection('Academy').doc(_firebaseAuth?.email.toString()).get().then((value) {
      _userName = value.get('child_name');
      setState(() {
      });
    });
    // try {
    //   final academySnapshot = await FirebaseFirestore.instance.collection('Academy').get();
    //   for (final academyDoc in academySnapshot.docs) {
    //     final admissionSnapshot = await FirebaseFirestore.instance
    //         .collection('Academy')
    //         .doc(academyDoc.id)
    //         .collection('Admission')
    //         .get();
    //     for (final admissionDoc in admissionSnapshot.docs) {
    //       String name = admissionDoc['name'];
    //       // Assuming there is only one name in the collection, you can directly set the _userName variable
    //       _userName = name;
    //       return;
    //     }
    //   }
    // }
    // catch (e) {
    //   // Handle any potential errors here
    //   print('Error fetching data: $e');
    // }
  }

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
    fetchemails();
  }

  fetchemails(){
    FirebaseFirestore.instance.collection('Academy').doc('${user?.email.toString()}').collection("Admission").get().then((value) {
      value.docs.forEach((element) {
        print('::::::::kyun dua qabool ${element.id}');
        String name;
        String last_name;
        name= element.get('name');
        last_name= element.get('last_name');
        emailss.add(NameAndEmail(name: name,email: element.id,last_name:last_name, emails: '', parentemail: ''));
        streamController.add(NameAndEmail(name: name,email: element.id,last_name:last_name, emails: '', parentemail: ''));
        print(":::::::: $name");
        setState(() {
        });

      }
      );
      
    });


    // FirebaseFirestore.instance.collection('Academy').get().then((value) {
    //   value.docs.forEach((element) {
    //     print('::::::::kyun dua qabool ${element.id}');
    //     String name;
    //     String last_name;
    //     name= element.get('child_name');
    //     last_name= element.get('last_name');
    //
    //     emailss.add(NameAndEmail(name: name,email: element.id,last_name:last_name));
    //     streamController.add(NameAndEmail(name: name,email: element.id,last_name:last_name));
    //     print(":::::::: $name");
    //     setState(() {
    //     });
    //   }
    //   );
    // });
  }


  final users = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff2e2d77),
        title: Text('Attendance Records'),
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
                  'Parent Name',
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
                          onTap: (){
                            print(':::::parent check karna ${emailss[index].last_name.toString()}');
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>  ShowAttendPage(email:emailss[index].email.toString() ,name: '${emailss[index].name ?? ''}',),
                            //   ),
                            // );
                            Navigator.push(
                              context,
                              MaterialPageRoute(  
                                builder: (context) =>  NumberOfStudent(parentemail:emailss[index].email.toString() ,stdname: '${emailss[index].name ?? ''}',),
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
                                '${emailss[index].name != null ? emailss[index].name[0].toUpperCase() + emailss[index].name.substring(1) : 'N/A'}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '${user?.email ?? ''}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
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

class NumberOfStudent extends StatefulWidget {
  NumberOfStudent({this.parentemail,this.stdname,});
  String? stdname;
  String? parentemail;
  @override
  State<NumberOfStudent> createState() => _NumberOfStudentState();
}

class _NumberOfStudentState extends State<NumberOfStudent> {

  final user = FirebaseAuth.instance.currentUser;
  // CalendarController _calendarController = CalendarController();

  bool aChecked = false;
  bool bChecked = false;
  bool isPresent = false;
  bool isAbsent = false;
  // bool _isGoodMood = true;
  List<Map<String, dynamic>> emails = [];
  String date='';
  DateTime now=DateTime.now();
  List<NameAndEmail> emailss=[];
  List<dateandpresent> datepresent=[];
  StreamController<dateandpresent> streamControllers = StreamController();
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
    print("mawa ");
    fetchemails();
  }


  // fetchemails(){
  //   FirebaseFirestore.instance.collection('Academy').get().then((value) {
  //     value.docs.forEach((element) {
  //       String name;
  //       String last_name;
  //       name= element.get('child_name');
  //       last_name= element.get('last_name');
  //
  //       emailss.add(NameAndEmail(name: name,email: element.id,last_name:last_name));
  //       streamController.add(NameAndEmail(name: name,email: element.id,last_name:last_name));
  //       print(":::::::: $name");
  //       setState(() {
  //       });
  //     });
  //   });
  // }

  fetchemails(){
    FirebaseFirestore.instance.collection('Academy').doc('${user?.email.toString()}').collection('Admission').get().then((value) {
      // FirebaseFirestore.instance.collection('Academy').get().then((value) {
      value.docs.forEach((element) {
        String name;
        String emails;
        String last_name;
        name= element.get('child_name');
        last_name = element.get('last_name');
        emails = element.get('email');

        emailss.add(NameAndEmail(name: name,email: element.id,last_name:last_name,emails:emails, parentemail: '',));
        streamController.add(NameAndEmail(name: name,email: element.id,last_name: last_name,emails:emails, parentemail: ''));
      });
    });

    FirebaseFirestore.instance.collection('Academy').doc(widget.parentemail).collection('Admission').get().then((value) {
      value.docs.forEach((element) {
        String name;
        name= element.get('name');
        if(widget.stdname==name){
          element.reference.collection('Attendance').get().then((value) {
            value.docs.forEach((elemen) {
              String date;
              bool present=false;
              date=elemen.get('date');
              present=elemen.get('present');
              datepresent.add(dateandpresent(date:date,present: present));
              streamControllers.add(dateandpresent( date:date,present: present));
            });
          });
        }
      });
    });
    // FirebaseFirestore.instance.collection('Academy').get().then((value) {
    //   value.docs.forEach((element) {
    //     String name;
    //     name= element.get('name');
    //     emailss.add(NameAndEmail(name: name,email: element.id));
    //     streamController.add(NameAndEmail(name: name,email: element.id));
    //     print(":::::::: $name");
    //     setState(() {
    //
    //     });
    //   });
    // });
  }

  String _capitalize(String text) {
    if (text == null || text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff2e2d77),
        title: Text('Records',style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white), // Set icon color to white
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.calendar_today),
          //   onPressed: () {
          //     _showCalendar();
          //   },
          // ),
        ],
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
        child:
        StreamBuilder(
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
                  'Student Name',
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
                          onTap: (){
                            print("::::::::::::::; ${emailss[index].name ?? ''}::: ${widget.parentemail}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  ShowAttendPage2(stdname:emailss[index].name.toString() ,  parentemail: widget.parentemail ?? "",
                                    ),
                              ),
                            );
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
                                '${_capitalize(emailss[index].name) ?? ''} ${_capitalize(emailss[index].last_name) ?? 'N/A'}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '${emailss[index].emails ?? ''}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),


                              // subtitle: Text(
                              //   '${emailss[index].email ?? ''}',
                              //   style: TextStyle(
                              //     color: Colors.white,
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

class dateandpresent {
  dateandpresent({required this.date,required this.present,});
  String date;
  bool present;
}


class ShowAttendPage2 extends StatefulWidget {
  final String stdname;
  final String parentemail;

  ShowAttendPage2({required this.stdname,required this.parentemail});

  @override
  _ShowAttendPage2State createState() => _ShowAttendPage2State();
}

class _ShowAttendPage2State extends State<ShowAttendPage2> {
  List<Map<String, dynamic>> attendanceData = [];

  @override
  void initState() {
    super.initState();
    fetchAttendanceData();
    _userName=widget.stdname;
    setState(() {

    });
    //fetchNames();
  }
  List<AttendanceData> attendanceDataList = [];
  StreamController<AttendanceData> streamController = StreamController();
  User? _firebaseAuth = FirebaseAuth.instance.currentUser;
  String _userName = '';

  Future<void> fetchNames() async {
    FirebaseFirestore.instance.collection('Academy').doc(_firebaseAuth?.email.toString()).get().then((value) {
      _userName = value.get('child_name');
      setState(() {
      });
    });
    // try {
    //   final academySnapshot = await FirebaseFirestore.instance.collection('Academy').get();
    //   for (final academyDoc in academySnapshot.docs) {
    //     final admissionSnapshot = await FirebaseFirestore.instance
    //         .collection('Academy')
    //         .doc(academyDoc.id)
    //         .collection('Admission')
    //         .get();
    //     for (final admissionDoc in admissionSnapshot.docs) {
    //       String name = admissionDoc['name'];
    //       // Assuming there is only one name in the collection, you can directly set the _userName variable
    //       _userName = name;
    //       return;
    //     }
    //   }
    // }
    // catch (e) {
    //   // Handle any potential errors here
    //   print('Error fetching data: $e');
    // }
  }

  fetchAttendanceData() {
    print(':::::::::::kiya smjhe ${widget.stdname} ${widget.parentemail}');
    FirebaseFirestore.instance.collection('Academy').doc(_firebaseAuth?.email.toString())
        .collection('Admission')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(":::::::::: ${element.id}");

        String name = element.get('child_name');
        bool status = element.get('status');
        if (widget.stdname == name) {
          if (!status) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Approval Pending"),
                  content: Text("Your approval is pending. Please wait for approval to view attendance records."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => NumberOfStudent()),
                        // );
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );
            return;
          }

          element.reference.collection('Attendance').get().then((value) {
            value.docs.forEach((element) {
              String a = element.id.substring(0, 5);
              if (a == "ukasha") {}
              String email = '';
              String date = element.get('date');
              bool present = element.get('present');

              AttendanceData attendanceData = AttendanceData(
                email: email,
                date: date,
                present: present,
                groupname: '',
                name: '',
                parentemail: '',
              );
              attendanceDataList.add(attendanceData);
              streamController.add(attendanceData);
              print("email: $email");
              print("date: $date");
              print("present: $present");
              setState(() {});
            });
          });
        }
      });
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2e2d77),
        title: Text(
          'Attendance For ${_userName.substring(0, 1).toUpperCase()}${_userName.substring(1)}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: attendanceDataList.length,
        itemBuilder: (context, index) {
          final attendance = attendanceDataList[index];
          final date = attendance.date;
          final present = attendance.present;
          final email = attendance.email;
            if (date != '2011-12-20') {
            return Card(
              margin: EdgeInsets.all(8),
              elevation: 4,
              child: ListTile(
                title: Text(
                  'Date: $date',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Present: ${present ? "Yes" : "No"}',
                  style: TextStyle(
                    fontSize: 16,
                    color: present ? Colors.green : Colors.red,
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
