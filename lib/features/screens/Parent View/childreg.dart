import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../animation/FadeAnimation.dart';
import 'parent_homepage.dart';


class ChildReg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/111.png',
                  height: 80,
                ),
                const Text(
                  'FAC',
                  style: TextStyle(fontSize: 20),
                ),

              ],
            ),
          ),

          ListTile(
            leading: const Icon(
              Icons.arrow_back_outlined,
            ),
            title: const Text(
              'Back',
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Parenthomepage()),
              );
            },
          ),
        ],
      ),
    ),

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        centerTitle: true,
        title:
        Text(
          "Registration",
          selectionColor: Colors.red,
        ),
        actions: [
        ],
      ),
      backgroundColor: Colors.white,
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
      body:
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/Magista.jpg'),
              fit: BoxFit.cover,)
        ),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Image(image: AssetImage('assets/1112.png'),width: 200,color: Colors.white,
              height: 200,),

            FadeAnimation(1.2,
                Container(
                  height: 500,
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //  // image: AssetImage(''),
                      //
                      // )
                  ),
                  child:
                  Center(
                    child: Login_glassBox(),
                  ),

                )),
            SizedBox(height: 10 ,),
            Container(child: MaterialButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
              elevation: 5.0,
              minWidth: 200.0,
              height: 55,
              color: Colors.black,
              child: Text('Register',
                style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16.0, color: Colors.white)),),
              onPressed: (){},
            )),
          ],

        ),

      ),

    );
  }
}
final _borderRadius = BorderRadius.circular(20);

class Login_glassBox extends StatelessWidget {
  late String _name, _email;

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
                                1, Text("Register Your Child", style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),)),
                            SizedBox(height: 5,),
                            FadeAnimation(1.2,
                                Text("",
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
                              FadeAnimation(1.2, makefirstname(label: "")),
                              FadeAnimation(1.2, makelastname(label: "")),
                              FadeAnimation(1.2, position(label: "")),
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
Widget makefirstname({label, obscureText = false}) {
  return Column(
    children: <Widget>[
      Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.white
      ),),

      TextFormField(style: TextStyle(color: Colors.white),
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

      ),

    ],
  );
}
Widget makelastname({label, obscureText = false}) {
  return Column(
    children: <Widget>[
      Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.white
      ),),

      TextFormField(style: TextStyle(color: Colors.white),
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),

          labelText: 'Last name',
          labelStyle: GoogleFonts.poppins(color: Colors.white),
        ),

      ),

    ],
  );
}
Widget position({label, obscureText = false}) {
  return Column(
    children: <Widget>[
      Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.white
      ),),

      TextFormField(style: TextStyle(color: Colors.white),
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),

          labelText: 'Position',
          labelStyle: GoogleFonts.poppins(color: Colors.white),
        ),

      ),

    ],
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



Widget makePassword({label, obscureText = false}) {
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
          labelText: 'Password',
          labelStyle: GoogleFonts.poppins(color: Colors.white),
        ),
      ),

    ],
  ),
  );
}


