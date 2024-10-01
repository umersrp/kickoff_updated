import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'dart:convert';
import '../../../features/screens/Sign Up/signup.dart';
import '../models/booking_model.dart';
import '../models/user_model.dart';
import 'aboutUs_controller.dart';

class BookingSignupController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void sendVerificationEmail(String recipientEmail, BuildContext context) async {
    try {
      // Your email content
      final String emailContent = """
      
      Dear Parents/Player,

      Thank you for submitting your registration form for sessions at Kick Off Academy. We are delighted to inform you that we have received your form.

      We are excited that you are interested in joining us and we would like to invite you to start your classes from the first session.

      To complete your registration process, we kindly request you to submit your monthly fee. You can transfer the amount to the following account:

      Kick Off Academy
      Account Number: 6-11-12-20311-714-213510
      Bank: Habib Metro

      Once you have transferred the fees, please send us the payment slip for our records. Your registration will be confirmed as soon as we receive the payment.

      If you are a Creek Club member, please sign the club's bill-book between 5 PM - 7 PM (Mon-Sat) and email us the Creek Club card copy on returned email. If you are a guest member, please transfer or deposit the fee immediately to confirm your slot.

      We also encourage you to visit our website www.timetokickoff.com to find more details about our sessions.

      Additionally, you can order Kick Off official kit through the following link: https://kheloaaj.com/shop/

      For any further details, please follow us on
      https://linktr.ee/kickoffacademy

      We are thrilled to have you on board, and we look forward to seeing you soon.

      Best Regards,
      Team Kick Off
    """;

      final smtpServer = gmail('kickoffacad@gmail.com', 'ybwj krlx iunz kzqw');

      final message = Message()
        ..from = Address('kickoffacad@gmail.com', 'Kick Off')
        ..recipients.add(recipientEmail)
        ..subject = 'Kick Off Academy Registration Confirmation'
        ..text = emailContent;

      await send(message, smtpServer);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verification email sent. Please check your inbox.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending verification email: $e'),
        ),
      );
    }
  }

  Future<void> BookingsignupUser(BookUserModel bookuserModel, BuildContext context) async {
    isLoading(true);

    try {
      final response = await http.post(
        Uri.parse('${baseUrl}/user/signup'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(bookuserModel.toJson()),
      );

      if (response.statusCode == 201) {
        print('User posted successfully: ${response.body}');

        // Show the success dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Registration', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(
                      'Thanks for registering with us. You Can Now Procced To Book The Venues',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            sendVerificationEmail(bookuserModel.email, context);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => ScreenMain()),
                                  (route) => false,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        handleError('Failed to post user: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: Something went wrong: $e'),
        ),
      );
    } finally {
      isLoading(false);
    }
  }

  void handleError(String error) {
    Get.snackbar(
      'Error',
      error,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }

}
