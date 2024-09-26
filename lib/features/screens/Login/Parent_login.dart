import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../animation/FadeAnimation.dart';
import '../Parent View/Parent_dashboard.dart';
bool _isLoading = false;

class ParentLoginPage extends StatefulWidget {
   ParentLoginPage() ;

  @override
  State<ParentLoginPage> createState() => _ParentLoginPageState();
}

class _ParentLoginPageState extends State<ParentLoginPage> {

  bool err=false;
  String errmesg='';

  Future<User?> loginUsingEmailPassword(
      { required String email,
        required String password,
        required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword
        (email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if(e.code =="user-not-found"){
        setState(() {
          err=true;
          errmesg='No user found with that email.';
        });
        print("No user found for that email");
      }
    }
    return user;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // bottomNavigationBar: GNav(rippleColor: Colors.red,
      //   color: Colors.black,
      //   tabBackgroundColor: Colors.red.withOpacity(0.1),
      //   tabs: [
      //     GButton(icon: Icons.home,text: 'Home',
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => Dashboard()),
      //         );
      //       },
      //     ),
      //     GButton(icon: Icons.schedule,text: 'Schedule',
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => schedule()),
      //         );
      //       },),
      //     GButton(icon: Icons.person,text: 'Register',
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => SignupPage()),
      //         );
      //       },),
      //   ],
      // ),
      body:SafeArea(
        child:
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/w.jpg'),
                fit: BoxFit.cover,)
          ),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Image(image: AssetImage('assets/1112.png'),width: 200,color: Colors.black,
                height: 200,),

              FadeAnimation(1.2,
                  Container(
                    height: 300,
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //       // image: AssetImage(''),
                    //
                    //     )
                    // ),
                    child:
                    Center(
                      child: Login_glassBox(),
                    ),

                  )),
              Visibility(
                visible: err,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                      left: 3,
                      right: 25
                  ),
                  child: CsErrorContainer(
                    errorMsg: errmesg,
                  ),
                ),
              ),
              SizedBox(height: 10 ,),
              Container(child:

              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                elevation: 5.0,
                minWidth: 200.0,
                height: 55,
                color: Colors.black,
                child: Text(
                  'Login',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
                onPressed: () async {
                  try {
                    User? user = await loginUsingEmailPassword(
                      email: _email.text,
                      password: _password.text,
                      context: context,
                    );
                    print(user);
                    if (user != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ParentDashboard()),
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    String errorMessage = 'An error occurred. Please try again later.';
                    if (e.code == 'user-not-found') {
                      setState(() {
                        err=true;
                        errmesg='No user found with that email.';
                      });
                      errorMessage = 'No user found with that email.';
                    } else if (e.code == 'wrong-password') {
                      errorMessage = 'Wrong password provided for that user.';
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage),
                      ),

                    );
                  }

                },

              )





              ),
            ],

          ),

        ),
      ),
    );
  }
}

final _borderRadius = BorderRadius.circular(20);

class Login_glassBox extends StatelessWidget {

  // TextEditingController _password = TextEditingController();
  // TextEditingController _confirmpassword = TextEditingController();



  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: _borderRadius,
        child: Container(
            width: 350,
            height: 320,
            child: Stack(
                children: [
                  //blur effect
                  BackdropFilter(filter: ImageFilter.blur(
                    sigmaX: 15,
                    sigmaY: 15,
                  ),
                    child: Container(),
                  ), SingleChildScrollView(
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
                            FadeAnimation(
                                1, Text("Login To continue", style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),)),
                            SizedBox(height: 5,),
                            FadeAnimation(1.2,
                                Text("Welcome Back",
                                  style: GoogleFonts.poppins(
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

                              FadeAnimation(1.2, makeEmail(label: "")),
                              FadeAnimation(1.3, makePassword(label: "", obscureText: true)),
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
}

TextEditingController _email= TextEditingController();
TextEditingController _password= TextEditingController();



Widget makeEmail({label, obscureText = false}) {
  return Column(
    children: <Widget>[
      Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.white
      ),),
      TextField(
        style: TextStyle(color: Colors.white),
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
        controller: _email,
      ),

    ],
  );
}



Widget makePassword({label, obscureText = false}) {
  return SingleChildScrollView( child:
  Column(
    children: <Widget>[
      Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.white
      ),),

      TextField(
        style: TextStyle(color: Colors.white),
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
        controller: _password,
      ),

    ],
  ),
  );
}

class CsErrorContainer extends StatelessWidget {
  const CsErrorContainer({
    required this.errorMsg,
  });
  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 334,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 11, vertical: 11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.red,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 16,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                errorMsg,
                textAlign: TextAlign.left,
                maxLines: 2,
                style:
                GoogleFonts.poppins(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,),


                // TextStyle(
                //   letterSpacing: 1,
                //   color: errorFontClr,
                //   fontWeight: FontWeight.w500,
                //   fontSize: 14.sp,
                // ),
              ),
            ),
          ],
        )
    );

  }
}

