 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../../../utils/global_function/Globalfunction.dart';
import '../HomePage/homepage.dart';
import '../bookandplay/listing_ground/ground_listing.dart';
 
import '../bookandplay/login/loginbook&play.dart';
import 'Register_page.dart';


final _borderRadius = BorderRadius.circular(5);
 
class ScreenMain extends StatefulWidget {
  ScreenMain({Key? key}) : super(key: key);

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  TextEditingController searchController = TextEditingController();
  int _selectedIndex = 0;
  bool _shouldShowRegisterOption = true;
  // List<Widget> _screens = [];
  int currentIndex = 0;
 late List<Widget> screens;
  bool isRegistered = false; // Track if the user has registered.

  @override
  void initState() {
    super.initState();

    checkUserRegistration();

    screens = <Widget>[
      Dashboard(),
      GroundListingUI(),
      RegisterPage(),
    ];
  }



  void checkUserRegistration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool registered = prefs.getBool('isRegistered') ?? false;
    setState(() {
      isRegistered = registered;
    });
  }

  // Function to set the registration status in shared preferences.
  Future<void> setUserRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isRegistered', true);
    setState(() {
      isRegistered = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop(context),
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
 
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              print("use less $currentIndex");
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
              icon: Column(
                children: [
                  Icon(
                    Icons.home,
                    color: currentIndex == 0 ? Color(0xff2e2d77) : Colors.grey,
                  ),
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
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              label: 'Book & Play',
              icon: Column(
                children: [
                  Icon(
                    Icons.menu_book_sharp,
                    color: currentIndex == 1 ? Color(0xff2e2d77) : Colors.grey,
                  ),
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
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              label: 'Register',
              icon: Column(
                children: [
                  Icon(
                    Icons.supervised_user_circle_outlined,
                    color: currentIndex == 1 ? Color(0xff2e2d77) : Colors.grey,
                  ),
                  Text(
                    "Register",
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

class ShiftItem {
  final String? startTime;
  final String? endTime;
  final String? position;

  ShiftItem({
    this.startTime,
    this.endTime,
    this.position,
  });
}
 
 