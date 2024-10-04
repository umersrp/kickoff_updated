import 'dart:io';
import 'package:appkickoff/personalization/service/controller/aboutUs_controller.dart';
import 'package:appkickoff/vendor/utils/constants/size_utils.dart';
import 'package:appkickoff/vendor/vendor_features/views/home/home.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/screens/Sign Up/signup.dart';
import 'vendor/authentication/views/login/vendor_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: 'AIzaSyDUKDGiO8QyBt-x3PNzOhdR7MX8GblEk-w',
          appId: '1:456045154554:android:4419bf10cf944b88dc7943',
          messagingSenderId: '456045154554',
          projectId: 'fac-academy',
        ))
      : await Firebase.initializeApp();
  Get.put(AuthService()); // Initialize AuthService

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: ScreenMain(),
          // home: VendorHomeScreen(),
        );
      },
    );
  }
}
