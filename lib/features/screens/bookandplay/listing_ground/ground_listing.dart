import 'package:appkickoff/utils/drawer/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../personalization/login/controllers/login_controller.dart';
import '../../../../utils/constant/colors.dart';
import 'View_Ground_listing/ground_listing_view.dart';

class GroundListingUI extends StatefulWidget {
  @override
  State<GroundListingUI> createState() => _GroundListingUIState();
}

class _GroundListingUIState extends State<GroundListingUI> {
  final TextEditingController searchController = TextEditingController();
  final LoginController _loginController = Get.put(LoginController());

  bool showFilters = false;

  List<String> sports = ['Football', 'Basketball', 'Tennis', 'Cricket'];

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
                  icon: Icon(showFilters ? Icons.close : Icons.filter_list, color: MyColors.primary),
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
             }
            ),
           ),

          // Ground Listing
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return _buildGroundCard();
              },
            ),
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
              child: Text('Apply Filters', style: TextStyle(fontSize: 16,color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  // Ground Card with Image Background
  Widget _buildGroundCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => View_Ground(
              // groundName: 'Clifton Arena',
              // location: 'Karachi, Pakistan',
            ),
          ),
        );
      },
      child: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage('assets/hq720.jpg'),
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
                Text('Clifton Arena',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
                SizedBox(height: 4),
                Text(
                  'Karachi, Pakistan',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 8),

                // Rating and Stars Row
                Row(
                  children: [
                    Text(
                      '4.5',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.star, color: Colors.yellow[700], size: 16),
                    Icon(Icons.star, color: Colors.yellow[700], size: 16),
                    Icon(Icons.star, color: Colors.yellow[700], size: 16),
                    Icon(Icons.star, color: Colors.yellow[700], size: 16),
                    Icon(Icons.star_half, color: Colors.yellow[700], size: 16),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
