import 'package:appkickoff/utils/drawer/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../personalization/controllers/aboutUs_controller.dart';
import '../../E_Shop/Shop_ui.dart';
import '../HomePage/homepage.dart';
import '../Login/login.dart';
import '../Parent View/ParentMonths.dart';
import '../Parent View/Parent_dashboard.dart';
import '../Parent View/admission_form.dart';
import '../Sign Up/signup.dart';
import '../alpha.dart';
import '../bookandplay/login/login_form.dart';
import '../bookandplay/login/loginbook&play.dart';
import 'Gallery.dart';
import 'Location.dart';
import 'contactUs.dart';
import 'feedback_suggestion.dart';

class AboutUs extends StatefulWidget {
  AboutUs();

  @override
  State<AboutUs> createState() => _AboutUsState();
}
int currentIndex = 0;
SharedPreferences? _prefs;

final AboutController aboutController = Get.put(AboutController());

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2e2d77),
        drawer: CustomDrawer(),
        body: Obx(() {
          if (aboutController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (aboutController.errorMessage.isNotEmpty) {
            return Center(child: Text(aboutController.errorMessage.value));
          }

          final aboutData = aboutController.aboutData.isNotEmpty ? aboutController.aboutData[0] : null;

          return CustomScrollView(
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
                            'Welcome to Kick Off!',
                            style: TextStyle(
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
                          SizedBox(height: 15),
                          Text(
                            aboutData?.whoWeAre ?? '"Kick Off aims to provide a platform for kids and adults to improve and refine their football skills, while also using football as a significant tool to enhance character building and promote exposure to different cultures."',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 17.0,
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
                                        aboutData?.ourVision ?? 'Play, Train, Entertainment',
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
                                  onPressed: () async {},
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
          );
        }),
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
