import 'dart:async';
import 'dart:ui';
import 'package:appkickoff/features/screens/Sign%20Up/signup.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../animation/FadeAnimation.dart';
import '../../../personalization/login/controllers/login_controller.dart';
import '../../../utils/drawer/custom_drawer.dart';
import '../../../utils/global_function/Globalfunction.dart';
import '../Login/login.dart';
import '../alpha.dart';

import '../bookandplay/listing_ground/ground_listing.dart';
import 'ParentMonths.dart';
import 'admission_form.dart';
class NameAndEmail {
  NameAndEmail({
    required this.useremail,
    required this.name,
    required this.email,
    required this.present ,
    required this.address,
    required this.dateOfBirth,
    required this.isMale,
    required this.phoneNumber,
    required this.status,
    required this.selectedShift,
  });

  String name;
  String email;
  String useremail;
  String address;
  String dateOfBirth;
  bool isMale;
  String phoneNumber;
  bool status;
  bool present;
  String selectedShift;
}


class ParentDashboard extends StatefulWidget {

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {


  bool showParentPanel = false;
  User? _firebaseAuth = FirebaseAuth.instance.currentUser;
  bool isSavedCredentials = false;
  Widget buildScheduleGroup(String groupName, String days, String time, String recommendation) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            groupName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Days: $days',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            time,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            recommendation,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    // _initializeUserName();
  }

  String hasly='';
  List alldate=[];
  bool hasdate=false;

  List<NameAndEmail> emailss = [];
  StreamController<NameAndEmail> streamController = StreamController();
  bool isPresent = false;
  DateTime noow = DateTime.now();
  CollectionReference academy = FirebaseFirestore.instance.collection('Academy');
  String _userName = '';

  Future<void> fetchNames() async {
    FirebaseFirestore.instance.collection('Academy').doc(_firebaseAuth?.email.toString()).get().then((value) {
      _userName = value.get('child_name');
      setState(() {
      });
    });
  }

