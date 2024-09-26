import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/drawer/custom_drawer.dart';
import '../screens/HomePage/homepage.dart';
import '../screens/Parent View/HistoryPlayers/AdminNavBar/AdminShop_ui.dart';
import '../screens/Parent View/Parent_dashboard.dart';
import '../screens/Sign Up/signup.dart';
import '../screens/alpha.dart';


class ShopUI extends StatefulWidget {
  ShopUI();
  @override
  State<ShopUI> createState() => _ShopUIState();
}


_launchURL(String url) async {
  try {
    await launch(
      url,
      forceWebView: false,
      enableJavaScript: true,
    );
  } catch (e) {
    print("Error launching URL: $e");
  }
}


class _ShopUIState extends State<ShopUI> {

  List<Product> products = [

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
    Product(
        name: 'Kick Off Official Mask',
        image: 'assets/28.png',
        price: 500,
        link: 'https://kheloaaj.com/product/kick-off-academy-official-mask/'

    ),
    Product(
        name: 'Kick Official Shirt Green',
        image: 'assets/30.jpeg',
        price: 1500,
        link: "https://kheloaaj.com/product/kick-off-academy-official-green-white-shirt/"
    ),
  ];

  int currentIndex = 0;
  SharedPreferences? _prefs;

  @override
  Widget build(BuildContext context) {
    print(isLoggedIn);

    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Color(0xff2e2d77),
          title: Text(
            'Shop',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
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
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(16.0),
                        child: Image.asset(
                          products[index].image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                );
              },
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
                    Center(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child:MaterialButton(
                            minWidth: 200,
                            color: Color(0xff2e2d77),
                            textColor: Colors.white,
                            onPressed: () {
                              _launchURL(products[index].link);
                            },
                            child: Text('Buy Now'),
                          )
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
