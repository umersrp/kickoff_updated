// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../animation/FadeAnimation.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import '../features/screens/Parent View/Parent_dashboard.dart';
// import '../features/screens/Parent View/parent_homepage.dart';
// import '../features/screens/Sign Up/signup.dart';
//
//
// class LoginPage1 extends StatefulWidget {
//   const LoginPage1();
//
//   @override
//   State<LoginPage1> createState() => _LoginPage1State();
// }
//
// class _LoginPage1State extends State<LoginPage1> {
//   bool _isChecked = false;
//   SharedPreferences? _prefs;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadPreferences();
//     initializeSharedPreferences();
//   }
//   Future<void> _loadPreferences() async {
//     try {
//       _prefs = await SharedPreferences.getInstance();
//       bool rememberMe = _prefs?.getBool('rememberMe') ?? false;
//
//       setState(() {
//         _isChecked = rememberMe;
//         if (rememberMe) {
//           _email.text = _prefs?.getString('email') ?? '';
//           _password.text = _prefs?.getString('password') ?? '';
//         }
//       });
//     } catch (e) {
//       // Handle any errors that might occur during SharedPreferences initialization
//       print('Error initializing SharedPreferences: $e');
//     }
//   }
//
//   Future<void> _handleRememberMe(bool value) async {
//     setState(() {
//       _isChecked = value;
//     });
//
//     if (value) {
//       await _prefs?.setString('email', _email.text);
//       await _prefs?.setString('password', _password.text);
//     } else {
//       await _prefs?.remove('email');
//       await _prefs?.remove('password');
//     }
//     await _prefs?.setBool('rememberMe', value);
//   }
//
//
//   Future<void> initializeSharedPreferences() async {
//     _prefs = await SharedPreferences.getInstance();
//     bool rememberMe = _prefs?.getBool('rememberMe') ?? false;
//     if (rememberMe) {
//       String savedEmail = _prefs?.getString('email') ?? '';
//       String savedPassword = _prefs?.getString('password') ?? '';
//       _email.text = savedEmail;
//       _password.text = savedPassword;
//       setState(() {
//         _isChecked = true;
//       });
//     }
//   }
//
//   bool err= false;
//   String errmesg= '';
//   bool isLoading = false; // Add this variable to track loading state
//
//   // Future<User?> loginUsingEmailPassword({
//   //   required String email,
//   //   required String password,
//   //   required BuildContext context,
//   // }) async {
//   //   FirebaseAuth auth = FirebaseAuth.instance;
//   //   User? user;
//   //   try {
//   //     UserCredential userCredential =
//   //     await auth.signInWithEmailAndPassword(email: email, password: password);
//   //     user = userCredential.user;
//   //   } on FirebaseAuthException catch (e) {
//   //     if (e.code == "user-not-found") {
//   //       setState(() {
//   //         err = true;
//   //         errmesg = 'No user found with that email.';
//   //       });
//   //       print("No user found for that email");
//   //     }
//   //   }
//   //   return user;
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       // bottomNavigationBar: GNav(rippleColor: Colors.red,
//       //   color: Colors.black,
//       //   tabBackgroundColor: Colors.red.withOpacity(0.1),
//       //   tabs: [
//       //     GButton(icon: Icons.home,text: 'Home',
//       //       onPressed: () {
//       //         Navigator.push(
//       //           context,
//       //           MaterialPageRoute(builder: (context) => Dashboard()),
//       //         );
//       //       },
//       //     ),
//       //     GButton(icon: Icons.schedule,text: 'Schedule',
//       //       onPressed: () {
//       //         Navigator.push(
//       //           context,
//       //           MaterialPageRoute(builder: (context) => schedule()),
//       //         );
//       //       },),
//       //     GButton(icon: Icons.person,text: 'Register',
//       //       onPressed: () {
//       //         Navigator.push(
//       //           context,
//       //           MaterialPageRoute(builder: (context) => SignupPage()),
//       //         );
//       //       },),
//       //   ],
//       // ),
//       body:SingleChildScrollView(
//         child:
//         SafeArea(
//           child: Container(
//             decoration: BoxDecoration(
//                 image: DecorationImage(image: AssetImage('assets/90.png'),
//                   fit: BoxFit.cover,)
//             ),
//             height: MediaQuery.of(context).size.height,
//             width: double.infinity,
//             child: Column(
//               children: <Widget>[
//                 Image(image: AssetImage('assets/kickofflogo.png'),width: 200,
//                   height: 200,),
//
//                 FadeAnimation(1.2,
//                     Column(
//                       children: [
//                         Container(
//                           height: 300,
//                           // decoration: BoxDecoration(
//                           //     image: DecorationImage(
//                           //       // image: AssetImage(''),
//                           //
//                           //     )
//                           // ),
//                           child:
//                           Center(
//                             child: Login_glassBox(),
//                           ),
//
//                         ),
//                       ],
//                     )),
//                 // Visibility(
//                 //   visible: err,
//                 //   child: Container(
//                 //     width: double.infinity,
//                 //     margin: EdgeInsets.only(
//                 //         left: 25,
//                 //         right: 25
//                 //     ),
//                 //     child: CsErrorContainer(
//                 //       errorMsg: errmesg,
//                 //     ),
//                 //   ),
//                 // ),
//                 // Row(
//                 //     mainAxisAlignment: MainAxisAlignment.start,
//                 //     children: [
//                 //       SizedBox(
//                 //           height: 24.0,
//                 //           width: 24.0,
//                 //           child: Theme(
//                 //             data: ThemeData(
//                 //                 unselectedWidgetColor: Colors.white // Your color
//                 //             ),
//                 //             child: Checkbox(
//                 //                 activeColor: Colors.white,
//                 //                 value: _isChecked,
//                 //                 onChanged: (bool val){
//                 //                   print("::::::::::::: $_isChecked");
//                 //                   if(_email.text.isNotEmpty && _password.text.isNotEmpty) {
//                 //                     setState(() {
//                 //                       _isChecked = val;
//                 //                       _handleRemeberme(_isChecked);
//                 //                     });
//                 //                   }
//                 //                 }),
//                 //           )),
//                 //       const SizedBox(width: 10.0),
//                 //       const Text("Remember Me",
//                 //         style: TextStyle(
//                 //             color: Color(0xff646464),
//                 //             fontSize: 12,
//                 //             fontFamily: 'Rubic'),
//                 //       ),
//                 //     ]),
//                 SizedBox(height: 10 ,),
//                 Container(
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 30.0,),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 24.0,
//                               width: 24.0,
//                               child: Theme(
//                                 data: ThemeData(
//                                   unselectedWidgetColor: Colors.white, // Your color
//                                 ),
//                                 child: Checkbox(
//                                   activeColor: Colors.blue,
//                                   value: _isChecked,
//                                   onChanged: (val) {
//                                     if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
//                                       setState(() {
//                                         _isChecked = val!;
//                                       });
//                                       _handleRememberMe(val!);
//                                     } else {
//                                       Fluttertoast.showToast(
//                                         msg: "Please fill in both email and password fields.",
//                                         toastLength: Toast.LENGTH_SHORT,
//                                         gravity: ToastGravity.BOTTOM,
//                                         backgroundColor: Colors.red,
//                                         textColor: Colors.white,
//                                       );
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 10.0),
//                             Text(
//                               "Remember Me",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold
//
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       MaterialButton(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                         ),
//                         elevation: 5.0,
//                         minWidth: 300.0,
//                         height: 55,
//                         color: Color(0xff2e2d77),
//                         child: isLoading
//                             ? CircularProgressIndicator()
//                             : Text(
//                           'Login',
//                           style: GoogleFonts.poppins(
//                             textStyle: TextStyle(fontSize: 20.0, color: Colors.white),
//                           ),
//                         ),
//                         onPressed: () async {
//                           if (isLoading) {
//                             return;
//                           }
//                           if (_email.text.isEmpty || _password.text.isEmpty) {
//                             setState(() {
//                               err = true;
//                               errmesg = 'Please enter your email and password.';
//                             });
//                             return;
//                           }
//                           setState(() {
//                             isLoading = true;
//                           });
//                           try{
//                             User? user = await loginUsingEmailPassword(
//                               email: _email.text,
//                               password: _password.text,
//                               context: context,
//                             );
//                             if (user != null) {
//                               String? email = user.email;
//                               if (email == 'asad@timetokickoff.com') {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => Parenthomepage()),
//                                 );
//                               } else {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => ParentDashboard()),
//                                 );
//                               }
//                             } else {
//                               setState(() {
//                                 err = true;
//                                 errmesg = 'Incorrect email or password. Please try again.';
//                               });
//                             }
//                           } on FirebaseAuthException catch (e) {
//                             String errorMessage = 'An error occurred. Please try again later.';
//                             if (e.code == 'user-not-found') {
//                               setState(() {
//                                 err = true;
//                                 errmesg = 'No user found with that email.';
//                               });
//                               errorMessage = 'No user found with that email.';
//                             } else if (e.code == 'wrong-password') {
//                               setState(() {
//                                 err = true;
//                                 errmesg = 'Incorrect password. Please try again.';
//                               });
//                               errorMessage = 'Incorrect password. Please try again.';
//                             } else if (e.code == 'invalid-email') {
//                               setState(() {
//                                 err = true;
//                                 errmesg = 'Please enter a valid email address.';
//                               });
//                               errorMessage = 'Please enter a valid email address.';
//                             }
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(errorMessage),
//                               ),
//                             );
//                           } catch (e) {
//                             setState(() {
//                               err = true;
//                               errmesg = 'An error occurred. Please try again later.';
//                             });
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('An error occurred. Please try again later.'),
//                               ),
//                             );
//                           } finally {
//                             setState(() {
//                               isLoading = false;
//                             }
//                             );
//                           }
//                         },
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         '-OR-',
//                         style: GoogleFonts.poppins(
//                           textStyle: TextStyle(fontSize: 14.0, color: Colors.black,fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       MaterialButton(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                         ),
//                         elevation: 5.0,
//                         minWidth: 300.0,
//                         height: 55,
//                         color: Color(0xff2e2d77),
//                         child: Text(
//                           'Register',
//                           style: GoogleFonts.poppins(
//                             textStyle: TextStyle(fontSize: 20.0, color: Colors.white),
//                           ),
//                         ),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => SignupPage()),
//                           );
//                         },
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// final _borderRadius = BorderRadius.circular(20);
//
// class Login_glassBox extends StatefulWidget {
//
//   @override
//   State<Login_glassBox> createState() => _Login_glassBoxState();
// }
//
// class _Login_glassBoxState extends State<Login_glassBox> {
//   // TextEditingController _password = TextEditingController();
//   // final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//   SharedPreferences? _prefs;
//   bool _isChecked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//         borderRadius: _borderRadius,
//         child: Container(
//             width: 350,
//             height: 320,
//             child: Stack(
//                 children: [
//                   // blur effect
//                   BackdropFilter(filter: ImageFilter.blur(
//                     sigmaX: 15,
//                     sigmaY: 15,
//                   ),
//                     child: Container(),
//                   ), SingleChildScrollView(
//                     child:
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey.withOpacity(0.2)),
//                         borderRadius: _borderRadius,
//                         gradient: LinearGradient(begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Colors.grey.withOpacity(0.4),
//                             Colors.grey.withOpacity(0.1),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Form(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         Column(
//                           children: <Widget>[
//                             FadeAnimation(
//                                 1, Text("WELCOME BACK", style: GoogleFonts.poppins(
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white
//                             ),)),
//                             SizedBox(height: 5,),
//                             FadeAnimation(1.2,
//                                 Text("Login to Continue",
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 18,
//                                       color: Colors.white
//                                   ),)),
//                           ],
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10),
//                           child: SingleChildScrollView(child:
//                           Column(
//                             children: <Widget>[
//                               FadeAnimation(1.2, makeEmail(label: "")),
//                               FadeAnimation(1.3, makePassword(label: "", obscureText: true)),
//                               SizedBox(height: 10,),
//                             ],
//                           ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ]
//             )
//         )
//     );
//   }
//
//
//   Widget makeEmail({label, obscureText = false}) {
//     return Column(
//       children: <Widget>[
//         Text(label, style: TextStyle(
//             fontSize: 15,
//             fontWeight: FontWeight.w400,
//             color: Colors.white
//         ),),
//         TextFormField(
//           style: TextStyle(color: Colors.white),
//           obscureText: obscureText,
//           decoration: InputDecoration(
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.white),
//             ),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.white),
//             ),
//             labelText: 'Email',
//             labelStyle: GoogleFonts.poppins(color: Colors.white),
//           ),
//           controller: _email,
//           validator: (value) {
//             if (value!.isEmpty) {
//               return 'Email is required';
//             }
//             return null;
//           },
//         ),
//       ],
//     );
//   }
//
//   bool _obscurePassword = true;
//   Widget makePassword({label, obscureText = false}) {
//     return SingleChildScrollView(
//       child: Column(
//         children: <Widget>[
//           Text(label, style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w400,
//               color: Colors.white
//           ),),
//           TextFormField(
//             style: TextStyle(color: Colors.white),
//             decoration: InputDecoration(
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//               labelText: 'Password',
//               labelStyle: GoogleFonts.poppins(color: Colors.white),
//               suffixIcon: IconButton(
//                 icon: Icon(
//                   _obscurePassword ?  Icons.visibility_off : Icons.visibility ,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {setState(() {
//                   _obscurePassword = !_obscurePassword;
//                 });
//                 },
//               ),
//             ),
//             obscureText: _obscurePassword,
//             controller: _password,
//           ),
//         ],
//       ),
//     );
//   }
//
// }
//
// TextEditingController _email= TextEditingController();
// TextEditingController _password= TextEditingController();
//
// // class CsErrorContainer extends StatelessWidget {
// //   const CsErrorContainer({
// //     this.errorMsg,
// //     Key key,
// //   }) : super(key: key);
// //   final String errorMsg;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //         width: 334,
// //         alignment: Alignment.center,
// //         padding: EdgeInsets.symmetric(horizontal: 11, vertical: 11),
// //         decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(2),
// //           color: Colors.red,
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             Icon(
// //               Icons.error,
// //               size: 16,
// //               color: Colors.white,
// //             ),
// //             const SizedBox(width: 10),
// //             Expanded(
// //               child: Text(
// //                 errorMsg,
// //                 textAlign: TextAlign.left,
// //                 maxLines: 2,
// //                 style:
// //                 GoogleFonts.poppins(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w500,),
// //                 // TextStyle(
// //                 //   letterSpacing: 1,
// //                 //   color: errorFontClr,
// //                 //   fontWeight: FontWeight.w500,
// //                 //   fontSize: 14.sp,
// //                 // ),
// //               ),
// //             ),
// //           ],
// //         )
// //     );
// //   }
// // }
//
