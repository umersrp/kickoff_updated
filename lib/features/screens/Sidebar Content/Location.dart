import 'package:appkickoff/utils/drawer/custom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../personalization/controllers/schedule_controller.dart';
import '../../../utils/constant/colors.dart';
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
import 'About Us.dart';
import 'Gallery.dart';
import 'Location.dart';

import 'contactUs.dart';
import 'feedback_suggestion.dart';

class LocationUI extends StatefulWidget {
  @override
  State<LocationUI> createState() => _LocationUIState();
}

class _LocationUIState extends State<LocationUI> {
  int currentIndex = 0;
  SharedPreferences? _prefs;

       List<String> locations = ['DA CREEK CLUB, KARACHI'];

  String selectedLocation = 'DA CREEK CLUB, KARACHI';

  final ScheduleController scheduleController = Get.put(ScheduleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        title: Text(
          'Location and Schedule',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
            color: Colors.white), // Set icon color to white

      ),
        body: Obx(() {
          if (scheduleController.isLoading.value) {
            return Center(child: CircularProgressIndicator()); // Show a loading indicator while fetching data
          }

          if (scheduleController.errorMessage.isNotEmpty) {
            return Center(child: Text(scheduleController.errorMessage.value)); // Show an error message if there's an error
          }

          return SingleChildScrollView(
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
                  // Generate schedule groups from the scheduleData
                  ...scheduleController.scheduleData.map((schedule) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Ensure left alignment
                      children: [
                        buildScheduleGroup(
                          schedule.group,
                          schedule.days.join(', '),
                          '${schedule.startTime} – ${schedule.endTime}',
                          'Ages: ${schedule.ages}',
                        ),
                        Divider(height: 10, endIndent: 5, indent: 5, thickness: 1, color: Colors.grey),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        }),

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

  Widget buildScheduleGroup(String group, String days, String time, String ages) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Ensure left alignment
        children: [
          Text(
            group,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left, // Explicitly set text alignment to left
          ),
          SizedBox(height: 4),
          Text(
            days,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.left, // Explicitly set text alignment to left
          ),
          SizedBox(height: 4),
          Text(
            time,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.left, // Explicitly set text alignment to left
          ),
          SizedBox(height: 4),
          Text(
            ages,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.left, // Explicitly set text alignment to left
          ),
        ],
      ),
    );
  }
}
