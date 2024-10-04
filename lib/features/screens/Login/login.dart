import 'dart:developer';

import 'package:appkickoff/vendor/authentication/views/login/vendor_login.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../personalization/login/controllers/login_controller.dart';
import '../../../utils/global_function/Globalfunction.dart';
import '../Sign Up/Register_page.dart';
import '../../../vendor/authentication/views/sign_up/signup.dart';
import '../bookandplay/login/loginbook&play.dart';

class LoginPage extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop(context),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF2E2D77),
                Color(0xFF49426D),
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/kickofflogo.png',
                        width: 200,
                        height: 50,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Welcome!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Login to your account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 30),
                    // Email Field
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Email',
                        labelStyle: GoogleFonts.poppins(color: Colors.white),
                      ),
                      controller: _loginController.usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null; // Return null if validation passes
                      },
                    ),
                    SizedBox(height: 20),

                    // Password Field with Obx for dynamic state
                    Obx(() => TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Password',
                        labelStyle: GoogleFonts.poppins(color: Colors.white),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _loginController.obscurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _loginController.obscurePassword.value = !_loginController.obscurePassword.value;
                          },
                        ),
                      ),
                      obscureText: _loginController.obscurePassword.value,
                      controller: _loginController.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null; // Return null if validation passes
                      },
                    )),
                    SizedBox(height: 10),

                    // Login Button with loading state
                    Obx(() => MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      elevation: 5.0,
                      minWidth: 300.0,
                      height: 55,
                      color: Color(0xff2e2d77),
                      child: _loginController.isLoading.value
                          ? CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                          : Text(
                        'Login',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                      onPressed: _loginController.isLoading.value
                          ? null // Disable button while loading
                          : () {
                        if (_formKey.currentState!.validate()) {
                          _loginController.loginUser(
                            context,
                            _loginController.usernameController.text,
                            _loginController.passwordController.text,
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content:
                                Text('All fields are required.'),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    )),

                    SizedBox(height: 10),
                    Text(
                      '-OR-',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),

                    // Register Button
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      elevation: 5.0,
                      minWidth: 300.0,
                      height: 55,
                      color: Color(0xff2e2d77),
                      child: Text(
                        'Registration',
                        style: GoogleFonts.poppins(
                          textStyle:
                          TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
