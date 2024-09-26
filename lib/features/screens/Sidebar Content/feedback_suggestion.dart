import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:mailer/smtp_server/gmail.dart';
import '../../../personalization/controllers/feedback_controller.dart';
import '../../../personalization/models/feedback_model.dart';
import '../../../utils/drawer/custom_drawer.dart';
import '../HomePage/homepage.dart';
import '../Parent View/Parent_dashboard.dart';
import '../Sign Up/signup.dart';
import '../alpha.dart';


bool isLoggedbottomIn = false;

class FeedbackPage extends StatefulWidget {
  const FeedbackPage();

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController _feedbackController = TextEditingController();
  int currentIndex = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _recipientEmailController = TextEditingController();
  final TextEditingController _mailMessageController = TextEditingController();
  SharedPreferences? _prefs;


  final RxInt _rating = 0.obs;

  final FeedbackController feedbackController = Get.put(FeedbackController());



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
        drawer: CustomDrawer(),
        appBar: AppBar(
        backgroundColor:  Color(0xff2e2d77),
        title: Text(
          'Feedback & Suggestion',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white), // Set icon color to white
        centerTitle: true,
      ),
        body: Obx(() {
          if (feedbackController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
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
                            _rating.value >= i ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            _rating.value = i;
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
                              final feedback = FeedbackModel(
                                rating: _rating.value,
                                email: _recipientEmailController.text,
                                message: _mailMessageController.text,
                                id: '', // May be empty if not needed
                                v: 0, // May be empty if not needed
                              );

                              feedbackController.postFeedback(feedback).then((_) {
                                // Show success dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Feedback Sent'),
                                      content: Text('Your feedback has been successfully sent.'),
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
                              }).catchError((error) {
                                // Show error dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Failed to send feedback: $error'),
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
                              });
                            }
                          },
                          child: Text('Send Feedback', style: TextStyle(color: Colors.white)),
                        ),
                        if (feedbackController.errorMessage.isNotEmpty)
                          Text(
                            feedbackController.errorMessage.value,
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                  ),
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
