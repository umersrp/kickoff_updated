import 'dart:ui';
import 'package:appkickoff/animation/FadeAnimation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../personalization/controllers/homepage_controller.dart';
import '../../../utils/constant/Appbar.dart';
import '../../../utils/drawer/custom_drawer.dart';
import '../Sign Up/signup.dart';
import '../bookandplay/login/loginbook&play.dart';

bool isLoggedIn = false;

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
 
  @override
  void initState() {
    // print(':::::::::: $isLoggedIn && $isSavedCredentials');
    super.initState();
  }

  final HomepageController homepageController = Get.put(HomepageController());
  final List<String> imagesList = [
 
      'assets/Qwe.jpg',
  ];
  final List<String> gifLists = [
    'assets/giphy.gif',
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
 

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      backgroundColor:  Colors.white,
      appBar: MyAppBar(),
      body:  SafeArea(
        child:
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
 
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/KickOff2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: SizedBox(
                            width: 240,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
 
                                  MaterialPageRoute(builder: (context) => LoginScreen()),
                                );
                              },
                              child: Text(
                                'REGISTER NOW',
                                style: GoogleFonts.getFont(
                                  'Lato',
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
 
        Obx(() {
          if (homepageController.isLoading.value) {
            return Center(child: CircularProgressIndicator()); // Show a loading indicator while fetching data
          }

          if (homepageController.errorMessage.isNotEmpty) {
            return Center(child: Text(homepageController.errorMessage.value)); // Show an error message if there's an error
          }

          // Assuming you want to display the first item in the list, adjust as needed
          final homepageData = homepageController.HomepageData.isNotEmpty
              ? homepageController.HomepageData.first
              : null;

          return Column(
            children: [
              SizedBox(height: 40),
              if (homepageData != null)
                Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'ABOUT US',
                            style: GoogleFonts.getFont(
                              'Lato',
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              homepageData.aboutus,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.getFont(
                                'Lato',
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'TERMS & CONDITIONS',
                            style: GoogleFonts.getFont(
                              'Lato',
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              homepageData.termsandconditions,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.getFont(
                                'Lato',
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else
                Center(child: Text('No data available'))
            ],
          );
        }),


        Column(
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    'Kick Off Academy © 2024.',
                    style: GoogleFonts.getFont(
                      'Lato',
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.facebookF,color: Colors.blue,),
                        onPressed: () {
                          launch('https://www.facebook.com/kickoffacademypk/');
                        },
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.instagram,color: Colors.purple,),
                        onPressed: () {
                          launch('https://instagram.com/kickoffacademypkk?igshid=MzRlODBiNWFlZA==');
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Lato',
                        ),
                        children: [
                          TextSpan(
                            text: 'Develop by ',
                          ),
                          TextSpan(
                            text: 'srptechs.com',
                            style: TextStyle(fontWeight: FontWeight.bold,
                              color: Color(0xff2e2d77),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch('https://srptechs.com/');
                              },
                          ),
                          TextSpan(
                            text: ', All Rights Reserved.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

            ],
          ),
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  Content({
    required this.clr,
    required this.content,
    required this.img,
    required this.headcolor,
    required this.heading,
 
  }) ;

  String  content;
  String heading;
  String img;
  Color headcolor;
  Color clr;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
 
      child:   Container(
        height: MediaQuery.of(context).size.height*1,
        child: Stack(
          children: [
            BackdropFilter(filter: ImageFilter.blur(sigmaX:0, sigmaY: 0),
              child: Center(child: Image.asset(
                img,
                fit: BoxFit.cover, // Make sure the image covers the whole screen
                width: double.infinity,
                height: double.infinity,
              ),),),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
 
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                      ),
                      child:FadeAnimation(1.5, Text(
                        heading,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: headcolor,
                            fontSize: 24.0),
                        // style: TextStyle(
                        //     fontWeight: FontWeight.bold,

                        //     color: Color.fromARGB(255, 124, 20, 20)),
 
                      ), ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    color: Color(0x86000000),
                    child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        child:FadeAnimation(1.5, Text( content,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            height: 2,
                            color: Colors.white,
                          ),
 
                        ),),
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

 

class Content1 extends StatelessWidget {
  Content1({
    required this.clr,
    required this.content,
    required this.img,
    required this.headcolor,
 
    required this.heading,});

  String  content;
  String heading;
  String img;
  Color headcolor;
  Color clr;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
 
      child:   Container(
        height: MediaQuery.of(context).size.height*1,
        child: Stack(
          children: [
            BackdropFilter(filter: ImageFilter.blur(sigmaX:0, sigmaY: 0),
              child: Center(child: Image.asset(
                img,
                fit: BoxFit.cover, // Make sure the image covers the whole screen
                width: double.infinity,
                height: double.infinity,
              ),),),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
 
                    child:FadeAnimation(1.5, Text(
                      heading,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: headcolor,
                          fontSize: 24.0),
                    ), ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    color: Color(0x86000000),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
 
                      child:FadeAnimation(1.5, Text( content,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          height: 2,
                          color: Colors.white,
                        ),
                      ),),
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
