


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff2e2d77),
      elevation: 0.0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "LETS KICK OFF",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          SizedBox(width: 8.0),
          Image.asset(
            "assets/appbar.gif",
            width: 90.0,
            height: 50.0,
          ),
        ],
      ),
      actions: [],
      iconTheme: IconThemeData(color: Colors.white),
    );
  }
}
