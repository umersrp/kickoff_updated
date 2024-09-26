import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/drawer/custom_drawer.dart';
import '../Parent View/attendence.dart';
import '../Parent View/detailMonths.dart';



class CoachesDashboard extends StatefulWidget {
  const CoachesDashboard();
  @override
  State<CoachesDashboard> createState() => _CoachesDashboardState();
}

class _CoachesDashboardState extends State<CoachesDashboard> {
  int currentIndex = 0;
  SharedPreferences? _prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Color(0xff2e2d77),
          elevation: 0.0,
          centerTitle: true,
          title:
          Text(
            "Coaches Panel",style: TextStyle(color: Colors.white),
            selectionColor:  Color(0xff2e2d77),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Spacer(),
              //     GestureDetector(
              //       onTap: (){
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(builder: (context) => Reports()),
              //         );
              //       },
              //       child: Padding(
              //         padding: EdgeInsets.all(10.0),
              //         child: Container(
              //           height: 115,
              //           width:139,
              //           decoration: BoxDecoration(
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.grey.withOpacity(0.4),
              //                 spreadRadius: 2,
              //                 blurRadius: 1,
              //                 offset: const Offset(0, 2), // changes position of shadow
              //               ),
              //             ],
              //             borderRadius: BorderRadius.circular(6),
              //             color: Colors.white,
              //           ),
              //           child: Center(
              //             child: Column(
              //               children: [
              //                 SizedBox(height: 15,),
              //                 Icon(FontAwesomeIcons.userCheck,size: 68,color:  Color(0xff2e2d77),),
              //                 SizedBox(height: 10,),
              //                 Text("Reports", style: GoogleFonts.poppins(fontSize: 10,color: Colors.grey,fontWeight: FontWeight.w500),),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Spacer(),
              //     GestureDetector(
              //       onTap: (){
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(builder: (context) => ShiftsPage()),
              //         );
              //       },
              //       child: Padding(
              //         padding: EdgeInsets.all(17.0),
              //         child: Container(
              //           height: 115,
              //           width:140,
              //           decoration: BoxDecoration(
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.grey.withOpacity(0.4),
              //                 spreadRadius: 2,
              //                 blurRadius: 1,
              //                 offset: const Offset(0, 2), // changes position of shadow
              //               ),
              //             ],
              //             borderRadius: BorderRadius.circular(6),
              //             color: Colors.white,
              //           ),
              //           child: Center(
              //             child: Column(
              //               children: [
              //                 SizedBox(height: 15),
              //                 Icon(FontAwesomeIcons.businessTime,size: 68,color: Color(0xff2e2d77),),
              //                 SizedBox(height: 10,),
              //                 Text("Groups", style: GoogleFonts.poppins(fontSize: 10,color: Colors.grey,fontWeight: FontWeight.w500),),
              //               ],
              //             ),
              //           ),
              //         ),Re
              //       ),
              //     ),
              //     Spacer(),
              //     SizedBox(
              //       width: 10,
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                children: [
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Months()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(17.0),
                      child:
                      Container(
                        height: 115,
                        width:139,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: const Offset(0, 2), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 15,),
                              Icon(FontAwesomeIcons.squarePollHorizontal,size: 68,color:  Color(0xff2e2d77),),
                              SizedBox(height: 10,),
                              Text("Reports ", style: GoogleFonts.poppins(fontSize: 10,color: Colors.grey,fontWeight: FontWeight.w500),),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  Attendance()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(17.0),
                      child: Container(
                        height: 115,
                        width:140,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: const Offset(0, 2), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 15,),
                              Icon(FontAwesomeIcons.clipboardUser,size: 68,color:  Color(0xff2e2d77),),
                              SizedBox(height: 10,),
                              Text("Player Attendance", style: GoogleFonts.poppins(fontSize: 10,color: Colors.grey,fontWeight: FontWeight.w500),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25,),
                ],
              ),
            ],
          ),
        ),
        // bottomNavigationBar: isLoggedbottomIn==true? BottomNavigationBar(
        //   currentIndex: currentIndex,
        //   onTap: (index) {
        //     setState(() {
        //       currentIndex = index;
        //       print("use less $currentIndex");
        //       // Navigate to the desired pages based on the index
        //       if (currentIndex == 0) {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => ParentDashboard()),
        //         );
        //       } else {
        //         {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => ShiftsListPage()),
        //           );
        //         }
        //       }
        //     });
        //   },
        //   type: BottomNavigationBarType.fixed,
        //   backgroundColor: Colors.white,
        //   showSelectedLabels: false,
        //   showUnselectedLabels: false,
        //   items: [
        //     BottomNavigationBarItem(
        //       backgroundColor: Colors.black,
        //       label: 'Home',
        //       icon: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Expanded(
        //             child: Column(
        //               children: [
        //                 Icon(Icons.home, color: currentIndex == 0 ? Color(0xff2e2d77) : Colors.grey),
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
        //         ],
        //       ),
        //     ),
        //     BottomNavigationBarItem(
        //       backgroundColor: Colors.black,
        //       label: 'Book & Play',
        //       icon: Column(
        //         children: [
        //           Icon(Icons.menu_book_sharp, color: currentIndex == 1 ? Color(0xff2e2d77) : Colors.grey),
        //           Text(
        //             "Book & Play",
        //             style: GoogleFonts.poppins(
        //               fontSize: 10,
        //               color: currentIndex == 1 ? Color(0xff2e2d77) : Colors.grey,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ) : BottomNavigationBar(
        //   currentIndex: currentIndex,
        //   onTap: (index) {
        //     setState(() {
        //       currentIndex = index;
        //       print("use less $currentIndex");
        //       // Navigate to the desired pages based on the index
        //       if (currentIndex == 0) {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => ScreenMain()),
        //         );
        //       } else {
        //         {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => ShiftsListPage()),
        //           );
        //         }
        //       }
        //     });
        //   },
        //   type: BottomNavigationBarType.fixed,
        //   backgroundColor: Colors.white,
        //   showSelectedLabels: false,
        //   showUnselectedLabels: false,
        //   items: [
        //     BottomNavigationBarItem(
        //       backgroundColor: Colors.black,
        //       label: 'Home',
        //       icon: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Expanded(
        //             child: Column(
        //               children: [
        //                 Icon(Icons.home, color: currentIndex == 0 ? Color(0xff2e2d77) : Colors.grey),
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
        //         ],
        //       ),
        //     ),
        //     BottomNavigationBarItem(
        //       backgroundColor: Colors.black,
        //       label: 'Book & Play',
        //       icon: Column(
        //         children: [
        //           Icon(Icons.menu_book_sharp, color: currentIndex == 1 ? Color(0xff2e2d77) : Colors.grey),
        //           Text(
        //             "Book & Play",
        //             style: GoogleFonts.poppins(
        //               fontSize: 10,
        //               color: currentIndex == 1 ? Color(0xff2e2d77) : Colors.grey,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // )
    );
  }
}


