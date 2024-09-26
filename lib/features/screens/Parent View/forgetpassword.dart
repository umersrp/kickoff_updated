  import 'package:flutter/material.dart';
  import 'package:firebase_auth/firebase_auth.dart';

  class ResetScreen extends StatefulWidget {
    @override
    _ResetScreenState createState() => _ResetScreenState();
  }

  class _ResetScreenState extends State<ResetScreen> {
    String? _email;
    final auth = FirebaseAuth.instance;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Forgot Password',style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.indigo, // Customize the app bar color
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Forgot your password?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Enter your email below to receive a password reset link.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value.trim();
                  });
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_email != null && _email!.isNotEmpty) {
                    try {
                      await auth.sendPasswordResetEmail(email: _email!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Password reset email sent!'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      Navigator.of(context).pop();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error sending reset email. Please check your email.'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter a valid email.'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                child: Text('Send Request'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.indigo, // Set the text color

                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