  fetchemails() async {
    FirebaseFirestore.instance
        .collection('Academy').get().then((value) {
      value.docs.forEach((elemen) { //parent 3
        FirebaseFirestore.instance
            .collection('Academy').doc(elemen.id).collection('Admission')
            .get().then((docid) {
          docid.docs.forEach((el) {
            alldate.clear();
            for(int i=0;i<alldate.length;i++){
              alldate.removeAt(i);
            }

            String name = el['name'];
            String email = el.id;
            String address = el['address'];
            String dateOfBirth = el['dateOfBirth'];
            bool isMale = el['isMale'];
            String phoneNumber = el['phoneNumber'];
            bool programsInterestedIn = el['programsInterestedIn'];
            bool status = el['status'];
            String selectedShift = el['selectedShift'];
            print("HHHHHHHHHH ${name} llll $status");

            // FirebaseFirestore.instance
            //     .collection('Academy').doc(elemen.id).collection('Admission').doc(el.id).collection('Attendance')
            //     .get().then((v) {
            //       v.docs.forEach((element) {
            //perticular player all attendance
            FirebaseFirestore.instance
                .collection('Academy')
                .doc(elemen.id)
                .collection('Admission')
                .doc(el.id)
                .collection('Attendance')
                .get()
                .then((value) {
              value.docs.forEach((element) {
                alldate.add(element.id);
                if (element.id == '${noow.year}-${noow.month}-${noow.day}') {
                  bool p=false;
                  p=element.get('present');
                  setState(() {
                    emailss.add(
                      NameAndEmail(
                        present: p,
                        useremail: elemen.id,
                        name: name,
                        email: email,
                        address: address,
                        dateOfBirth: dateOfBirth,
                        isMale: isMale,
                        phoneNumber: phoneNumber,
                        status: status,
                        selectedShift: selectedShift,
                      ),
                    );
                  });
                  streamController.add(
                    NameAndEmail(
                      present: p,
                      useremail: academy.id,
                      name: name,
                      email: email,
                      address: address,
                      dateOfBirth: dateOfBirth,
                      isMale: isMale,
                      phoneNumber: phoneNumber,
                      status: status,
                      selectedShift: selectedShift,
                    ),
                  );
                  setState(() {
                    isPresent = element.get('present');
                  });
                }
                else{
                }
              });
            }).then((value) {
              for(int i=0;i<alldate.length;i++){
                if(alldate[i]=='${noow.year}-${noow.month}-${noow.day}'){
                  setState(() {
                    hasdate=true;
                  });
                }else{}
              }
            }).then((value) {
              if (hasdate == false){
                FirebaseFirestore.instance
                    .collection('Academy')
                    .doc(elemen.id)
                    .collection('Admission')
                    .doc(el.id)
                    .collection('Attendance').doc('${noow.year}-${noow
                    .month}-${noow.day}')
                    .set({'date': '${noow.year}-${noow.month}-${noow
                    .day}', 'present': false}).then((value) {
                  setState(() {
                    emailss.add(
                      NameAndEmail(
                        present: false,
                        useremail: elemen.id,
                        name: name,
                        email: email,
                        address: address,
                        dateOfBirth: dateOfBirth,
                        isMale: isMale,
                        phoneNumber: phoneNumber,
                        status: status,
                        selectedShift: selectedShift,
                      ),
                    );
                  });
                  streamController.add(
                    NameAndEmail(
                      present: false,
                      useremail: elemen.id,
                      name: name,
                      email: email,
                      address: address,
                      dateOfBirth: dateOfBirth,
                      isMale: isMale,
                      phoneNumber: phoneNumber,
                      status: status,
                      selectedShift: selectedShift,
                    ),
                  );
                });
              }
            });
            //       });
            // });
          });
        });
      });
    });
  }
  // void checkSavedCredentials() async {
  //   User currentUser = _firebaseAuth.currentUser;
  //   if (currentUser != null) {
  //     setState(() {
  //       isSavedCredentials = true;
  //     });
  //   }
  // }

  void logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false,
    );
  }

  final List<String> imagesList = [
    'assets/Qwe.jpg',
  ];

  final List<String> gifLists = [
    'assets/giphy.gif',
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LoginController _loginController = Get.put(LoginController());

  @override


  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop(context),
      child: Scaffold(
        drawer: CustomDrawer(),
        backgroundColor:  Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xff2e2d77),
          elevation: 0.0,
          centerTitle: true,
          title:
          Center(
            child: Obx(() {
              String username = _loginController.username.value;

              if (username.isEmpty) {
                return Text('Welcome', style: TextStyle(color: Colors.white));
              } else {
                return Text(
                  'Welcome, ${username.substring(0, 1).toUpperCase()}${username.substring(1)}!',
                  style: TextStyle(color: Colors.white),
                );
              }
            }),
          ),
          iconTheme: IconThemeData(color: Colors.white),

        ),
        // bottomNavigationBar: GNav(rippleColor: Colors.red,
        //   color: Colors.black,
        //   tabBackgroundColor: Colors.red.withOpacity(0.1),
        //   tabs: [
        //     GButton(icon: Icons.home, text: 'Home',
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => Dashboard()),
        //         );
        //       },
        //     ),
        //     GButton(icon: Icons.schedule, text: 'Schedule',
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => schedule()),
        //         );
        //       },
        //     ),
        //     GButton(icon: Icons.person, text: 'Register',
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => SignupPage()),
        //         );
        //       },),
        //   ],
        // ),
        body:  SafeArea(
          child:
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/KickOff2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),


                // Container(
                //   height: 200.0, // Set your custom height here
                //   width: MediaQuery.of(context).size.width, // Set full width or another custom width
                //   child: CarouselSlider(
                //     options: CarouselOptions(
                //       height: 200.0, // Set the same height as the Container
                //       viewportFraction: 1.0,
                //       autoPlay: false,
                //       enlargeCenterPage: false,
                //     ),
                //     items: gifLists
                //         .map((item) => Container(
                //       child: Center(
                //         child: Image.asset(
                //           item,
                //           fit: BoxFit.cover,
                //           height: 200.0, // Set the same height as the Container
                //           width: MediaQuery.of(context).size.width, // Set full width or another custom width
                //         ),
                //       ),
                //     ))
                //         .toList(),
                //   ),
                // ),
                SizedBox(height: 40,),
                Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'TERMS & CONDITIONS',
                            style: GoogleFonts.getFont(
                              'Lato',
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'At Kick Off Academy, we collect and process various types of information, including personal data, to provide and improve our services. Kick Off Academy uses the information collected from users for various purposes',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.getFont(
                                'Lato',
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'Kick Off Academy © 2024.',
                            style: GoogleFonts.getFont(
                              'Lato',
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // SizedBox(height: 15,),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: 'Lato',
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Develop by ',
                                  ),
                                  TextSpan(
                                    text: 'srptechs.com',
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Color(0xff2e2d77),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launch('https://srptechs.com/');
                                      },
                                  ),
                                  TextSpan(
                                    text: ', All Rights Reserved.',
                                  ),
                                ],
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ],
                ),

                // Content(heading: '',headcolor: Colors.black,
                //   img: 'assets/aboutus.jpeg',
                //   clr:Colors.red,content: "Formed in 2012, Kick Off aims to provide a platform for football development across the country",
                // ),
                // SizedBox(height: 10,),
                // Container(
                //   child: Column(
                //     children: [
                //       Text('Our Trained Coaches',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                //       SizedBox(height: 10),
                //       Image.asset('assets/coaches.jpg'),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 10,),
                // Container(
                //   child: Column(
                //     children: [
                //       Text('Happy Place For Under 7',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                //       SizedBox(height: 10),
                //       Image.asset('assets/under.jpg'),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 10,),
                // Container(
                //   child: Column(
                //     children: [
                //       Text('One Stop Football Development',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                //       SizedBox(height: 10), // Optional spacing between text and image
                //       Image.asset('assets/team.jpg'), // Replace with your image asset path
                //     ],
                //   ),
                // ),
                //
                // SizedBox(height: 10,),
                // Container(
                //   child: Column(
                //     children: [
                //       Text('Polish Your Football Skills',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                //       SizedBox(height: 10), // Optional spacing between text and image
                //       Image.asset('assets/matche.jpg'), // Replace with your image asset path
                //     ],
                //   ),
                // ),
                //
                // SizedBox(height: 10,),
                // Container(
                //   child: Column(
                //     children: [
                //       Text('Senior Football Matches & Leagues',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                //       SizedBox(height: 10),
                //       Image.asset('assets/meeting.jpg'),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 10,),
                // Text('Choose Your Package',
                //   style: GoogleFonts.poppins(fontSize: 30,color: Colors.grey,fontWeight: FontWeight.w500),
                // ),
                // SizedBox(height: 10,),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text('We have you covered with multiple training packages for each age category',
                //     style: GoogleFonts.poppins(fontSize: 10,color: Colors.black,fontWeight: FontWeight.w500),
                //   ),
                // ),
                // Column(
                //   children: [
                //     Text(
                //       'Our Group Schedule',
                //       style: TextStyle(
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     SizedBox(height: 10),
                //     SingleChildScrollView(
                //       scrollDirection: Axis.horizontal,
                //       child: Row(
                //         children: [
                //           SizedBox(width: 10),
                //           buildScheduleGroup(
                //             'Group A',
                //             'Tue, Thu, Sat',
                //             '5:00 PM - 6:30 PM',
                //             'Recommended: Boys 10-14 Years',
                //           ),
                //           Divider(height: 10, endIndent: 5, indent: 5, thickness: 1, color: Colors.grey),
                //           buildScheduleGroup(
                //             'Group B',
                //             'Mon, Wed, Fri',
                //             '5:00 PM - 6:00 PM',
                //             'Recommended: Boys 3-12 Years & Girls 3-10 Years',
                //           ),
                //           Divider(height: 10, endIndent: 5, indent: 5, thickness: 1, color: Colors.grey),
                //           buildScheduleGroup(
                //             'Group C',
                //             'Mon, Wed, Fri',
                //             '6:00 PM - 7:00 PM',
                //             'Recommended: Boys 3-10 Years & Girls 3-14 Years',
                //           ),
                //           Divider(height: 10, endIndent: 5, indent: 5, thickness: 1, color: Colors.grey),
                //           buildScheduleGroup(
                //             'Group D',
                //             'Tue, Thu, Sat',
                //             '6:30 PM - 7:30 PM',
                //             'Recommended: Boys 15+',
                //           ),
                //           Divider(height: 10, endIndent: 5, indent: 5, thickness: 1, color: Colors.grey),
                //           buildScheduleGroup(
                //             'Group E',
                //             'Tue, Thu, Sat',
                //             '6:30 PM - 7:30 PM',
                //             'Recommended: Boys 3-10 Years & Girls 3-14 Years',
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ) ,
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              print("use less $currentIndex");
              // Navigate to the desired pages based on the index
              if (currentIndex == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScreenMain()),
                );
              } else if (currentIndex == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GroundListingUI()),
                  );
              }
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              label: 'Home',
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Icon(Icons.home, color: currentIndex == 0 ? Color(0xff2e2d77) : Colors.grey),
                        Text(
                          "Home",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: currentIndex == 0 ? Color(0xff2e2d77) : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              label: 'Book & Play',
              icon: Column(
                children: [
                  Icon(Icons.menu_book_sharp, color: currentIndex == 1 ? Color(0xff2e2d77) : Colors.grey),
                  Text(
                    "Book & Play",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: currentIndex == 1 ? Color(0xff2e2d77) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  Content({
    required this.clr,
    required this.content,
    required this.img,
    required this.headcolor,
    required this.heading,
  }) : aboutus = '';

  String content;
  String aboutus;
  String heading;
  String img;
  Color headcolor;
  Color clr;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:   Container(
        height: MediaQuery.of(context).size.height*1,
        child: Stack(
          children: [
            BackdropFilter(filter: ImageFilter.blur(sigmaX:0, sigmaY: 0),
              child: Center(child: Image.asset(
                img,
                fit: BoxFit.cover, // Make sure the image covers the whole screen
                width: double.infinity,
                height: double.infinity,
              ),),),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(

                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
                    child: FadeAnimation(1.5, Text(
                      heading,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: headcolor,
                          fontSize: 24.0),
                      // style: TextStyle(
                      //     fontWeight: FontWeight.bold,

                      //     color: Color.fromARGB(255, 124, 20, 20)),
                    ), ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    color: Color(0x86000000),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child:FadeAnimation(1.5, Text( content,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          height: 2,
                          color: Colors.white,
                        ),
                      ),),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}