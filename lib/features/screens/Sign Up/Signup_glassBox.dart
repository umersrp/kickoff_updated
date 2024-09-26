import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../animation/FadeAnimation.dart';


final _borderRadius = BorderRadius.circular(20);



class Signup_glassBox extends StatelessWidget {
  late String _name,_email;

  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  @override

  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: _borderRadius,
        child: Container(
            width: 350,
            height: 520,
            child: Stack(
                children: [
                  //blur effect
                  BackdropFilter(filter: ImageFilter.blur(
                    sigmaX: 15,
                    sigmaY: 15,
                  ),
                    child: Container(),
                  ),SingleChildScrollView(
                    child:
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      borderRadius: _borderRadius,
                      gradient: LinearGradient(begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.grey.withOpacity(0.4),
                          Colors.grey.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                  ),

                  Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            FadeAnimation(1, Text("Sign Up", style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),)),
                            SizedBox(height: 5,),
                            FadeAnimation(1.2,
                                Text("Create Your Account, Its Free", style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white
                                ),)),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: SingleChildScrollView(child:
                          Column(
                            children: <Widget>[
                              FadeAnimation(1.2, makefirstname(label: "")),
                              FadeAnimation(1.2, makeEmail(label: "")),
                              FadeAnimation(1.2, makeCountry(label: "")),
                              FadeAnimation(1.3, makePassword(label: "", obscureText: true)),
                              FadeAnimation(1.4, makeConfirmPassword(label: "", obscureText: true)),
                            ],
                          ),
                          ),
                        ),

                      ],
                    ),
                  ),

                ]

            )
        )
    );
  }


  Widget makefirstname({label, obscureText = false,BuildContext? context}) {
    final _formKey = GlobalKey<FormState>();
    late String _name;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            obscureText: obscureText,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'First name',
              labelStyle: GoogleFonts.poppins(color: Colors.white),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter name";
              }
              return null;
            },
            onSaved: (name) {
              _name = name!;
            },
          ),
          Container(
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              elevation: 5.0,
              minWidth: 200.0,
              height: 55,
              color: Colors.red,
              child: Text(
                'Register',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (_name == null || _name.isEmpty) {
                    ScaffoldMessenger.of(context!).showSnackBar(
                      SnackBar(
                        content: Text('Please Enter name'),
                      ),
                    );
                  } else {
                    // Registration logic
                    // Here is an example of what the registration logic might look like:
                    _formKey.currentState?.save();
                    print('Registration successful for $_name');
                    ScaffoldMessenger.of(context!).showSnackBar(
                      SnackBar(
                        content: Text('Registration successful for $_name'),
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget makeEmail({label, obscureText = false}) {
  return Column(
    children: <Widget>[
      Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.white
      ),),
      TextField(style: TextStyle(color: Colors.white),
        obscureText: obscureText,
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
      ),

    ],
  );
}
Widget makeCountry({label, obscureText = false}) {
  return Column(
    children: <Widget>[
      Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.white
      ),),
      TextField(style: TextStyle(color: Colors.white),
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          labelText: 'Country',
          labelStyle: GoogleFonts.poppins(color: Colors.white),
        ),
      ),

    ],
  );
}


Widget makePassword({label, obscureText = false}) {
  return SingleChildScrollView( child:
  Form(
    child: Column(
      children: <Widget>[
        Text(label, style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.white
        ),),

        TextField(style: TextStyle(color: Colors.white),
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: 'Password',
            labelStyle: GoogleFonts.poppins(color: Colors.white),
          ),
        ),

      ],
    ),
  ),
  );
}
Widget makeConfirmPassword({label, obscureText = false}) {
  return SingleChildScrollView( child:
  Column(
    children: <Widget>[
      Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.white
      ),),

      TextField(style: TextStyle(color: Colors.white),
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          labelText: 'Confirm Password',
          labelStyle: GoogleFonts.poppins(color: Colors.white),
        ),
      ),

    ],
  ),
  );
}


}
