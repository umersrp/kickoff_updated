import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../utils/constant/colors.dart';
import '../../../../utils/global_function/Globalfunction.dart';
import '../../../../utils/image_string/image_strings.dart';
import '../../Sign Up/signup.dart';
import 'login_form.dart';
import 'login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop(context),
      child: Scaffold(
          extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(MyImages.backgroundimage),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // Logo and Text
              Positioned(
                top: 70,
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
                      const SizedBox(height: 16.0),
                      Text(
                        "'Kickstart Your Football Journey!'",
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.4),
                    Container(
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
                          LoginHeader(),
                          SignupPage(),
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
