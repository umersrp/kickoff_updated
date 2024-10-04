import 'package:appkickoff/features/screens/Sign%20Up/signup.dart';
import 'package:appkickoff/features/screens/bookandplay/login/loginbook&play.dart';
import 'package:flutter/material.dart';
import '../../../utils/constant/colors.dart';
import '../../../utils/image_string/image_strings.dart';
import '../Login/BookVenueLogin.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/kickoff_reg.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  height: 150,
                  width: 210,
                  fit: BoxFit.contain,
                  image: AssetImage(
                    MyImages.AppLogo,
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 250,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Bookvenuelogin()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Register To Book Venue',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text('OR',style: TextStyle(color: Colors.white,fontSize: 14),),
                const SizedBox(height: 10),

                SizedBox(
                  width: 250,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Register In Our Academy',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(height: 30,),

                TextButton(onPressed: () {

                },
                child: Text('Register As A Vendor',style: TextStyle(color: Colors.white,fontSize: 15),)),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
