import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../utils/constant/colors.dart';

class View_Ground extends StatelessWidget {
  final List<String> Images = [
    'https://via.placeholder.com/800x400?text=Image+1',
    'https://via.placeholder.com/800x400?text=Image+2',
    'https://via.placeholder.com/800x400?text=Image+3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            expandedHeight: 450.0,
            floating: false,
            pinned: true,
            flexibleSpace: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 550.0,
                      enlargeCenterPage: false,
                      autoPlay: false,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                    ),
                    items: Images.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              _showImageDialog(context, imageUrl);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(vertical: 1.0),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),


                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9), // Slightly transparent background
                      borderRadius: BorderRadius.circular(24.0), // Rounded edges
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FontAwesomeIcons.moneyBill, color: MyColors.primary),
                        SizedBox(width: 18),
                        Text(
                          "Rs 5000", // Address Text
                          style: GoogleFonts.ibmPlexMono(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ground Name and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Clifton Arena",
                        style: GoogleFonts.ibmPlexMono(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  Row(
                    children: [
                      Icon(Icons.access_time, color: MyColors.primary),
                      SizedBox(width: 5),
                      Text("24/7", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Address Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                    children: [
                      Text(
                        "ADDRESS",
                        style: GoogleFonts.ibmPlexMono(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
                        children: [
                          Expanded(
                            child: Text(
                              "Plot ST 4, Block 2 Clifton Defence, Karachi, Pakistan.",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: MyColors.primary,
                                child: IconButton(
                                  icon: Icon(Icons.pin_drop, color: Colors.white),
                                  onPressed: () {
                                  },
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Navigation",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                    ],
                  ),

                  SizedBox(height: 16),

                  // Sports Section
                  Text(
                    "SPORTS",
                    style: GoogleFonts.ibmPlexMono(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSportIcon(Icons.sports_cricket, "Cricket"),
                      _buildSportIcon(Icons.sports_tennis, "Tennis"),
                      _buildSportIcon(Icons.sports_basketball, "Basketball"),
                      _buildSportIcon(Icons.sports_football, "Football"),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Sports Section
                  Text(
                    "AMENITES",
                    style: GoogleFonts.ibmPlexMono(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSportIcon(Icons.event_seat, "Seating Area"),
                      _buildSportIcon(Icons.light, "Lights"),
                      _buildSportIcon(Icons.local_drink, "Drinking Water"),
                      _buildSportIcon(Icons.local_parking, "Parking"),
                    ],
                  ),
                  SizedBox(height: 16),
// SLOT Section
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // Border color
                      borderRadius: BorderRadius.circular(15), // Curved borders
                      color: Colors.white, // Background color
                    ),
                    padding: EdgeInsets.all(16), // Padding inside the container
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                      children: [
                        Text(
                          "AVAILABLE SLOT:",
                          style: GoogleFonts.ibmPlexMono(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8), // Add some spacing between the title and slots
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
                          children: [
                            Expanded(child: _buildTimeCard("10:00 AM")),
                            Expanded(child: _buildTimeCard("11:30 AM")),
                            Expanded(child: _buildTimeCard("1:00 PM")),
                            Expanded(child: _buildTimeCard("3:00 PM")),
                          ],
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Handle booking slot
          },
          child: Text("BOOK SLOT",style: TextStyle(color: Colors.white),),
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primary, // Button color
            padding: EdgeInsets.symmetric(vertical: 16.0),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }




  void _showImageDialog(BuildContext context, String clickedImagePath) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 290.0,
                  aspectRatio: 16 / 9,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                  autoPlayCurve: Curves.fastOutSlowIn,
                ),
                items: Images.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Positioned(
                left: 10.0,
                top: 0.0,
                bottom: 0.0,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {},
                ),
              ),
              Positioned(
                right: 10.0,
                top: 0.0,
                bottom: 0.0,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeCard(String time) {
    return Card(
      elevation: 3, // Slightly reduced shadow elevation for a cleaner look
      margin: EdgeInsets.all(8), // Space between cards
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners for cards
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Solid background color
          borderRadius: BorderRadius.circular(12), // Match card's border radius
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Subtle shadow for depth
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2), // Shadow position
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12), // Padding inside the card
            child: Text(
              time,
              style: TextStyle(
                fontSize: 10, // Font size
                fontWeight: FontWeight.bold,
                color: Colors.black, // Dark text for contrast
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildSportIcon(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: MyColors.primary,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.black)),
      ],
    );
  }
}
