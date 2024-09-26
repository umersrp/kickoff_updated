import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../HomePage/homepage.dart';
import '../../../Login/login.dart';
import '../../../Sign Up/signup.dart';
import '../../../alpha.dart';
import '../../Parent_dashboard.dart';
import 'AdminShop_ui.dart';
import 'Admincontactus.dart';
import 'Adminfeedback_suggestion.dart';
import 'Admingallery.dart';
import 'Adminlocation.dart';

bool isLoggedbottomIn = false;


class AdminaboutUs extends StatefulWidget {
  const AdminaboutUs() ;

  @override
  State<AdminaboutUs> createState() => _AdminaboutUsState();
}
int currentIndex = 0;
SharedPreferences? _prefs;



class _AdminaboutUsState extends State<AdminaboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2e2d77),
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white), // Set icon color to white
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image: AssetImage('assets/aboutus.jpeg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.2),
                        BlendMode.dstATop,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'About Us',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'YourCustomFont', // Use your custom font here
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Welcome to Kick Off',
                        style:TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Who We Are',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Kick Off aims to provide a platform for kids and adults to improve and polish their football skills. We also use football as a major tool to enhance character building and exposure to different cultures.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        color: Color(0xff2e2d77),
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // Container(
                            //   width: 200,
                            //   height: 200,
                            //   decoration: BoxDecoration(
                            //     color: Color(0xff2e2d77),
                            //     border: Border.all(
                            //       color: Colors.white,
                            //       width: 2.0,
                            //     ),
                            //     borderRadius: BorderRadius.circular(100),
                            //   ),
                            //   child: Center(
                            //     child: CircleAvatar(
                            //       radius: 90.0,
                            //       backgroundImage: AssetImage('assets/aboutus.jpeg'),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 20.0),
                            // Text(
                            //   'Welcome to Kick Off',
                            //   style: TextStyle(
                            //     fontSize: 28.0,
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.white,
                            //   ),
                            // ),
                            // SizedBox(height: 20.0),
                            // Text(
                            //   'Who We Are',
                            //   style: TextStyle(
                            //     fontSize: 24.0,
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.white,
                            //   ),
                            // ),
                            // Container(
                            //   padding: EdgeInsets.all(16.0),
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(8.0),
                            //   ),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: <Widget>[
                            //       Text(
                            //         'Kick Off aims to provide a platform for kids and adults to improve and polish their football skills,Also using football as a major tool to enhance character building and exposure to different cultures. ',
                            //         textAlign: TextAlign.center,
                            //         style: TextStyle(
                            //           fontSize: 18.0,
                            //           color: Colors.black,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Text(
                              'Our Vision',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20.0),

                            Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Play, Train, Entertainment',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.0),
                            ElevatedButton(
                              onPressed: () async {
                                // Open a web page when the button is pressed
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Color(0xff2e2d77),
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                              ),
                              child: Text(
                                'Explore More',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    launch('https://www.facebook.com/kickoffacademypk/');
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.blue,
                                    child: Icon(
                                      Icons.facebook,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () {
                                    launch('https://instagram.com/kickoffacademypkk?igshid=MzRlODBiNWFlZA==');
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xff2e2d77),
                                    backgroundImage: AssetImage('assets/kickofflogo.png'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

        bottomNavigationBar: isLoggedbottomIn==true?BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              print("use less $currentIndex");
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
            ),
          ],
        ):
        BottomNavigationBar (
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
            ),
          ],
        )
    );
  }
}
