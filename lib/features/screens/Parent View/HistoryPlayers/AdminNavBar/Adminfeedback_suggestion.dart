import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../../../../main.dart';
import '../../../HomePage/homepage.dart';
import '../../../Login/login.dart';
import '../../../Sign Up/signup.dart';
import '../../../alpha.dart';
import '../../Parent_dashboard.dart';
import 'AdminShop_ui.dart';
import 'Adminaboutus.dart';
import 'Admincontactus.dart';
import 'Admingallery.dart';
import 'Adminlocation.dart';



bool isLoggedbottomIn = false;

class AdminFeedbackPage extends StatefulWidget {
  const AdminFeedbackPage();

  @override
  _AdminFeedbackPageState createState() => _AdminFeedbackPageState();
}

class _AdminFeedbackPageState extends State<AdminFeedbackPage> {

  int _rating = 0;
  TextEditingController _feedbackController = TextEditingController();
  int currentIndex = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _recipientEmailController =
  TextEditingController();
  final TextEditingController _mailMessageController = TextEditingController();
 SharedPreferences? _prefs;



  // Send Mail function
  void sendMail({
    String? recipientEmail,
    String? mailMessage,
  }) async {
    // change your email here
    String username = 'ukashaaziz0@gmail.com';
    // change your password here
    String password = 'zfcozrjcaigpexlh';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Mail Service')
      ..recipients.add(recipientEmail)
      ..subject = 'Mail '
      ..text = 'Message: $mailMessage';

    try {
      await send(message, smtpServer);
      // showSnackbar('Email sent successfully');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  final _formKey = GlobalKey<FormState>();


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

      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white), // Set icon color to white
        centerTitle: true,
        backgroundColor:  Color(0xff2e2d77),
        title: Text(
          'Feedback & Suggestion',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rate Our App',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 1; i <= 5; i++)
                    IconButton(
                      icon: Icon(
                        _rating >= i ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                      onPressed: () {
                        setState(() {
                          _rating = i;
                        });
                      },
                    ),
                ],
              ),
              SizedBox(height: 32.0),
              Text(
                'Feedback and Suggestion',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Recipient Email',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      controller: _recipientEmailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter recipient email';
                        }
                        if (!value.contains('@')) {
                          return 'Email Format error';
                        }
                        if (!value.contains('.')) {
                          return 'Email Format Error';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      maxLines: 5,
                      controller: _mailMessageController,
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a message';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32.0),
                    MaterialButton(
                      color: Color(0xff2e2d77),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          sendMail(
                            recipientEmail: _recipientEmailController.text.toString(),
                            mailMessage: _mailMessageController.text.toString(),
                          );

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Email Sent'),
                                content: Text('Your email has been successfully sent.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text('Send Mail', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              )
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
          ),        ],
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
          ),        ],
      )
    );
  }
}
