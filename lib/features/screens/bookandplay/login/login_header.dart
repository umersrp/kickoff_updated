import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8.0),
        Text(
          'Registration',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 20
            ),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Create Your Account',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 14
            ),
          ),        ),
      ],
    );
  }
}
class BookLoginHeader extends StatelessWidget {
  const BookLoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8.0),
        Text(
          'Login',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 20
            ),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Create Your Account',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 14
            ),
          ),        ),
      ],
    );
  }
}
