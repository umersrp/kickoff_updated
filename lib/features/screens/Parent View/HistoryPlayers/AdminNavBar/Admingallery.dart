import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
import 'Adminlocation.dart';


bool isLoggedbottomIn = false;

class AdminGalleryUI extends StatefulWidget {
  const AdminGalleryUI();

  @override
  State<AdminGalleryUI> createState() => _AdminGalleryUIState();
}

class _AdminGalleryUIState extends State<AdminGalleryUI> {
  int currentIndex = 0;
  SharedPreferences? _prefs;

  @override
  Widget build(BuildContext context) {
    print(isLoggedIn);
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
              //       print('::::HAIN BHAI KIYAaaaaaa $getlogout');
              //
              //       setState(() {
              //         isLoggedIn = false;
              //       });
              //       Get.offAll(ScreenMain());
              //
              //       // Navigator.of(context).pushReplacement(
              //       //   MaterialPageRoute(builder: (BuildContext context) => ScreenMain()),
              //       // );
              //     }
              //     ).catchError((error) {
              //       print('Error during sign out: $error');
              //     });
              //   },
              // ),
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
      // appBar: AppBar(backgroundColor: Color(0xff2e2d77),
      //   title: const Text('Gallery',style: TextStyle(color: Colors.white),),
      //   iconTheme: IconThemeData(color: Colors.white), // Set icon color to white
      //   centerTitle: true,
      // ),
      backgroundColor: Colors.white,
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
                        image: AssetImage('assets/90.png'),
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
                          'Our Gallery',
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
            SliverPadding(
              padding: EdgeInsets.all(16.0),
              sliver: SliverGrid.count(
                crossAxisCount: 2, // Number of images per row
                mainAxisSpacing: 16.0, // Spacing between rows
                crossAxisSpacing: 16.0, // Spacing between columns
                children: [
                  _buildImageCard(context, 'assets/coaches.jpg', 'Our Coaches'),
                  _buildImageCard(context, 'assets/team.jpg', 'Team Photo'),
                  _buildImageCard(context, 'assets/Gallery.jpg', 'Gallery Image'),
                  _buildImageCard(context, 'assets/matche.jpg', 'Matches Day'),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            launch('https://instagram.com/kickoffacademypkk?igshid=MzRlODBiNWFlZA==');
          },
          child: Icon(FontAwesomeIcons.instagram,color: Colors.white,),
          backgroundColor: Colors.purple,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
            ),
          ],
        )
    );
  }
}

Widget _buildImageCard(BuildContext context, String imagePath, String title) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: InkWell(
      onTap: () {
        _showImageDialog(context, imagePath);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}

void _showImageDialog(BuildContext context, String imagePath) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Image.asset(imagePath),
    ),
  );
}