import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/E_Shop/Shop_ui.dart';
import '../../features/screens/Login/login.dart';
import '../../features/screens/Parent View/Parent_dashboard.dart';
import '../../features/screens/Parent View/admission_form.dart';
import '../../features/screens/Parent View/parent_homepage.dart';
import '../../features/screens/Sidebar Content/About Us.dart';
import '../../features/screens/Sidebar Content/Gallery.dart';
import '../../features/screens/Sidebar Content/Location.dart';
import '../../features/screens/Sidebar Content/PrivacyPolicy.dart';
import '../../features/screens/Sidebar Content/contactUs.dart';
import '../../features/screens/Sidebar Content/feedback_suggestion.dart';
import '../../features/screens/Sign Up/signup.dart';
import '../../features/screens/bookandplay/login/loginbook&play.dart';
import '../../features/screens/coaches_Screen/coaches_Dashboard.dart';
import '../../personalization/login/controllers/login_controller.dart';
import '../../personalization/user_panel/screen/userattendance.dart';

class CustomDrawer extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getUserType(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // or any loading indicator
        }
        final userType = snapshot.data;

        return Drawer(
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
              // Conditionally show the Login tile
              if (userType != 'admin' && userType != 'coaches' && userType != 'user')
                ListTile(
                  leading: const Icon(
                    Icons.admin_panel_settings_sharp,
                    color: Color(0xff2e2d77),
                  ),
                  title: const Text('Login'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              // Conditionally show the Admin Panel tile if userType is 'admin'
              if (userType == 'admin')
                ListTile(
                  leading: const Icon(
                    Icons.admin_panel_settings_sharp,
                    color: Color(0xff2e2d77),
                  ),
                  title: const Text('Admin Panel'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Parenthomepage()),
                    );
                  },
                ),
              // Conditionally show the Parent Dashboard tile if userType is 'user'
              if (userType == 'user')
                ListTile(
                  leading: const Icon(
                    Icons.dashboard,
                    color: Color(0xff2e2d77),
                  ),
                  title: const Text('Parent Dashboard'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ParentDashboard()),
                    );
                  },
                ),
              // Conditionally show the Coaches Dashboard tile if userType is 'coach'
              if (userType == 'coaches')
                ListTile(
                  leading: const Icon(
                    Icons.dashboard,
                    color: Color(0xff2e2d77),
                  ),
                  title: const Text('Coaches Dashboard'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CoachesDashboard()),
                    );
                  },
                ),
              ListTile(
                leading: const Icon(
                  Icons.supervised_user_circle_outlined,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('About Us'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUs()),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocationUI()),
                  );
                },
              ),
              if (userType != 'admin' && userType != 'coaches' && userType != 'user')
                ListTile(
                leading: const Icon(
                  Icons.app_registration_outlined,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Register Now'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShopUI()),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GalleryUI()),
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
                    MaterialPageRoute(builder: (context) => ContactUs()),
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
                    MaterialPageRoute(builder: (context) => FeedbackPage()),
                  );
                },
              ),
              if (userType == 'user')
                ListTile(
                leading: const Icon(
                  Icons.recent_actors_sharp,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Player Record'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdmissionForm()),
                  );
                },
              ),
              if (userType == 'user')
                ListTile(
                leading: const Icon(
                  Icons.history_edu_rounded,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Player Attendance'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserAttendanceScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.private_connectivity_outlined,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Privacy & Policy'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PrivacyPolicy()),
                  );
                },
              ),
              // Show Logout for all user types
              if (userType != null)
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Color(0xff2e2d77),
                  ),
                  title: const Text(
                    'Logout',
                  ),
                  onTap: () async {
                    _loginController.logout(); // Call logout method
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) => ScreenMain()),
                    );

                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Future<String?> _getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userType');
  }
}
