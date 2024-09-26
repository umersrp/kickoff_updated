import 'package:appkickoff/features/screens/Sign%20Up/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constant/colors.dart';
import '../../../utils/global_function/Globalfunction.dart';
import '../../../utils/image_string/image_strings.dart';
import 'Booktextfield.dart';

class Bookvenuelogin extends StatelessWidget {
  const Bookvenuelogin({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop(context),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: MyColors.primary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ScreenMain()),
               );
              },
          ),
        ),
        body: Container(
          color: MyColors.primary,
          child: Stack(
            children: [
              // Logo and Text
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Image(
                        height: 150,
                        width: 210,
                        fit: BoxFit.contain,
                        image: AssetImage(
                          MyImages.AppLogo,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        "'Login'",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          textStyle: const TextStyle(fontSize: 20),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "'Book Your Favorite Venues To Play'",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          textStyle: const TextStyle(fontSize: 15),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Form and Container
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.4),
                    Container(
                      height: 530,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(24.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          // BookLoginHeader(),
                          Booktextfield(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
