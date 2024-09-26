// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Email Replacement Demo',
//       home: EmailReplacementScreen(),
//     );
//   }
// }
//
// class EmailReplacementScreen extends StatelessWidget {
//   void replaceEmailAddress(String oldEmail, String newEmail) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//
//     try {
//       User? currentUser = auth.currentUser;
//
//       if (currentUser != null && currentUser.email == oldEmail) {
//         await currentUser.updateEmail(newEmail);
//
//         print('Email address updated successfully');
//       } else {
//         print('User is not logged in or email does not match');
//       }
//     } catch (e) {
//       print('Error updating email: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Email Replacement'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             replaceEmailAddress('newemail@example.com', 'Asad@timetokickoff.com');
//           },
//           child: Text('Replace Email Address'),
//         ),
//       ),
//     );
//   }
// }
