import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../personalization/controllers/contactUs_controller.dart';
import '../Parent View/HistoryPlayers/AdminNavBar/AdminShop_ui.dart';
import '../Parent View/Parent_dashboard.dart';
import '../Sign Up/signup.dart';
import '../alpha.dart';


class ContactUs extends StatefulWidget {

  @override
  State<ContactUs> createState() => _ContactUsState();

}

class _ContactUsState extends State<ContactUs> {


  final ContactController contactController = Get.put(ContactController());


  _launchEmail(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch $_emailLaunchUri';
    }
  }

  void _launchPhone(String phoneNumber) async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (await canLaunch(phoneLaunchUri.toString())) {
      await launch(phoneLaunchUri.toString());
    } else {
      print('Could not launch phone');
    }
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff2e2d77),
        title: Text('Contact Us',style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white), // Set icon color to white
        centerTitle: true,

      ),
      body: Obx(() {
        if (contactController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (contactController.errorMessage.isNotEmpty) {
          return Center(child: Text(contactController.errorMessage.value));
        }

        final contactData = contactController.contactData.isNotEmpty
            ? contactController.contactData[0]
            : null;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/contactus.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    Text(
                      'Say Hello! \u{1F604}',
                      style: TextStyle(fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff2e2d77)),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                        contactData!.title,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      'Contact Information',
                      style: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff2e2d77)),
                    ),
                    SizedBox(height: 16.0),

                    GestureDetector(
                      onTap: () async {
                        launch('https://gmail.com/');
                      },
                      child: ListTile(
                        leading: Icon(Icons.email),
                        title: Text('Email'),
                        subtitle: Text(contactData!.contact.email),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchPhone(contactData!.contact.phone);
                      },
                      child: ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('Phone'),
                        subtitle: Text(contactData!.contact.phone),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      'Follow Us',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            launch(
                                'https://www.facebook.com/kickoffacademypk/');
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              FontAwesomeIcons.facebook,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            launch(
                                'https://instagram.com/kickoffacademypkk?igshid=MzRlODBiNWFlZA==');
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.purple,
                            child: Icon(
                              FontAwesomeIcons.instagram,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            launch('https://youtube.com/@kickoffacademy2459');
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.red,
                            child: Icon(
                              FontAwesomeIcons.youtube,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            launch('https://timetokickoff.com');
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xff2e2d77),
                            backgroundImage: AssetImage(
                                'assets/kickofflogo.png'),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
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
}


class OpenGmailButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final Uri emailLaunchUri = Uri(
          scheme: 'mailto',
          path: 'ukashaaziz0@gmail.com',
        );

        final String emailUri = emailLaunchUri.toString();
        if (await canLaunch(emailUri)) {
          await launch(emailUri);
        } else {
          print('Could not launch email');
        }
      },
      child: ListTile(
        leading: Icon(Icons.email),
        title: Text('Email'),
        subtitle: Text('contactus@timetokickoff.com'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ContactUs(),
  ));
}
