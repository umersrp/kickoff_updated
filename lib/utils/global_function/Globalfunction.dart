import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



Future<bool> showExitPopup(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Exit App'),
      content: Text('Do you want to exit the app?'),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('No'),
        ),
        ElevatedButton(
          onPressed: () => SystemNavigator.pop(),
          child: Text('Yes'),
        ),
      ],
    ),
  ) ?? false;
}

Future<bool> Function() onWillPop(BuildContext context) {
  return () async {
    return await showExitPopup(context);
  };
}