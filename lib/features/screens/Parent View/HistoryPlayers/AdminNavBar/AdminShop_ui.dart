import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../main.dart';
import '../../../HomePage/homepage.dart';
import '../../../Login/login.dart';
import '../../../Sign Up/signup.dart';
import '../../../alpha.dart';
import '../../../bookandplay/listing_ground/ground_listing.dart';
import '../../../bookandplay/login/loginbook&play.dart';
import '../../Parent_dashboard.dart';
import 'Adminaboutus.dart';
import 'Admincontactus.dart';
import 'Adminfeedback_suggestion.dart';
import 'Admingallery.dart';
import 'Adminlocation.dart';


bool isLoggedbottomIn = false;


class AdminShopUI extends StatefulWidget {
  const AdminShopUI();
  @override
  State<AdminShopUI> createState() => _AdminShopUIState();
}


_launchURL(String url) async {
  try {
    await launch(
      url,
      forceWebView: false,
      enableJavaScript: true, // You can enable JavaScript if needed
    );
  } catch (e) {
    print("Error launching URL: $e");
  }
}


class _AdminShopUIState extends State<AdminShopUI> {

  List<Product> products = [
    // Product(
    //   name: 'T-shirts',
    //   image: 'assets/32.png',
    //   price: 1500,
    // ),
    Product(
      name: 'Kick Official Shirt',
      image: 'assets/27.png',
      price: 1500,
      link: "https://kheloaaj.com/product/kick-off-academy-official-blue-shirt/",
    ),
    Product(
      name: 'Shorts',
      image: 'assets/31.png',
      price: 600,
      link: 'https://kheloaaj.com/product/kick-off-academy-official-white-shorts/'
    ),
    // Product(
    //   name: 'Aussie Fits White',
    //   image: 'assets/23.jpg',
    //   price: 1999,
    // ),
    Product(
      name: 'Water Bottles',
      image: 'assets/56.png',
      price: 800,
      link: 'https://kheloaaj.com/product/kick-off-academy-official-water-bottle/'
    ),
    Product(
      name: 'Key Chains',
      image: 'assets/33.png',
      price: 400,
      link: 'https://kheloaaj.com/product/kick-off-academy-official-keychain/'
    ),
    // Product(
    //   name: 'Aussie Fits Gym',
    //   image: 'assets/24.jpg',
    //   price: 1999,
    // ),
    Product(
      name: 'Kick Off Official Mask',
      image: 'assets/28.png',
      price: 500,
        link: 'https://kheloaaj.com/product/kick-off-academy-official-mask/'

    ),
    // Product(
    //   name: 'JAWZ Tribal Compression Shirt',
    //   image: 'assets/26.png',
    //   price: 5900,
    // ),
    // Product(
    //   name: 'CSP Official Mask',
    //   image: 'assets/25.png',
    //   price: 500,
    // ),
    Product(
      name: 'Kick Official Shirt Green',
      image: 'assets/30.jpeg',
      price: 1500,
      link: "https://kheloaaj.com/product/kick-off-academy-official-green-white-shirt/"
    ),
    // Product(
    //   name: 'The GymTastic Club Gymnastic T-Shirt',
    //   image: 'assets/29.jpeg',
    //   price: 1000,
    // ),
    // Product(
    //   name: 'The GymTastic Club Cricket T-Shirt',
    //   image: 'assets/31.jpeg',
    //   price: 1000 ,
    // ),
  ];

  int currentIndex = 0;
  SharedPreferences? _prefs;

