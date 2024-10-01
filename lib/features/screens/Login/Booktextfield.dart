import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../personalization/controllers/booking_user_controller.dart';
import '../../../personalization/models/booking_model.dart';
import '../../../utils/constant/colors.dart';

class Booktextfield extends StatefulWidget {
  const Booktextfield({super.key});

  @override
  State<Booktextfield> createState() => _BooktextfieldState();
}

final TextEditingController nameController = TextEditingController();
final TextEditingController lastController = TextEditingController();

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final BookingSignupController bookingsignupController = Get.put(BookingSignupController());

bool _obscurePassword = true;


class _BooktextfieldState extends State<Booktextfield> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Email label and input field.
            SizedBox(height: 25,),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: const Icon(FontAwesomeIcons.signature,color: MyColors.primary,),
                hintText: 'First Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
            SizedBox(height: 25,),
            TextFormField(
              controller: lastController,
              decoration: InputDecoration(
                prefixIcon: const Icon(FontAwesomeIcons.person,color: MyColors.primary,),
                hintText: 'Last Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Last name';
                }
                return null;
              },
            ),


            SizedBox(height: 10,),

            TextFormField(
              controller: emailController,  // Link the controller to TextField
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email,color: MyColors.primary,),
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Email';
                }
                return null;
              },
            ),
            SizedBox(height: 10,),

            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  FontAwesomeIcons.phone,
                  color: MyColors.primary,
                ),
                hintText: 'Phone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.number, // To show numeric keyboard
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Allow only digits
                LengthLimitingTextInputFormatter(11), // Limit input to 11 digits
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                } else if (value.length != 11) {
                  return 'Phone number must be 11 digits';
                }
                return null;
              },
            ),



            SizedBox(height: 10,),

            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock,color: MyColors.primary,),
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.blue.shade300, width: 2.0),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Date Of Birth';
                }
                return null;
              },
              obscureText: _obscurePassword,
            ),



            const SizedBox(height: 16.0),

            /// Sign In button.
            SizedBox(
              width: double.infinity,
              child: Obx(() {
                return bookingsignupController.isLoading.value
                    ? Center(
                  child: Container(
                    width: 24.0,  // Adjust width as needed
                    height: 24.0, // Adjust height as needed
                    child: CircularProgressIndicator(),
                  ),
                )
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: MyColors.primary,
                  ),
                  onPressed: () async {
                    // Validation function
                    void showValidationDialog(String title, String content) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(title),
                            content: Text(content),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }

                    // Validate first name
                    if (nameController == null || nameController.text.trim().isEmpty) {
                      showValidationDialog('Input Required', 'Please enter your First Name');
                      return;
                    }

                    // Validate last name
                    if (lastController == null || lastController.text.trim().isEmpty) {
                      showValidationDialog('Input Required', 'Please enter your Last Name');
                      return;
                    }

                    // Validate email
                    if (emailController == null || emailController.text.trim().isEmpty) {
                      showValidationDialog('Input Required', 'Please enter your email address');
                      return;
                    } else if (emailController.text.trim().contains(RegExp(r'[A-Z]'))) {
                      showValidationDialog('Invalid Input', 'Email should not contain uppercase letters');
                      return;
                    } else if (!emailController.text.trim().contains('@') || !emailController.text.trim().contains('.')) {
                      showValidationDialog('Invalid Format', 'Email format is invalid');
                      return;
                    }

                    // Validate phone number
                    if (phoneController == null || phoneController.text.trim().isEmpty) {
                      showValidationDialog('Input Required', 'Please enter your Phone Number');
                      return;
                    }

                    // Validate password
                    if (passwordController == null || passwordController.text.trim().isEmpty) {
                      showValidationDialog('Input Required', 'Please enter your Password');
                      return;
                    }

                    // Save user data to SharedPreferences
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setString('firstName', nameController.text);
                    await prefs.setString('lastName', lastController.text);
                    await prefs.setString('email', emailController.text);
                    await prefs.setString('phone', phoneController.text);

                    final bookuserModel = BookUserModel(
                      name: nameController.text,
                      email: emailController.text,
                      lastname: lastController.text,
                      password: passwordController.text,
                      regestrationtype: 'bookandplay',
                      phone: phoneController.text,
                    );

                    // Call the signup method with the user model
                    bookingsignupController.BookingsignupUser(bookuserModel, context);
                  },

                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
