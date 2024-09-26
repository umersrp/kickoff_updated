import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../../../../../main.dart';
import '../../../HomePage/homepage.dart';
import '../../../Login/login.dart';
import '../../../Sign Up/signup.dart';
import '../../../alpha.dart';
import '../../Parent_dashboard.dart';
import 'AdminShop_ui.dart';
import 'Adminaboutus.dart';
import 'Admincontactus.dart';
import 'Adminfeedback_suggestion.dart';
import 'Admingallery.dart';

bool isLoggedbottomIn = false;

class AdminLocationUI extends StatefulWidget {
  @override
  State<AdminLocationUI> createState() => _AdminLocationUIState();
}

class _AdminLocationUIState extends State<AdminLocationUI> {
  int currentIndex = 0;
  SharedPreferences? _prefs;


  // Sample data for the dropdown
  List<String> locations = ['DA CREEK CLUB, KARACHI'];

  String selectedLocation = 'DA CREEK CLUB, KARACHI';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: isLoggedIn==true? Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xff2e2d77),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/kickofflogo.png',
                      height: 80,
                    ),
                    const Text(
                      'LETS KICK OFF',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.supervised_user_circle_outlined,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('About Us'),
                onTap: () {
                  // Redirect to the parent panel page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminaboutUs()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.pin_drop,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Location & Schedule'),
                onTap: () {
                  // Redirect to the parent panel page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminLocationUI()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.shopping_bag_rounded,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Shop Now'),
                onTap: () {
                  // Redirect to the parent panel page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminShopUI()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.panorama_rounded,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Gallery'),
                onTap: () {
                  // Redirect to the parent panel page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminGalleryUI()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.contacts,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Contact Us'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminContactUs()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.feedback,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Feedback & Suggestion'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminFeedbackPage()),
                  );
                },
              ),
              // ListTile(
              //   leading: const Icon(
              //     Icons.recent_actors_sharp,
              //     color: Color(0xff2e2d77),
              //   ),
              //   title: const Text('Player Record'),
              //   onTap: () {
              //     // Redirect to the parent panel page
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => AdmissionForm()),
              //     );
              //   },
              // ),
              //
              // ListTile(
              //   leading: const Icon(
              //     Icons.history_edu_rounded,
              //     color: Color(0xff2e2d77),
              //   ),
              //   title: const Text('Player Attendance'),
              //   onTap: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (context) => AttendanceParent(),
              //       ),
              //     );
              //   },
              // ),

              // ListTile(
              //   leading: const Icon(
              //     Icons.exit_to_app,
              //     color: Color(0xff2e2d77),
              //   ),
              //   title: const Text(
              //     'Logout',
              //   ),
              //   onTap: () {
              //     FirebaseAuth.instance.signOut().then((value) async {
              //       _prefs ??= await SharedPreferences.getInstance();
              //
              //       await _prefs?.setBool('logout', false);
              //       bool getlogout = _prefs?.getBool('logout') ?? false;
              //       print('::::HAIN BHAI KIYAaaaaaa kkkk $getlogout');
              //
              //       setState(() {
              //         isLoggedIn = false;
              //       });
              //       Get.offAll(ScreenMain());
              //
              //       Navigator.of(context).pushReplacement(
              //           MaterialPageRoute(builder: (BuildContext context) => ScreenMain()),
              //       );
              //     }
              //     ).catchError((error) {
              //       print('Error during sign out: $error');
              //     });
              //   },
              // ),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Color(0xff2e2d77),
                ),
                title: const Text(
                  'Logout',
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value)async {
                    _prefs ??= await SharedPreferences.getInstance();

                    await _prefs?.setBool('logout', false);

                    setState(() {
                      isLoggedIn = false;
                    });

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) => ScreenMain()),
                    );
                  }).catchError((error) {
                    print('Error during sign out: $error');
                  });
                },
              ),
            ],
          ),
        ) :  Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xff2e2d77),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/kickofflogo.png',
                      height: 80,
                    ),
                    const Text(
                      'LETS KICK OFF',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),

                  ],
                ),
              ),
              Builder(
                builder: (context) {
                  if (isLoggedIn) {
                    return
                      ListTile(
                        leading: const Icon(
                          Icons.supervised_user_circle_outlined,
                          color: Color(0xff2e2d77),
                        ),
                        title: const Text('Parent Panel'),
                        onTap: () {
                          // Redirect to the parent panel page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ParentDashboard()),
                          );
                        },
                      );
                  } else {
                    return ListTile(
                      leading: const Icon(
                        Icons.admin_panel_settings_sharp,
                        color: Color(0xff2e2d77),
                      ),
                      title: const Text('Login'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        ).then((value) {
                          if (value != null && value) {
                            setState(() {
                              isLoggedIn = true;
                            });
                          }
                        });
                      },
                    );
                  }
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.supervised_user_circle_outlined,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('About Us'),
                onTap: () {
                  // Redirect to the parent panel page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminaboutUs()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.pin_drop,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Location & Schedule'),
                onTap: () {
                  // Redirect to the parent panel page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminLocationUI()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.shopping_bag_rounded,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Shop Now'),
                onTap: () {
                  // Redirect to the parent panel page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminShopUI()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.panorama_rounded,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Gallery'),
                onTap: () {
                  // Redirect to the parent panel page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminGalleryUI()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.contacts,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Contact Us'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminContactUs()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.feedback,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Feedback & Suggestion'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminFeedbackPage()),
                  );
                },
              ),
            ],
          ),
        ),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white), // Set icon color to white
        backgroundColor: Colors.indigo,
        title: Text(
          'Location and Schedule',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Location',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: selectedLocation,
                onChanged: (newValue) {
                  // Implement logic to update the selected location
                },
                items: locations.map((location) {
                  return DropdownMenuItem<String>(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                'Our Schedule',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildScheduleGroup(
                'Group A',
                'Mon, Wed, Fri',
                '5:00 PM – 6:00 PM',
                'Ages: Boys 10-15 years',
              ),
              Divider(height: 10,endIndent: 5,indent: 5,thickness: 1,color: Colors.grey,),
              buildScheduleGroup(
                'Group B',
                'Mon, Wed, Fri',
                '5:00 PM - 6:00 PM',
                'Ages: Boys & Girls 3-10 years',
              ),
              Divider(height: 10,endIndent: 5,indent: 5,thickness: 1,color: Colors.grey,),

              buildScheduleGroup(
                'Group C',
                'Tue, Thu, Sat',
                '5:00 PM – 6:00 PM',
                'Ages: Boys & Girls 3-10 years',
              ),
              Divider(height: 10,endIndent: 5,indent: 5,thickness: 1,color: Colors.grey,),

              buildScheduleGroup(
                'Group D',
                'Tue, Thu, Sat',
                '6:00 – 7:00 PM',
                'Ages: Boys 10-15 years',
              ),
              Divider(height: 10,endIndent: 5,indent: 5,thickness: 1,color: Colors.grey,),

              buildScheduleGroup(
                'Group E  16+ Boys',
                'Mon, Wed, Fri',
                '8:00 – 9:00 PM',
                'Ages: 16 years+',
              ),
              Divider(height: 10,endIndent: 5,indent: 5,thickness: 1,color: Colors.grey,),

              buildScheduleGroup(
                'Group F – 16+ Boys',
                'Tue, Thu, Sat',
                '7:00 – 8:00 PM',
                'Ages: 16 years+ Boys',
              ),
              Divider(height: 10,endIndent: 5,indent: 5,thickness: 1,color: Colors.grey,),

              buildScheduleGroup(
                'Group G – All Girls',
                'Mon, Wed, Fri',
                '7:00 – 8:00 PM',
                'Ages: 7 years+ Girls',
              ),
              Divider(height: 10,endIndent: 5,indent: 5,thickness: 1,color: Colors.grey,),

              buildScheduleGroup(
                'Group M – Morning Sessions',
                'Mon, Wed, Fri',
                '7:30 – 8:30 AM',
                '6 years+ Boys & Girls',
              ),
              Divider(height: 10,endIndent: 5,indent: 5,thickness: 1,color: Colors.grey,),

              buildScheduleGroup(
                'Group S – Kick Off Senior Mens',
                'Tue, Thu, Sat',
                '8:00 – 9:00 PM',
                'Ages: 15 years+ Boys',
              ),
              Divider(height: 10,endIndent: 5,indent: 5,thickness: 1,color: Colors.grey,),

              buildScheduleGroup(
                  'Group W – Weekend ',
                  'Sat, Sun',
                  '4:00 – 5:00 PM & 5:00–7:00PM',
                  ''
              ),
            ],
          ),
        ),
      ),
        bottomNavigationBar: isLoggedbottomIn==true?BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              print("use less $currentIndex");
              // Navigate to the desired pages based on the index
              if (currentIndex == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParentDashboard()),
                );
              } else {
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShiftsListPage()),
                  );
                }
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
            ),          ],
        ):
        BottomNavigationBar(
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
              } else {
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShiftsListPage()),
                  );
                }
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
            ),          ],
        )

    );
  }

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
}