  @override
  Widget build(BuildContext context) {
    print(isLoggedIn);

    return Scaffold(
        drawer: isLoggedIn==true? Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xff2e2d77),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/kickofflogo.png',
                      height: 80,
                    ),
                    const Text(
                      'LETS KICK OFF',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.supervised_user_circle_outlined,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('About Us'),
                onTap: () {
                  // Redirect to the parent panel page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminaboutUs()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.pin_drop,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Location & Schedule'),
                onTap: () {
                  // Redirect to the parent panel page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminLocationUI()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.shopping_bag_rounded,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Shop Now'),
                onTap: () {
                  // Redirect to the parent panel page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminShopUI()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.panorama_rounded,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Gallery'),
                onTap: () {
                  // Redirect to the parent panel page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminGalleryUI()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.contacts,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Contact Us'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminContactUs()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.feedback,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Feedback & Suggestion'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminFeedbackPage()),
                  );
                },
              ),
              // ListTile(
              //   leading: const Icon(
              //     Icons.recent_actors_sharp,
              //     color: Color(0xff2e2d77),
              //   ),
              //   title: const Text('Player Record'),
              //   onTap: () {
              //     // Redirect to the parent panel page
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => AdmissionForm()),
              //     );
              //   },
              // ),
              //
              // ListTile(
              //   leading: const Icon(
              //     Icons.history_edu_rounded,
              //     color: Color(0xff2e2d77),
              //   ),
              //   title: const Text('Player Attendance'),
              //   onTap: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (context) => AttendanceParent(),
              //       ),
              //     );
              //   },
              // ),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Color(0xff2e2d77),
                ),
                title: const Text(
                  'Logout',
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value)async {
                    _prefs ??= await SharedPreferences.getInstance();

                    await _prefs?.setBool('logout', false);

                    setState(() {
                      isLoggedIn = false;
                    });

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) => ScreenMain()),
                    );
                  }).catchError((error) {
                    print('Error during sign out: $error');
                  });
                },
              ),

              // ListTile(
              //   leading: const Icon(
              //     Icons.exit_to_app,
              //     color: Color(0xff2e2d77),
              //   ),
              //   title: const Text(
              //     'Logout',
              //   ),
              //   onTap: () {
              //     FirebaseAuth.instance.signOut().then((value) async {
              //       _prefs ??= await SharedPreferences.getInstance();
              //
              //       await _prefs?.setBool('logout', false);
              //       bool getlogout = _prefs?.getBool('logout') ?? false;
              //       print('::::HAIN BHAI KIYAaaaaaa $getlogout');
              //
              //       setState(() {
              //         isLoggedIn = false;
              //       });
              //       Get.offAll(ScreenMain());
              //
              //       // Navigator.of(context).pushReplacement(
              //       //   MaterialPageRoute(builder: (BuildContext context) => ScreenMain()),
              //       // );
              //     }
              //     ).catchError((error) {
              //       print('Error during sign out: $error');
              //     });
              //   },
              // ),
            ],
          ),
        ) :  Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xff2e2d77),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/kickofflogo.png',
                      height: 80,
                    ),
                    const Text(
                      'LETS KICK OFF',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),

                  ],
                ),
              ),
              Builder(
                builder: (context) {
                  if (isLoggedIn) {
                    return
                      ListTile(
                        leading: const Icon(
                          Icons.supervised_user_circle_outlined,
                          color: Color(0xff2e2d77),
                        ),
                        title: const Text('Parent Panel'),
                        onTap: () {
                          // Redirect to the parent panel page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ParentDashboard()),
                          );
                        },
                      );
                  } else {
                    return ListTile(
                      leading: const Icon(
                        Icons.admin_panel_settings_sharp,
                        color: Color(0xff2e2d77),
                      ),
                      title: const Text('Login'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        ).then((value) {
                          if (value != null && value) {
                            setState(() {
                              isLoggedIn = true;
                            });
                          }
                        });
                      },
                    );
                  }
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.supervised_user_circle_outlined,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('About Us'),
                onTap: () {
                  // Redirect to the parent panel page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminaboutUs()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.pin_drop,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Location & Schedule'),
                onTap: () {
                  // Redirect to the parent panel page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminLocationUI()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.shopping_bag_rounded,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Shop Now'),
                onTap: () {
                  // Redirect to the parent panel page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminShopUI()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.panorama_rounded,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Gallery'),
                onTap: () {
                  // Redirect to the parent panel page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminGalleryUI()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.contacts,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Contact Us'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminContactUs()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.feedback,
                  color: Color(0xff2e2d77),
                ),
                title: const Text('Feedback & Suggestion'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminFeedbackPage()),
                  );
                },
              ),
            ],
          ),
        ),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white), // Set icon color to white
        backgroundColor: Color(0xff2e2d77),
        title: Text(
          'Shop',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8.0),
                      ),
                      child: Center(
                        child: Image.asset(
                          products[index].image,
                          fit: BoxFit.cover,
                          width: 120,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products[index].name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '\Rs ${products[index].price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2e2d77),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Add the MaterialButton at the bottom of the card
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child:MaterialButton(
                        minWidth: 200,
                        color: Color(0xff2e2d77),
                        textColor: Colors.white,
                        onPressed: () {
                          _launchURL(products[index].link); // Launch the product link in a web browser
                        },
                        child: Text('Buy Now'),
                      )
                      // MaterialButton(minWidth: 200,
                      //   color: Color(0xff2e2d77),
                      //   textColor: Colors.white,
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => WebView(
                      //           initialUrl: 'https://kheloaaj.com/shop/',
                      //         ),
                      //       ),
                      //     );
                      //   },
                      //   child: Text('Buy Now'),
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
        bottomNavigationBar: isLoggedbottomIn==true?BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              print("use less $currentIndex");
              // Navigate to the desired pages based on the index
              if (currentIndex == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParentDashboard()),
                );
              } else {
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShiftsListPage()),
                  );
                }
              }
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              label: 'Home',
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Icon(Icons.home, color: currentIndex == 0 ? Color(0xff2e2d77) : Colors.grey),
                        Text(
                          "Home",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: currentIndex == 0 ? Color(0xff2e2d77) : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              label: 'Book & Play',
              icon: Column(
                children: [
                  Icon(Icons.menu_book_sharp, color: currentIndex == 1 ? Color(0xff2e2d77) : Colors.grey),
                  Text(
                    "Book & Play",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: currentIndex == 1 ? Color(0xff2e2d77) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),          ],
        ):
        BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              print("use less $currentIndex");
              // Navigate to the desired pages based on the index
              if (currentIndex == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScreenMain()),
                );
              } else {
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShiftsListPage()),
                  );
                }
              }
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              label: 'Home',
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Icon(Icons.home, color: currentIndex == 0 ? Color(0xff2e2d77) : Colors.grey),
                        Text(
                          "Home",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: currentIndex == 0 ? Color(0xff2e2d77) : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              label: 'Book & Play',
              icon: Column(
                children: [
                  Icon(Icons.menu_book_sharp, color: currentIndex == 1 ? Color(0xff2e2d77) : Colors.grey),
                  Text(
                    "Book & Play",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: currentIndex == 1 ? Color(0xff2e2d77) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),          ],
        )
    );
  }
}

class Product {
  final String name;
  final String image;
  final double price;
  final String link;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.link
  });
}
