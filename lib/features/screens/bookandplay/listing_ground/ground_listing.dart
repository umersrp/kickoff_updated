import 'package:appkickoff/utils/drawer/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
 
import '../../../../personalization/controllers/venus_controller.dart';
import '../../../../personalization/login/controllers/login_controller.dart';
import '../../../../personalization/models/venus_model.dart';
import '../../../../utils/constant/colors.dart';
import 'View_Ground_listing/ground_listing_view.dart';

class GroundListingUI extends StatefulWidget {
  @override
  State<GroundListingUI> createState() => _GroundListingUIState();
}

class _GroundListingUIState extends State<GroundListingUI> {
  final TextEditingController searchController = TextEditingController();
  final LoginController _loginController = Get.put(LoginController());
   final VenuesController _venuesController = Get.put(VenuesController()); // Add VenuesController
  bool showFilters = false;

  List<String> sports = ['Football', 'Basketball', 'Tennis', 'Cricket'];

 

  @override
  void initState() {
    super.initState();
    // Fetch venues when the screen is initialized
    _venuesController.fetchVenues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Find Your Grounds',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: MyColors.primary,
        elevation: 0,
        centerTitle: true,
      ),
 
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search grounds...',
                      filled: true,
                      fillColor: Colors.grey[300],
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
 
                  icon: Icon(
                      showFilters ? Icons.close : Icons.filter_list,
                      color: MyColors.primary),
                  onPressed: () {
                    setState(() {
                      showFilters = !showFilters;
                    });
                  },
                ),
              ],
            ),
          ),

          // Filters Section
          if (showFilters)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildFilters(),
            ),

          Center(
            child: Obx(() {
              String username = _loginController.username.value;

              if (username.isEmpty) {
                return Text(
                  'Welcome Guest,',
                  style: GoogleFonts.ibmPlexMono(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                );
              } else {
                return Text(
                  'Welcome, ${username.substring(0, 1).toUpperCase()}${username.substring(1)}!',
                  style: GoogleFonts.ibmPlexMono(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                );
              }
 
            }),
          ),

          // Ground Listing
          Expanded(
            child: Obx(() {
              if (_venuesController.isLoading.value) {
                // Show loading indicator while data is being fetched
                return Center(child: CircularProgressIndicator());
              }

              if (_venuesController.venuesList.isEmpty) {
                // Show a message when no venues are available
                return Center(child: Text('No grounds available.'));
              }

              // Display the venues in a GridView
              return GridView.builder(
                padding: const EdgeInsets.all(12.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: _venuesController.venuesList.length,
                itemBuilder: (context, index) {
                  final venue = _venuesController.venuesList[index];
                  return _buildGroundCard(venue);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // Filters UI
  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            hint: Text('Select Sport'),
            items: sports.map((String sport) {
              return DropdownMenuItem<String>(
                value: sport,
                child: Text(sport),
              );
            }).toList(),
            onChanged: (value) {},
          ),
          SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: () {
              // Perform filter action
              setState(() {
                showFilters = false;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
 
              child: Text('Apply Filters', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

 


  Widget _buildGroundCard(Venue venue,) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => View_Ground(
 
              venue: venue, // Use 'venue' from method argument
              onSlotSelected: (selectedSlot) {
              },
            ),
          ),
        );
      },
      child: Stack(
        children: [
 
          // Background Image (handling list of image URLs from the database)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
 
                image: (venue.images != null && venue.images.isNotEmpty && venue.images[0] is String)
                    ? NetworkImage(venue.images[0] as String) // Explicitly cast to String
                    : const NetworkImage('http://74.208.118.86/kickoff/uploads/image-1723201780192.png'), // Fallback image URL
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                ),
              ),
            ),
          ),
          // Ground Info
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
 
                // Venue name
                Text(
                  venue.name ?? 'Unknown Venue', // Null safety for venue name
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4), // Spacing between name and address

                // Display address fields with null safety
                Text(
                  '${venue.address?.address ?? 'Unknown Address'}, ${venue.address?.city ?? 'Unknown City'},', // Null-safe access
                  style: const TextStyle(
                    color: Colors.white70, // Slightly lighter color for address
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
