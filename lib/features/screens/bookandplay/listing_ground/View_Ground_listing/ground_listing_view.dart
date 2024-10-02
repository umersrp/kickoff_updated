import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
// <<<<<<< HEAD
// import '../../../../../utils/constant/colors.dart';

// class View_Ground extends StatelessWidget {
//   final List<String> Images = [
//     'https://via.placeholder.com/800x400?text=Image+1',
//     'https://via.placeholder.com/800x400?text=Image+2',
//     'https://via.placeholder.com/800x400?text=Image+3',
//   ];
// =======
import '../../../../../personalization/models/venus_model.dart';
import '../../../../../utils/constant/colors.dart';

class View_Ground extends StatefulWidget {
  final Venue venue;
  final Function(String selectedSlot) onSlotSelected;

  View_Ground({
    required this.venue,
    required this.onSlotSelected,
  });

  @override
  _ViewGroundState createState() => _ViewGroundState();
}

class _ViewGroundState extends State<View_Ground> {
  String? _selectedSlot;


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
// <<<<<<< HEAD
//                     items: Images.map((imageUrl) {
// =======
                    items: widget.venue.images.map((imageUrl) {
// >>>>>>> origin/main
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
 
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(24.0),
 
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(FontAwesomeIcons.moneyBill, color: MyColors.primary),
                        SizedBox(width: 18),
                        Text(
 
                          "Rs ${widget.venue.price}",
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
 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
 
                        widget.venue.name, // Ground Name
                        style: GoogleFonts.ibmPlexMono(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
// <<<<<<< HEAD

//                   Row(
//                     children: [
//                       Icon(Icons.access_time, color: MyColors.primary),
//                       SizedBox(width: 5),
//                       Text("24/7", style: TextStyle(color: Colors.black)),
//                     ],
//                   ),
//                   SizedBox(height: 16),

//                   // Address Section
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
//                     children: [
//                       Text(
//                         "ADDRESS",
//                         style: GoogleFonts.ibmPlexMono(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 3),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
//                         children: [
//                           Expanded(
//                             child: Text(
//                               "Plot ST 4, Block 2 Clifton Defence, Karachi, Pakistan.",
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                           Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               CircleAvatar(
//                                 radius: 25,
//                                 backgroundColor: MyColors.primary,
//                                 child: IconButton(
//                                   icon: Icon(Icons.pin_drop, color: Colors.white),
//                                   onPressed: () {
//                                   },
//                                   padding: EdgeInsets.zero,
//                                 ),
//                               ),
//                               SizedBox(height: 4),
//                               Text(
//                                 "Navigation",
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),

//                     ],
//                   ),

//                   SizedBox(height: 16),

//                   // Sports Section
//                   Text(
//                     "SPORTS",
//                     style: GoogleFonts.ibmPlexMono(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildSportIcon(Icons.sports_cricket, "Cricket"),
//                       _buildSportIcon(Icons.sports_tennis, "Tennis"),
//                       _buildSportIcon(Icons.sports_basketball, "Basketball"),
//                       _buildSportIcon(Icons.sports_football, "Football"),
//                     ],
//                   ),
//                   SizedBox(height: 16),

//                   // Sports Section
//                   Text(
//                     "AMENITES",
//                     style: GoogleFonts.ibmPlexMono(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildSportIcon(Icons.event_seat, "Seating Area"),
//                       _buildSportIcon(Icons.light, "Lights"),
//                       _buildSportIcon(Icons.local_drink, "Drinking Water"),
//                       _buildSportIcon(Icons.local_parking, "Parking"),
//                     ],
//                   ),
//                   SizedBox(height: 16),
// // SLOT Section
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey), // Border color
//                       borderRadius: BorderRadius.circular(15), // Curved borders
//                       color: Colors.white, // Background color
//                     ),
//                     padding: EdgeInsets.all(16), // Padding inside the container
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
//                       children: [
//                         Text(
//                           "AVAILABLE SLOT:",
//                           style: GoogleFonts.ibmPlexMono(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(height: 8), // Add some spacing between the title and slots
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
//                           children: [
//                             Expanded(child: _buildTimeCard("10:00 AM")),
//                             Expanded(child: _buildTimeCard("11:30 AM")),
//                             Expanded(child: _buildTimeCard("1:00 PM")),
//                             Expanded(child: _buildTimeCard("3:00 PM")),
//                           ],
// =======
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Icon(Icons.access_time, color: MyColors.primary),
                        SizedBox(width: 5),
                        Text(
                          widget.venue.timings.isNotEmpty ? widget.venue.timings[0] : 'No timings available',
                          style: TextStyle(color: Colors.black),
// >>>>>>> origin/main
                        ),
                      ],
                    ),
                  ),

 
                  SizedBox(height: 16),
                  // Address Section
                  _buildAddressSection(),
                  SizedBox(height: 16),
                  // SPORTS Section
                  _buildSportsSection(),
                  SizedBox(height: 16),
                  // Amenities Section
                  _buildAmenitiesSection(),
                  SizedBox(height: 16),
                  // Available Slots
                  _buildAvailableSlotsSection(),
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
 
            if (_selectedSlot != null) {
              widget.onSlotSelected(_selectedSlot!); // Pass selected slot to the callback
            } else {
              // Show a message to select a slot
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select a slot")));
            }
          },
          child: Text("BOOK SLOT", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primary,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      ),
 
      backgroundColor: Colors.grey.shade100,
    );
  }

  // Build Address Section
  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                widget.venue.address.address, // Dynamic Address
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
                      // Handle navigation
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
    );
  }

  // Build Sports Section
  Widget _buildSportsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            Text(
              widget.venue.address.address, // Dynamic Address
              style: TextStyle(color: Colors.black),
            ),
          ]
        ),


      ],
    );
  }

  // Build Amenities Section
  Widget _buildAmenitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "AMENITIES",
          style: GoogleFonts.ibmPlexMono(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget.venue.amenities.map((amenity) {
            return _buildSportIcon(amenity);
          }).toList(),
        ),
      ],
    );
  }

  // Build Available Slots Section
  Widget _buildAvailableSlotsSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AVAILABLE SLOTS:",
            style: GoogleFonts.ibmPlexMono(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),

          // Iterate over each pitch and its availability
          Column(
            children: widget.venue.pitches.map((pitch) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pitch: ${pitch.pitchName}", // Assuming the pitch has a name
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),

                  // Iterate over each availability slot
                  Column(
                    children: pitch.availability.map((slot) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSlot = "${slot.day} ${slot.startTime}-${slot.endTime}"; // Update the selected slot
                          });
                        },
                        child: _buildTimeCard(
                          "${slot.day}: ${slot.startTime} - ${slot.endTime}",
                          isSelected: _selectedSlot == "${slot.day} ${slot.startTime}-${slot.endTime}", // Pass selection state
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 16),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }


 
  // Helper Methods for Sport and Time Cards
  Widget _buildSportIcon(String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: MyColors.primary,
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.black)),
      ],
    );
  }
 


  Widget _buildTimeCard(String time, {bool isSelected = false}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: isSelected ? Border.all(color: MyColors.primary, width: 2) : null,
        borderRadius: BorderRadius.circular(8.0),
        color: isSelected ? MyColors.primary.withOpacity(0.2) : Colors.white,
      ),
      child: Center(
        child: Text(
          time,
          style: TextStyle(
            color: isSelected ? MyColors.primary : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Image.network(imageUrl),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
