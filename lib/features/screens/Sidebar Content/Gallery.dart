import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../personalization/controllers/gallery_controller.dart';
import '../../../utils/drawer/custom_drawer.dart';
import '../HomePage/homepage.dart';

import '../Parent View/Parent_dashboard.dart';
import '../Sign Up/signup.dart';
import '../alpha.dart';
import 'feedback_suggestion.dart';

class GalleryUI extends StatefulWidget {
   GalleryUI();

  @override
  State<GalleryUI> createState() => _GalleryUIState();
}

final GalleryController galleryController = Get.put(GalleryController());


class _GalleryUIState extends State<GalleryUI> {
  int currentIndex = 0;
  SharedPreferences? _prefs;

  @override
  Widget build(BuildContext context) {
    print(isLoggedIn);
    return Scaffold(
        drawer: CustomDrawer(),
        // appBar: AppBar(backgroundColor: Color(0xff2e2d77),
      //   title: const Text('Gallery',style: TextStyle(color: Colors.white),),
      //   centerTitle: true,
      //   iconTheme: IconThemeData(color: Colors.white), // Set icon color to white
      // ),
      backgroundColor: Colors.white,
        body: Obx(() {
          if (galleryController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (galleryController.errorMessage.isNotEmpty) {
            return Center(child: Text(galleryController.errorMessage.value));
          }

          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                iconTheme: IconThemeData(color: Colors.white),
                expandedHeight: 250.0,
                floating: false,
                pinned: true,
                flexibleSpace: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: AssetImage('assets/90.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.2),
                            BlendMode.dstATop,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Our Gallery',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'YourCustomFont',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(16.0),
                sliver: SliverGrid.count(
                  crossAxisCount: 2, // Number of images per row
                  mainAxisSpacing: 16.0, // Spacing between rows
                  crossAxisSpacing: 16.0, // Spacing between columns
                  children: galleryController.galleryData.map((galleryItem) {
                    return _buildImageCard(
                      context,
                      galleryItem.images.isNotEmpty ? galleryItem.images[0] : '',
                      galleryItem.title,
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            launch('https://instagram.com/kickoffacademypkk?igshid=MzRlODBiNWFlZA==');
          },
          child: Icon(FontAwesomeIcons.instagram,color: Colors.white,),
          backgroundColor: Colors.purple,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: isLoggedbottomIn==true?BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              print("use less $currentIndex");
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
            ),
          ],
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
            ),
          ],
        )
    );
  }
}

Widget _buildImageCard(BuildContext context, String imageUrl, String title) {
  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


void _showImageDialog(BuildContext context, String imagePath) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Image.asset(imagePath),
    ),
  );
}
