// import 'dart:ui';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:draggable_scrollbar/draggable_scrollbar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:FAC/animation/FadeAnimation.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'alpha.dart';
// import 'homepage.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';
//
//
// final _borderRadius = BorderRadius.circular(20);
//
// class SignupPage extends StatefulWidget {
//   final VoidCallback onRegisterPressed;
//   SignupPage({key, this.onRegisterPressed});
//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }
// class _SignupPageState extends State<SignupPage> {
//
//
//
//   bool isLoggedIn = false;
//   List<ShiftItem> shifts = [];
//   String selectedShiftValue;
//
//
//
//   Future<bool> checkForDuplicateEmail() async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('Academy')
//         .where('email', isEqualTo: _email.text.trim())
//         .limit(1)
//         .get();
//
//     return querySnapshot.docs.isNotEmpty;
//   }
//
//   final _formKey = GlobalKey<FormState>();
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   TextEditingController _name= TextEditingController();
//
//   TextEditingController child_name= TextEditingController();
//
//   TextEditingController _email= TextEditingController();
//
//   TextEditingController _password= TextEditingController();
//
//   TextEditingController _address= TextEditingController();
//
//   TextEditingController _confrom_password= TextEditingController();
//
//   TextEditingController _memberShipno= TextEditingController();
//   TextEditingController _phoneNumber= TextEditingController();
//   TextEditingController _dateOfBirth= TextEditingController();
//
//
//
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;
//   TextEditingController _dateController = TextEditingController();
//   bool _isMale = true;
//
//   bool _isClubMember = true;
//
//   bool _isCardCopy = true;
//
//   String _fullName;
//   String name;
//   String _selectedGroup;
//   String _selectedlocation;
//   String child_namee;
//
//
//   final user = FirebaseAuth.instance.currentUser;
//   CollectionReference academy = FirebaseFirestore.instance.collection('Academy');
//   bool isRegistering = false;
//
//
//
//   void _submitAdmission(String email) {
//
//     DateTime now=DateTime.now();
//
//     print("???????????? ${_phoneNumber}");
//     print('Full Name: ${_name.text}');
//     print('Phone Number: ${_phoneNumber.text}');
//     print('Address: ${_address.text}');
//     print('Date of Birth: ${_dateOfBirth.text}');
//     print('Gender: ${_isMale ? 'Male' : 'Female'}');
//     // print('Programs Interested In: $_programsInterestedIn');
//     print('Shifts: $selectedShiftValue');
//     print('memembership: ${_memberShipno.text}');
//     print('clubmember: ${_isClubMember}');
//     print('cardcopy: ${_isCardCopy}');
//     print('email: ${email}');
//     print('child_name: ${child_name.text}');
//
//     academy
//         .doc(email)
//         .collection("Admission")
//         .doc()
//         .set({
//       "name": _name.text.toString(),
//       "child_name": child_name.text.toString(),
//       "email": email,
//       "phoneNumber": _phoneNumber.text,
//       "address": _address.text.toString(),
//       "dateOfBirth": _dateOfBirth.text,
//       "isMale": _isMale,
//       "status": false,
//       "_memberShipno": _memberShipno.text.toString(),
//       "_isClubMember": _isClubMember,
//       "_isCardCopy":_isCardCopy,
//       'selectedShift': selectedShiftValue, // Save selected shift value
//       // 'name': name,
//     }).then((value) {
//       academy
//           .doc(email)
//           .collection('Admission')
//           .get()
//           .then((value) {
//         value.docs.forEach((element) {
//           String nom;
//           nom = element.get('name');
//
//           if (nom == _name.text.toString()) {
//             print("object:::::::::::: $nom");
//             academy
//                 .doc(email)
//                 .collection('Admission')
//                 .doc(element.id).collection('Attendance').doc('${2011}-${12}-${20}').set({"date":'${now.year}-${now.month}-${now.day}',"present":false,}).then((valu) {
//               print("Updated status in Firestore");
//             });
//           }
//         });
//       });
//     }).then((value) {
//       showDialog(
//         context: context,
//         barrierDismissible: false, // Prevents dismissing the dialog by clicking outside
//         builder: (BuildContext context) {
//           return Dialog(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Registration'),
//                   SizedBox(height: 8),
//                   Text('Thanks for registering with us. You can proceed to pay after receiving your slot confirmation by email.'),
//                   SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         child: Text('Ok'),
//                         onPressed: () {
//                           // _register();
//                           Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(builder: (context) => ScreenMain()),
//                                 (route) => false,
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     });
//
//   }
//
//
//   Future<void> _register() async {
//     {
//       // Validate form fields
//       if (_formKey.currentState.validate()) {
//         QuerySnapshot emailSnapshot = await FirebaseFirestore.instance
//             .collection('Academy')
//             .where('email', isEqualTo: _email.text.trim())
//             .limit(1)
//             .get();
//
//         if (emailSnapshot.docs.isNotEmpty) {
//           // Name or email already exists
//           // Handle the case when email already exists (without showing the snack bar)
//         } else {
//           // Create Firebase user
//           UserCredential result = await _auth.createUserWithEmailAndPassword(
//             email: _email.text.trim(),
//             password: _password.text.trim(),
//           );
//           User user = result.user;
//           // Add user data to Firestore
//           await FirebaseFirestore.instance.collection('Academy').doc(
//               user.email.toString()).set({
//             'name': _name.text.trim(),
//             'email': _email.text.trim(),
//             'address': _address.text.trim(),
//             'child_name': child_name.text.trim(),
//           });
//           _submitAdmission(_email.text.trim());
//         }
//       }
//     }
//
//   }
//
//   @override
//   bool isAlwaysShown= true;
//   ScrollController _controller = ScrollController();
//   final itemExtent = 100.0;
//
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(
//               image: DecorationImage(image: AssetImage('assets/91.jpg'),
//                 fit: BoxFit.cover,)
//           ),
//           height: MediaQuery.of(context).size.height,
//           width: double.infinity,
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 Image(image: AssetImage('assets/kickofflogo.png'),width: 200,
//                   height: size.height*0.1,),
//
//                 FadeAnimation(1.2,
//                   Container(
//                     height: 550,
//                     // decoration: BoxDecoration(
//                     //     image: DecorationImage(
//                     //       image: AssetImage(''),
//                     //
//                     //     )
//                     // ),
//                     child:
//                     ClipRRect(
//                         borderRadius: _borderRadius,
//                         child: Container(
//                             width: 380,
//                             height: 550,
//                             child: Stack(
//                                 children: [
//                                   //blur effect
//                                   BackdropFilter(
//                                     filter: ImageFilter.blur(
//                                       sigmaX: 15,
//                                       sigmaY: 15,
//                                     ),
//                                     child: Container(),
//                                   ),
//                                   SingleChildScrollView(
//                                     child:
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(color: Colors.grey.withOpacity(0.2)),
//                                         borderRadius: _borderRadius,
//                                         gradient: LinearGradient(begin: Alignment.topLeft,
//                                           end: Alignment.bottomRight,
//                                           colors: [
//                                             Colors.grey.withOpacity(0.4),
//                                             Colors.grey.withOpacity(0.1),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//
//                                   Container(
//                                     child: DraggableScrollbar.rrect(
//                                       child: ListView(
//                                           controller: _controller,
//                                           children: [
//                                             Center(
//                                               child: Form(
//                                                 child: Column(
//                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                   children: <Widget>[
//                                                     Column(
//                                                       children: <Widget>[
//                                                         SizedBox(height: size.height*0.035,),
//                                                         FadeAnimation(1, Text("Admission", style: GoogleFonts.poppins(
//                                                             fontSize: 30,
//                                                             fontWeight: FontWeight.bold,
//                                                             color: Colors.white
//                                                         ),)),
//                                                         SizedBox(height: 5,),
//                                                         FadeAnimation(1.2,
//                                                             Text("Create Your Account, Its Free", style: GoogleFonts.poppins(
//                                                                 fontSize: 15,
//                                                                 color: Colors.white
//                                                             ),)),
//                                                       ],
//                                                     ),
//                                                     Padding(
//                                                       padding: EdgeInsets.symmetric(horizontal: 10),
//                                                       child: SingleChildScrollView(child:
//                                                       Column(
//                                                         children: <Widget>[
//
//                                                           Padding(
//                                                             padding: EdgeInsets.symmetric(horizontal: 10),
//                                                             child: SingleChildScrollView(child:
//                                                             Column(
//                                                               children: <Widget>[
//                                                                 Form(
//                                                                   key: _formKey,
//                                                                   child: Column(
//                                                                     children: <Widget>[
//                                                                       TextFormField(
//                                                                         style: TextStyle(color: Colors.white),
//                                                                         decoration: InputDecoration(
//                                                                           enabledBorder: UnderlineInputBorder(
//                                                                             borderSide: BorderSide(color: Colors.white),
//                                                                           ),
//                                                                           focusedBorder: UnderlineInputBorder(
//                                                                             borderSide: BorderSide(color: Colors.white),
//                                                                           ),
//                                                                           labelText: 'Parent Name',
//                                                                           labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                                                         ),
//                                                                         controller: _name,
//                                                                       ),
//                                                                       SizedBox(height: 20,),
//                                                                       TextFormField(
//                                                                         style: TextStyle(color: Colors.white),
//                                                                         decoration: InputDecoration(
//                                                                           enabledBorder: UnderlineInputBorder(
//                                                                             borderSide: BorderSide(color: Colors.white),
//                                                                           ),
//                                                                           focusedBorder: UnderlineInputBorder(
//                                                                             borderSide: BorderSide(color: Colors.white),
//                                                                           ),
//                                                                           labelText: 'Child Name',
//                                                                           labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                                                         ),
//                                                                         controller: child_name,
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                                 TextFormField(
//                                                                   style: TextStyle(color: Colors.white),
//                                                                   decoration: InputDecoration(
//                                                                     enabledBorder: UnderlineInputBorder(
//                                                                       borderSide: BorderSide(color: Colors.white),
//                                                                     ),
//                                                                     focusedBorder: UnderlineInputBorder(
//                                                                       borderSide: BorderSide(color: Colors.white),
//                                                                     ),
//                                                                     labelText: 'Email',
//                                                                     labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                                                   ),
//                                                                   controller: _email,
//                                                                   validator: (value) {
//                                                                     if (value.isNotEmpty) {
//                                                                       // Check if the first letter is uppercase
//                                                                       if (value[0] == value[0].toUpperCase()) {
//                                                                         return 'Please make the first letter lowercase';
//                                                                       }
//                                                                     }
//                                                                     return null; // Return null if there is no error
//                                                                   },
//                                                                 ),
//
//                                                                 SizedBox(height: 20,),
//                                                                 TextFormField(
//                                                                   style: TextStyle(color: Colors.white),
//                                                                   decoration: InputDecoration(
//                                                                     enabledBorder: UnderlineInputBorder(
//                                                                       borderSide: BorderSide(color: Colors.white),
//                                                                     ),
//                                                                     focusedBorder: UnderlineInputBorder(
//                                                                       borderSide: BorderSide(color: Colors.white),
//                                                                     ),
//                                                                     labelText: 'Address',
//                                                                     labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                                                   ),
//                                                                   controller: _address,
//                                                                 ),
//
//                                                                 SizedBox(height: 20,),
//                                                                 TextFormField(style: TextStyle(color: Colors.white),
//                                                                   keyboardType: TextInputType.phone,
//                                                                   decoration: InputDecoration(
//                                                                     enabledBorder: UnderlineInputBorder(
//                                                                       borderSide: BorderSide(color: Colors.white),
//                                                                     ),
//                                                                     focusedBorder: UnderlineInputBorder(
//                                                                       borderSide: BorderSide(color: Colors.white),
//                                                                     ),
//                                                                     labelText: 'Phone Number',
//                                                                     labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                                                   ),
//                                                                   inputFormatters: [
//                                                                     FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//                                                                   ],
//                                                                   validator: (value) {
//                                                                     if (value.isEmpty) {
//                                                                       return 'Please enter your phone number';
//                                                                     }
//                                                                     return null;
//                                                                   },
//                                                                   controller: _phoneNumber,
//                                                                 ),
//
//                                                                 SizedBox(height: 20,),
//                                                                 TextFormField(style: TextStyle(color: Colors.white),
//                                                                   controller: _dateOfBirth,
//                                                                   onTap: () async {
//                                                                     DateTime date = DateTime(1900);
//                                                                     FocusScope.of(context).requestFocus(new FocusNode());
//
//                                                                     date = await showDatePicker(
//                                                                       context: context,
//                                                                       initialDate: DateTime.now(),
//                                                                       firstDate: DateTime(1900),
//                                                                       lastDate: DateTime.now(),
//                                                                     );
//
//                                                                     _dateController.text = DateFormat('dd-MM-yyyy').format(date);
//                                                                     _dateOfBirth = _dateController;
//                                                                   },
//                                                                   decoration: InputDecoration(
//                                                                     enabledBorder: UnderlineInputBorder(
//                                                                       borderSide: BorderSide(color: Colors.white),
//                                                                     ),
//                                                                     focusedBorder: UnderlineInputBorder(
//                                                                       borderSide: BorderSide(color: Colors.white),
//                                                                     ),
//                                                                     labelText: 'Date of Birth',
//                                                                     labelStyle: GoogleFonts.poppins(color: Colors.white),
//
//                                                                     suffixIcon: Icon(Icons.calendar_today),
//                                                                   ),
//                                                                   validator: (value) {
//                                                                     if (value.isEmpty) {
//                                                                       return 'Please select your date of birth';
//                                                                     }
//                                                                     return null;
//                                                                   },
//
//                                                                 ),
//
//
//                                                                 SizedBox(height: 20,),
//
//                                                                 FutureBuilder<QuerySnapshot>(
//                                                                   future: FirebaseFirestore.instance
//                                                                       .collection('Academy')
//                                                                       .doc('taha@gmail.com')
//                                                                       .collection("Shifts")
//                                                                       .get(),
//                                                                   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                                                                     // if (snapshot.connectionState == ConnectionState.waiting) {
//                                                                     //   return CircularProgressIndicator();
//                                                                     // }
//                                                                     if (snapshot.hasData) {
//                                                                       shifts = snapshot.data.docs.map(
//                                                                             (doc) => ShiftItem(
//                                                                           startTime: doc.get('startTime'),
//                                                                           endTime: doc.get('endTime'),
//                                                                           position: doc.get('position'),
//                                                                         ),
//                                                                       ).toList();
//
//                                                                       if (shifts.isEmpty) {
//                                                                         return Text('No shifts available');
//                                                                       }
//
//                                                                       return DropdownButtonFormField<String>(
//                                                                         decoration: InputDecoration(
//                                                                           labelText: 'Select Shift',
//                                                                           labelStyle: TextStyle(color: Color(
//                                                                               0xffffffff)),
//                                                                           enabledBorder: UnderlineInputBorder(
//                                                                             borderSide: BorderSide(color: Color(
//                                                                                 0xffffffff)),
//                                                                           ),
//                                                                         ),
//                                                                         value: selectedShiftValue,
//                                                                         onChanged: (value) {
//                                                                           setState(() {
//                                                                             selectedShiftValue = value;
//                                                                           });
//                                                                         },
//                                                                         items: shifts.map((ShiftItem shift) {
//                                                                           return DropdownMenuItem<String>(
//                                                                             value: shift.position,
//                                                                             child: Text(
//                                                                               '${shift.startTime} - ${shift.position} - ${shift.endTime}',
//                                                                               style: TextStyle(color: Colors.black),
//                                                                             ),
//                                                                           );
//                                                                         }).toList(),
//                                                                         validator: (value) {
//                                                                           if (value == null || value.isEmpty) {
//                                                                             return 'Please select a shift';
//                                                                           }
//                                                                           return null;
//                                                                         },
//                                                                       );
//                                                                     }
//
//                                                                     if (snapshot.hasError) {
//                                                                       return Text('Error: ${snapshot.error}');
//                                                                     }
//
//                                                                     return Text('No shifts available');
//                                                                   },
//                                                                 ),
//
//                                                                 SizedBox(height: 20,),
//
//                                                                 DropdownButtonFormField<String>(
//                                                                   value: _selectedlocation,
//                                                                   onChanged: (String newValue) {
//                                                                     setState(() {
//                                                                       _selectedlocation = newValue;
//                                                                     });
//                                                                   },
//                                                                   items: <String>['DA Creek Club']
//                                                                       .map<DropdownMenuItem<String>>((String value) {
//                                                                     return DropdownMenuItem<String>(
//                                                                       value: value,
//                                                                       child: Text(value),
//                                                                     );
//                                                                   }).toList(),
//                                                                   style: TextStyle(color: Colors.black),
//                                                                   decoration: InputDecoration(
//                                                                     enabledBorder: UnderlineInputBorder(
//                                                                       borderSide: BorderSide(color: Colors.white),
//                                                                     ),
//                                                                     focusedBorder: UnderlineInputBorder(
//                                                                       borderSide: BorderSide(color: Colors.white),
//                                                                     ),
//                                                                     labelText: 'Location',
//                                                                     labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                                                   ),
//                                                                 ),
//
//                                                                 TextFormField(
//                                                                   style: TextStyle(color: Colors.white),
//                                                                   decoration: InputDecoration(
//                                                                     enabledBorder: UnderlineInputBorder(
//                                                                       borderSide: BorderSide(color: Colors.white),
//                                                                     ),
//                                                                     focusedBorder: UnderlineInputBorder(
//                                                                       borderSide: BorderSide(color: Colors.white),
//                                                                     ),
//                                                                     labelText: 'Password',
//                                                                     labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                                                     suffixIcon: IconButton(
//                                                                       icon: Icon(
//                                                                         _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                                                                         color: Colors.white,
//                                                                       ),
//                                                                       onPressed: () {
//                                                                         setState(() {
//                                                                           _obscurePassword = !_obscurePassword;
//                                                                         });
//                                                                       },
//                                                                     ),
//                                                                   ),
//                                                                   obscureText: _obscurePassword,
//                                                                   controller: _password,
//                                                                 ),
//
//                                                                 TextFormField(
//                                                                   style: TextStyle(color: Colors.white),
//                                                                   decoration: InputDecoration(
//                                                                     enabledBorder: UnderlineInputBorder(
//                                                                       borderSide: BorderSide(color: Colors.white),
//                                                                     ),
//                                                                     focusedBorder: UnderlineInputBorder(
//                                                                       borderSide: BorderSide(color: Colors.white),
//                                                                     ),
//                                                                     labelText: 'Confirm Password',
//                                                                     labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                                                     suffixIcon: IconButton(
//                                                                       icon: Icon(
//                                                                         _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility ,
//                                                                         color: Colors.white,
//                                                                       ),
//                                                                       onPressed: () {
//                                                                         setState(() {
//                                                                           _obscureConfirmPassword = !_obscureConfirmPassword;
//                                                                         });
//                                                                       },
//                                                                     ),
//                                                                   ),
//                                                                   obscureText: _obscureConfirmPassword,
//                                                                   controller: _confrom_password,
//                                                                 ),
//
//                                                                 SizedBox(height: 20,),
//                                                                 TextFormField(
//                                                                   style: TextStyle(color: Colors.white),
//                                                                   decoration: InputDecoration(
//                                                                     enabledBorder: UnderlineInputBorder(
//                                                                       borderSide: BorderSide(color: Colors.white),
//                                                                     ),
//                                                                     focusedBorder: UnderlineInputBorder(
//                                                                       borderSide: BorderSide(color: Colors.white),
//                                                                     ),
//                                                                     labelText: 'DACC Membership Number',
//                                                                     labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                                                   ),
//                                                                   controller: _memberShipno,
//                                                                 ),
//                                                                 Row(
//                                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                                   children: [
//                                                                     Text('Gender:'),
//                                                                     Radio(
//                                                                       value: true,
//                                                                       groupValue: _isMale,
//                                                                       onChanged: (value) {
//                                                                         setState(() {
//                                                                           _isMale = value;
//                                                                         });
//                                                                       },
//                                                                     ),
//                                                                     Text('Male'),
//                                                                     Radio(
//                                                                       value: false,
//                                                                       groupValue: _isMale,
//                                                                       onChanged: (value) {
//                                                                         setState(() {
//                                                                           _isMale = value;
//                                                                         });
//                                                                       },
//                                                                     ),
//                                                                     Text('Female'),
//                                                                   ],
//                                                                 ),
//
//                                                                 SingleChildScrollView(scrollDirection: Axis.horizontal,
//                                                                   child: Row(
//                                                                     mainAxisAlignment: MainAxisAlignment.start,
//                                                                     children: [
//                                                                       Text('Are you DA Creek Club Member'),
//                                                                       Radio(
//                                                                         value: true,
//                                                                         groupValue: _isClubMember,
//                                                                         onChanged: (value) {
//                                                                           setState(() {
//                                                                             _isClubMember = value;
//                                                                           });
//                                                                         },
//                                                                       ),
//                                                                       Text('Yes'),
//                                                                       Radio(
//                                                                         value: false,
//                                                                         groupValue: _isClubMember,
//                                                                         onChanged: (value) {
//                                                                           setState(() {
//                                                                             _isClubMember = value;
//                                                                           });
//                                                                         },
//                                                                       ),
//                                                                       Text('No'),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//
//                                                                 Row(
//                                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                                   children: [
//                                                                     Text('Creek Club Card Copy'),
//                                                                     Radio(
//                                                                       value: true,
//                                                                       groupValue: _isCardCopy,
//                                                                       onChanged: (value) {
//                                                                         setState(() {
//                                                                           _isCardCopy = value;
//                                                                         });
//                                                                       },
//                                                                     ),
//                                                                     Text('Yes'),
//                                                                     Radio(
//                                                                       value: false,
//                                                                       groupValue: _isCardCopy,
//                                                                       onChanged: (value) {
//                                                                         setState(() {
//                                                                           _isCardCopy = value;
//                                                                         });
//                                                                       },
//                                                                     ),
//                                                                     Text('No'),
//                                                                   ],
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ]
//                                       ),
//                                       // child: ListView.builder(
//                                       //   itemCount: 100,
//                                       //   controller: _controller,
//                                       //   itemExtent: itemExtent,
//                                       //   itemBuilder: (context,index){
//                                       //     return Container(
//                                       //       child: ListTile(
//                                       //         title: Text(index.toString()),
//                                       //         subtitle: Text('More...............'),
//                                       //       ),
//                                       //     );
//                                       //   },
//                                       // ),
//                                       controller: _controller,
//                                       backgroundColor: Color(0xff2e2d77),
//                                       labelConstraints: BoxConstraints.tightFor(width: 10,height: 140),
//                                       labelTextBuilder: (double offset)=> Text('${offset ~/ itemExtent}'),
//                                       alwaysVisibleScrollThumb: true,
//                                       heightScrollThumb: 80.0,
//                                     ),
//                                   ),
//
//                                   // SingleChildScrollView(
//                                   //   child: Center(
//                                   //     child: Form(
//                                   //       child: Column(
//                                   //         mainAxisAlignment: MainAxisAlignment.start,
//                                   //         children: <Widget>[
//                                   //           Column(
//                                   //             children: <Widget>[
//                                   //               SizedBox(height: size.height*0.035,),
//                                   //               FadeAnimation(1, Text("Admission", style: GoogleFonts.poppins(
//                                   //                   fontSize: 30,
//                                   //                   fontWeight: FontWeight.bold,
//                                   //                   color: Colors.white
//                                   //               ),)),
//                                   //               SizedBox(height: 5,),
//                                   //               FadeAnimation(1.2,
//                                   //                   Text("Create Your Account, Its Free", style: GoogleFonts.poppins(
//                                   //                       fontSize: 15,
//                                   //                       color: Colors.white
//                                   //                   ),)),
//                                   //             ],
//                                   //           ),
//                                   //           Padding(
//                                   //             padding: EdgeInsets.symmetric(horizontal: 10),
//                                   //             child: SingleChildScrollView(child:
//                                   //             Column(
//                                   //               children: <Widget>[
//                                   //
//                                   //                 Padding(
//                                   //                   padding: EdgeInsets.symmetric(horizontal: 10),
//                                   //                   child: SingleChildScrollView(child:
//                                   //                   Column(
//                                   //                     children: <Widget>[
//                                   //                       Form(
//                                   //                         key: _formKey,
//                                   //                         child: Column(
//                                   //                           children: <Widget>[
//                                   //                             TextFormField(
//                                   //                               style: TextStyle(color: Colors.white),
//                                   //                               decoration: InputDecoration(
//                                   //                                 enabledBorder: UnderlineInputBorder(
//                                   //                                   borderSide: BorderSide(color: Colors.white),
//                                   //                                 ),
//                                   //                                 focusedBorder: UnderlineInputBorder(
//                                   //                                   borderSide: BorderSide(color: Colors.white),
//                                   //                                 ),
//                                   //                                 labelText: 'Parent Name',
//                                   //                                 labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                   //                               ),
//                                   //                               controller: _name,
//                                   //                             ),
//                                   //                             SizedBox(height: 20,),
//                                   //                             TextFormField(
//                                   //                               style: TextStyle(color: Colors.white),
//                                   //                               decoration: InputDecoration(
//                                   //                                 enabledBorder: UnderlineInputBorder(
//                                   //                                   borderSide: BorderSide(color: Colors.white),
//                                   //                                 ),
//                                   //                                 focusedBorder: UnderlineInputBorder(
//                                   //                                   borderSide: BorderSide(color: Colors.white),
//                                   //                                 ),
//                                   //                                 labelText: 'Child Name',
//                                   //                                 labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                   //                               ),
//                                   //                               controller: child_name,
//                                   //                             ),
//                                   //                           ],
//                                   //                         ),
//                                   //                       ),
//                                   //                       TextFormField(
//                                   //                         style: TextStyle(color: Colors.white),
//                                   //                         decoration: InputDecoration(
//                                   //                           enabledBorder: UnderlineInputBorder(
//                                   //                             borderSide: BorderSide(color: Colors.white),
//                                   //                           ),
//                                   //                           focusedBorder: UnderlineInputBorder(
//                                   //                             borderSide: BorderSide(color: Colors.white),
//                                   //                           ),
//                                   //                           labelText: 'Email',
//                                   //                           labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                   //                         ),
//                                   //                         controller: _email,
//                                   //                       ),
//                                   //                       SizedBox(height: 20,),
//                                   //                       TextFormField(
//                                   //                         style: TextStyle(color: Colors.white),
//                                   //                         decoration: InputDecoration(
//                                   //                           enabledBorder: UnderlineInputBorder(
//                                   //                             borderSide: BorderSide(color: Colors.white),
//                                   //                           ),
//                                   //                           focusedBorder: UnderlineInputBorder(
//                                   //                             borderSide: BorderSide(color: Colors.white),
//                                   //                           ),
//                                   //                           labelText: 'Address',
//                                   //                           labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                   //                         ),
//                                   //                         controller: _address,
//                                   //                       ),
//                                   //
//                                   //                       SizedBox(height: 20,),
//                                   //                       TextFormField(style: TextStyle(color: Colors.white),
//                                   //                         keyboardType: TextInputType.phone,
//                                   //                         decoration: InputDecoration(
//                                   //                           enabledBorder: UnderlineInputBorder(
//                                   //                             borderSide: BorderSide(color: Colors.white),
//                                   //                           ),
//                                   //                           focusedBorder: UnderlineInputBorder(
//                                   //                             borderSide: BorderSide(color: Colors.white),
//                                   //                           ),
//                                   //                           labelText: 'Phone Number',
//                                   //                           labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                   //                         ),
//                                   //                         inputFormatters: [
//                                   //                           FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//                                   //                         ],
//                                   //                         validator: (value) {
//                                   //                           if (value.isEmpty) {
//                                   //                             return 'Please enter your phone number';
//                                   //                           }
//                                   //                           return null;
//                                   //                         },
//                                   //                         controller: _phoneNumber,
//                                   //                       ),
//                                   //
//                                   //                       SizedBox(height: 20,),
//                                   //                       TextFormField(style: TextStyle(color: Colors.white),
//                                   //                         controller: _dateOfBirth,
//                                   //                         onTap: () async {
//                                   //                           DateTime date = DateTime(1900);
//                                   //                           FocusScope.of(context).requestFocus(new FocusNode());
//                                   //
//                                   //                           date = await showDatePicker(
//                                   //                             context: context,
//                                   //                             initialDate: DateTime.now(),
//                                   //                             firstDate: DateTime(1900),
//                                   //                             lastDate: DateTime.now(),
//                                   //                           );
//                                   //
//                                   //                           _dateController.text = DateFormat('dd-MM-yyyy').format(date);
//                                   //                           _dateOfBirth = _dateController;
//                                   //                         },
//                                   //                         decoration: InputDecoration(
//                                   //                           enabledBorder: UnderlineInputBorder(
//                                   //                             borderSide: BorderSide(color: Colors.white),
//                                   //                           ),
//                                   //                           focusedBorder: UnderlineInputBorder(
//                                   //                             borderSide: BorderSide(color: Colors.white),
//                                   //                           ),
//                                   //                           labelText: 'Date of Birth',
//                                   //                           labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                   //
//                                   //                           suffixIcon: Icon(Icons.calendar_today),
//                                   //                         ),
//                                   //                         validator: (value) {
//                                   //                           if (value.isEmpty) {
//                                   //                             return 'Please select your date of birth';
//                                   //                           }
//                                   //                           return null;
//                                   //                         },
//                                   //
//                                   //                       ),
//                                   //
//                                   //
//                                   //                       SizedBox(height: 20,),
//                                   //
//                                   //                       FutureBuilder<QuerySnapshot>(
//                                   //                         future: FirebaseFirestore.instance
//                                   //                             .collection('Academy')
//                                   //                             .doc('taha@gmail.com')
//                                   //                             .collection("Shifts")
//                                   //                             .get(),
//                                   //                         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                                   //                           // if (snapshot.connectionState == ConnectionState.waiting) {
//                                   //                           //   return CircularProgressIndicator();
//                                   //                           // }
//                                   //                           if (snapshot.hasData) {
//                                   //                             shifts = snapshot.data.docs.map(
//                                   //                                   (doc) => ShiftItem(
//                                   //                                 startTime: doc.get('startTime'),
//                                   //                                 endTime: doc.get('endTime'),
//                                   //                                 position: doc.get('position'),
//                                   //                               ),
//                                   //                             ).toList();
//                                   //
//                                   //                             if (shifts.isEmpty) {
//                                   //                               return Text('No shifts available');
//                                   //                             }
//                                   //
//                                   //                             return DropdownButtonFormField<String>(
//                                   //                               decoration: InputDecoration(
//                                   //                                 labelText: 'Select Shift',
//                                   //                                 labelStyle: TextStyle(color: Color(
//                                   //                                     0xffffffff)),
//                                   //                                 enabledBorder: UnderlineInputBorder(
//                                   //                                   borderSide: BorderSide(color: Color(
//                                   //                                       0xffffffff)),
//                                   //                                 ),
//                                   //                               ),
//                                   //                               value: selectedShiftValue,
//                                   //                               onChanged: (value) {
//                                   //                                 setState(() {
//                                   //                                   selectedShiftValue = value;
//                                   //                                 });
//                                   //                               },
//                                   //                               items: shifts.map((ShiftItem shift) {
//                                   //                                 return DropdownMenuItem<String>(
//                                   //                                   value: shift.position,
//                                   //                                   child: Text(
//                                   //                                     '${shift.startTime} - ${shift.position} - ${shift.endTime}',
//                                   //                                     style: TextStyle(color: Colors.black),
//                                   //                                   ),
//                                   //                                 );
//                                   //                               }).toList(),
//                                   //                               validator: (value) {
//                                   //                                 if (value == null || value.isEmpty) {
//                                   //                                   return 'Please select a shift';
//                                   //                                 }
//                                   //                                 return null;
//                                   //                               },
//                                   //                             );
//                                   //                           }
//                                   //
//                                   //                           if (snapshot.hasError) {
//                                   //                             return Text('Error: ${snapshot.error}');
//                                   //                           }
//                                   //
//                                   //                           return Text('No shifts available');
//                                   //                         },
//                                   //                       ),
//                                   //
//                                   //                       SizedBox(height: 20,),
//                                   //
//                                   //                       DropdownButtonFormField<String>(
//                                   //                         value: _selectedlocation,
//                                   //                         onChanged: (String newValue) {
//                                   //                           setState(() {
//                                   //                             _selectedlocation = newValue;
//                                   //                           });
//                                   //                         },
//                                   //                         items: <String>['DA Creek Club']
//                                   //                             .map<DropdownMenuItem<String>>((String value) {
//                                   //                           return DropdownMenuItem<String>(
//                                   //                             value: value,
//                                   //                             child: Text(value),
//                                   //                           );
//                                   //                         }).toList(),
//                                   //                         style: TextStyle(color: Colors.black),
//                                   //                         decoration: InputDecoration(
//                                   //                           enabledBorder: UnderlineInputBorder(
//                                   //                             borderSide: BorderSide(color: Colors.white),
//                                   //                           ),
//                                   //                           focusedBorder: UnderlineInputBorder(
//                                   //                             borderSide: BorderSide(color: Colors.white),
//                                   //                           ),
//                                   //                           labelText: 'Location',
//                                   //                           labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                   //                         ),
//                                   //                       ),
//                                   //
//                                   //                       TextFormField(
//                                   //                         style: TextStyle(color: Colors.white),
//                                   //                         decoration: InputDecoration(
//                                   //                           enabledBorder: UnderlineInputBorder(
//                                   //                             borderSide: BorderSide(color: Colors.white),
//                                   //                           ),
//                                   //                           focusedBorder: UnderlineInputBorder(
//                                   //                             borderSide: BorderSide(color: Colors.white),
//                                   //                           ),
//                                   //                           labelText: 'Password',
//                                   //                           labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                   //                           suffixIcon: IconButton(
//                                   //                             icon: Icon(
//                                   //                               _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                                   //                               color: Colors.white,
//                                   //                             ),
//                                   //                             onPressed: () {
//                                   //                               setState(() {
//                                   //                                 _obscurePassword = !_obscurePassword;
//                                   //                               });
//                                   //                             },
//                                   //                           ),
//                                   //                         ),
//                                   //                         obscureText: _obscurePassword,
//                                   //                         controller: _password,
//                                   //                       ),
//                                   //
//                                   //                       TextFormField(
//                                   //                         style: TextStyle(color: Colors.white),
//                                   //                         decoration: InputDecoration(
//                                   //                           enabledBorder: UnderlineInputBorder(
//                                   //                             borderSide: BorderSide(color: Colors.white),
//                                   //                           ),
//                                   //                           focusedBorder: UnderlineInputBorder(
//                                   //                             borderSide: BorderSide(color: Colors.white),
//                                   //                           ),
//                                   //                           labelText: 'Confirm Password',
//                                   //                           labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                   //                           suffixIcon: IconButton(
//                                   //                             icon: Icon(
//                                   //                               _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility ,
//                                   //                               color: Colors.white,
//                                   //                             ),
//                                   //                             onPressed: () {
//                                   //                               setState(() {
//                                   //                                 _obscureConfirmPassword = !_obscureConfirmPassword;
//                                   //                               });
//                                   //                             },
//                                   //                           ),
//                                   //                         ),
//                                   //                         obscureText: _obscureConfirmPassword,
//                                   //                         controller: _confrom_password,
//                                   //                       ),
//                                   //
//                                   //                       SizedBox(height: 20,),
//                                   //                       TextFormField(
//                                   //                         style: TextStyle(color: Colors.white),
//                                   //                         decoration: InputDecoration(
//                                   //                           enabledBorder: UnderlineInputBorder(
//                                   //                             borderSide: BorderSide(color: Colors.white),
//                                   //                           ),
//                                   //                           focusedBorder: UnderlineInputBorder(
//                                   //                             borderSide: BorderSide(color: Colors.white),
//                                   //                           ),
//                                   //                           labelText: 'DACC Membership Number',
//                                   //                           labelStyle: GoogleFonts.poppins(color: Colors.white),
//                                   //                         ),
//                                   //                         controller: _memberShipno,
//                                   //                       ),
//                                   //                       Row(
//                                   //                         mainAxisAlignment: MainAxisAlignment.start,
//                                   //                         children: [
//                                   //                           Text('Gender:'),
//                                   //                           Radio(
//                                   //                             value: true,
//                                   //                             groupValue: _isMale,
//                                   //                             onChanged: (value) {
//                                   //                               setState(() {
//                                   //                                 _isMale = value;
//                                   //                               });
//                                   //                             },
//                                   //                           ),
//                                   //                           Text('Male'),
//                                   //                           Radio(
//                                   //                             value: false,
//                                   //                             groupValue: _isMale,
//                                   //                             onChanged: (value) {
//                                   //                               setState(() {
//                                   //                                 _isMale = value;
//                                   //                               });
//                                   //                             },
//                                   //                           ),
//                                   //                           Text('Female'),
//                                   //                         ],
//                                   //                       ),
//                                   //
//                                   //                       SingleChildScrollView(scrollDirection: Axis.horizontal,
//                                   //                         child: Row(
//                                   //                           mainAxisAlignment: MainAxisAlignment.start,
//                                   //                           children: [
//                                   //                             Text('Are you DA Creek Club Member'),
//                                   //                             Radio(
//                                   //                               value: true,
//                                   //                               groupValue: _isClubMember,
//                                   //                               onChanged: (value) {
//                                   //                                 setState(() {
//                                   //                                   _isClubMember = value;
//                                   //                                 });
//                                   //                               },
//                                   //                             ),
//                                   //                             Text('Yes'),
//                                   //                             Radio(
//                                   //                               value: false,
//                                   //                               groupValue: _isClubMember,
//                                   //                               onChanged: (value) {
//                                   //                                 setState(() {
//                                   //                                   _isClubMember = value;
//                                   //                                 });
//                                   //                               },
//                                   //                             ),
//                                   //                             Text('No'),
//                                   //                           ],
//                                   //                         ),
//                                   //                       ),
//                                   //
//                                   //                       Row(
//                                   //                         mainAxisAlignment: MainAxisAlignment.start,
//                                   //                         children: [
//                                   //                           Text('Creek Club Card Copy'),
//                                   //                           Radio(
//                                   //                             value: true,
//                                   //                             groupValue: _isCardCopy,
//                                   //                             onChanged: (value) {
//                                   //                               setState(() {
//                                   //                                 _isCardCopy = value;
//                                   //                               });
//                                   //                             },
//                                   //                           ),
//                                   //                           Text('Yes'),
//                                   //                           Radio(
//                                   //                             value: false,
//                                   //                             groupValue: _isCardCopy,
//                                   //                             onChanged: (value) {
//                                   //                               setState(() {
//                                   //                                 _isCardCopy = value;
//                                   //                               });
//                                   //                             },
//                                   //                           ),
//                                   //                           Text('No'),
//                                   //                         ],
//                                   //                       ),
//                                   //                     ],
//                                   //                   ),
//                                   //                   ),
//                                   //                 ),
//                                   //               ],
//                                   //             ),
//                                   //             ),
//                                   //           ),
//                                   //         ],
//                                   //       ),
//                                   //     ),
//                                   //   ),
//                                   // ),
//                                 ]
//                             )
//                         )
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10 ,),
//
//
//
//                 Container(child:
//                 MaterialButton(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                   ),
//                   elevation: 5.0,
//                   minWidth: 200.0,
//                   height: 55,
//                   color: Color(0xff2e2d77),
//                   child: isRegistering
//                       ? CircularProgressIndicator()
//                       : Text(
//                     'Register',
//                     style: GoogleFonts.poppins(
//                       textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
//                     ),
//                   ),
//                   onPressed: () {
//                     if (isRegistering) {
//                       return;
//                     }
//
//                     if (child_name == null || child_name.text.trim().isEmpty) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Please enter your Child Name'),
//                         ),
//                       );
//                       return;
//                     }
//
//                     // Validate shifts
//                     if (shifts == null || shifts.isEmpty) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Please select at least one Shift'),
//                         ),
//                       );
//                       return;
//                     }
//
//                     // Validate other fields
//                     if (_name == null || _name.text.trim().isEmpty) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Please enter your name'),
//                         ),
//                       );
//                       return;
//                     } else if (_email == null || _email.text.trim().isEmpty) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Please enter your email address'),
//                         ),
//                       );
//                       return;
//                     } else if (_email.text.trim().contains(RegExp(r'[A-Z]'))) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Email should not contain uppercase letters'),
//                         ),
//                       );
//                       return;
//                     } else if (!_email.text.trim().contains('@') || !_email.text.trim().contains('.')) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Email format is invalid'),
//                         ),
//                       );
//                       return;
//                     } else if (_password == null || _password.text.trim().isEmpty) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Please enter password'),
//                         ),
//                       );
//                       return;
//                     } else if (_confrom_password == null || _confrom_password.text.trim().isEmpty) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Please enter confirm password'),
//                         ),
//                       );
//                       return;
//                     } else if (_password.text.trim() != _confrom_password.text.trim()) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Passwords do not match.'),
//                         ),
//                       );
//                       return;
//                     }
//
//                     setState(() {
//                       isRegistering = true; // Set isRegistering to true to show the loader
//                     });
//
//                     checkForDuplicateEmail().then((isDuplicate) {
//                       if (isDuplicate) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Email is already registered'),
//                           ),
//                         );
//                       } else {
//                         _register();
//                       }
//
//                       // Introduce a delay of 2 seconds before setting isRegistering back to false
//                       Timer(Duration(seconds: 5), () {
//                         setState(() {
//                           isRegistering = false;
//                         });
//                       });
//                     });
//                   },
//                 )
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
// class ScreenMain extends StatefulWidget {
//   ScreenMain({Key key}) : super(key: key);
//
//   @override
//   State<ScreenMain> createState() => _ScreenMainState();
// }
//
// class _ScreenMainState extends State<ScreenMain> {
//   TextEditingController searchController = TextEditingController();
//   int _selectedIndex = 0;
//   bool _shouldShowRegisterOption = true;
//   List<Widget> _screens = [];
//   int currentIndex = 0;
//   List<Widget> screens;
//   bool isRegistered = false; // Track if the user has registered.
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Load the user registration status when the widget is initialized.
//     checkUserRegistration();
//
//     screens = <Widget>[
//       Dashboard(),
//       ShiftsListPage(),
//       SignupPage(),
//     ];
//   }
//
//
//
//   // Function to check if the user has registered before using shared preferences.
//   void checkUserRegistration() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool registered = prefs.getBool('isRegistered') ?? false;
//     setState(() {
//       isRegistered = registered;
//     });
//   }
//
//   // Function to set the registration status in shared preferences.
//   Future<void> setUserRegistered() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('isRegistered', true);
//     setState(() {
//       isRegistered = true;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: currentIndex,
//         children: screens,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//             print("use less $currentIndex");
//           });
//         },
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.white,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         items: [
//           BottomNavigationBarItem(
//             backgroundColor: Colors.black,
//             label: 'Home',
//             icon: Column(
//               children: [
//                 Icon(
//                   Icons.home,
//                   color: currentIndex == 0 ? Color(0xff2e2d77) : Colors.grey,
//                 ),
//                 Text(
//                   "Home",
//                   style: GoogleFonts.poppins(
//                     fontSize: 10,
//                     color: currentIndex == 0 ? Color(0xff2e2d77) : Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.black,
//             label: 'Schedule',
//             icon: Column(
//               children: [
//                 Icon(
//                   Icons.schedule,
//                   color: currentIndex == 1 ? Color(0xff2e2d77) : Colors.grey,
//                 ),
//                 Text(
//                   "Schedule",
//                   style: GoogleFonts.poppins(
//                     fontSize: 10,
//                     color: currentIndex == 1 ? Color(0xff2e2d77) : Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.black,
//             label: 'Register',
//             icon: Column(
//               children: [
//                 Icon(
//                   Icons.supervised_user_circle_outlined,
//                   color: currentIndex == 1 ? Color(0xff2e2d77) : Colors.grey,
//                 ),
//                 Text(
//                   "Register",
//                   style: GoogleFonts.poppins(
//                     fontSize: 10,
//                     color: currentIndex == 1 ? Color(0xff2e2d77) : Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }
//
// class ShiftItem {
//   final String startTime;
//   final String endTime;
//   final String position;
//
//   ShiftItem({
//     this.startTime,
//     this.endTime,
//     this.position,
//   });
// }
//
//
