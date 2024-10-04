import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../personalization/controllers/booking_venue_controller.dart';
import '../../../../../personalization/models/bookingslot_model.dart';
import '../../../../../personalization/models/venus_model.dart';
import '../../../../../utils/constant/colors.dart';

class View_Ground extends StatefulWidget {
  final Venue venue;
  final Function(String selectedSlot) onSlotSelected;
  final String? pitchId; // Add this field



  View_Ground({
    required this.venue,
    required this.onSlotSelected,
    required this.pitchId,  // Add this to the constructor
  });


  @override
  _ViewGroundState createState() => _ViewGroundState();
}

class _ViewGroundState extends State<View_Ground> {
  String? _selectedSlot;
  String? _selectedDay;
  final BookingController bookingvenueController = Get.put(BookingController());

  String _formatTime(String timeString) {
    try {
      DateTime dateTime = DateTime.parse(timeString);
      return DateFormat.Hm().format(dateTime);
    } catch (e) {
      return timeString;
    }
  }

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
                    items: widget.venue.images.map((imageUrl) {
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Icon(Icons.access_time, color: MyColors.primary),
                        SizedBox(width: 5),
                        Text(
                          widget.venue.timings.isNotEmpty
                              ? _formatTime(widget.venue.timings[0])
                              : 'No timings available',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildAddressSection(),
                  SizedBox(height: 16),
                  _buildSportsSection(),
                  SizedBox(height: 16),
                  _buildAmenitiesSection(),
                  SizedBox(height: 16),
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
              // Check if a day and time slot are selected
              if (_selectedTimeSlot == null || _selectedDay == null) {
                Get.snackbar('Error', 'Please select a day and time slot before booking.');
                return;
              }

              // Attempt to find the selected pitch based on availability
              Pitch? selectedPitch;
              try {
                selectedPitch = widget.venue.pitches.firstWhere((pitch) =>
                    pitch.availability.any((slot) =>
                    slot.day == _selectedDay && slot.startTime + '-' + slot.endTime == _selectedTimeSlot));
              } catch (e) {
                Get.snackbar('Error', 'No available pitch found for the selected time slot.');
                return;
              }

              // Split the selected time slot
              final List<String> selectedTimes = _selectedTimeSlot!.split('-').map((e) => e.trim()).toList();
              final String startTime = selectedTimes.isNotEmpty ? selectedTimes[0] : '';
              final String endTime = selectedTimes.length > 1 ? selectedTimes[1] : '';

              // Validate start and end times
              if (startTime.isEmpty || endTime.isEmpty) {
                Get.snackbar('Error', 'Invalid time slot selected.');
                return;
              }

              // Create the booking model
              final bookslotModel = BookslotModel(
                venue: widget.venue.id,
                pitch: selectedPitch.id,
                bookingDate: DateFormat('dd-MM-yy').format(DateTime.now()),
                startTime: startTime,
                endTime: endTime,
              );

              // Create the booking
              bookingvenueController.createBooking(
                  context,
                  bookslotModel,
                  widget.venue.name,
                  widget.venue.price.toString(),
                  bookslotModel.startTime,
                  bookslotModel.endTime
              );

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
            _buildSportIcons("Cricket", Icons.sports_cricket),
            _buildSportIcons("Football", Icons.sports_soccer),
            _buildSportIcons("Tennis", Icons.sports_tennis),
          ],
        ),
      ],
    );
  }

  Widget _buildSportIcons(String sportName, IconData iconData) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: MyColors.primary,
          child: Icon(
            iconData,
            size: 30,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          sportName,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color:  MyColors.black,
          ),
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
            return _buildSportIcon(amenity.description, amenity.icon.isNotEmpty ? amenity.icon[0] : null);
          }).toList(),
        ),

      ],
    );
  }

  Widget _buildAvailableSlotsSection() {
    Set<String> uniqueDays = widget.venue.pitches
        .expand((pitch) => pitch.availability)
        .map((slot) => slot.day)
        .toSet();

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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: uniqueDays
                  .map((day) => GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDay = day;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: _selectedDay == day ? MyColors.primary : Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    day,
                    style: TextStyle(
                      color: _selectedDay == day ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ))
                  .toList(),
            ),
          ),
          SizedBox(height: 16),
          _selectedDay != null ? _buildTimeSlots() : Container(),
        ],
      ),
    );
  }

  String? _selectedTimeSlot;

  Widget _buildTimeSlots() {
    List<Availability> selectedDaySlots = widget.venue.pitches
        .expand((pitch) => pitch.availability)
        .where((slot) => slot.day == _selectedDay)
        .toList();

    if (selectedDaySlots.isEmpty) {
      return Text("No slots available for this day.");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: selectedDaySlots.map((slot) {
            bool isSelected = _selectedTimeSlot == slot.startTime + '-' + slot.endTime;

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedTimeSlot = null;
                  } else {
                    _selectedTimeSlot = slot.startTime + '-' + slot.endTime;
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected ? MyColors.primary : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      "Start Time: ${_formatTime(slot.startTime)}",
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "End Time: ${_formatTime(slot.endTime)}",
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black, // Change text color if selected
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        if (_selectedTimeSlot != null) ...[
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              "Available Slots for the Selected Time:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          _buildAvailableSlotsForSelectedPitch(),
        ],
      ],
    );
  }

  Widget _buildAvailableSlotsForSelectedPitch() {
    Pitch selectedPitch = widget.venue.pitches.first;

    List<String> availableSlots = selectedPitch.slot;

    print("Available slots: $availableSlots");

    if (availableSlots.isEmpty) {
      return Text("No available slots for the selected pitch.");
    }

    return Column(
      children: availableSlots.map((slot) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedTimeSlot = slot;
              print("Selected Time Slot: $_selectedTimeSlot");
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: _selectedTimeSlot == slot ? MyColors.primary : Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(
                  "Slot: $slot",
                  style: TextStyle(
                    color: _selectedTimeSlot == slot ? Colors.white : Colors.black,
                    fontWeight: _selectedTimeSlot == slot ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }



  // Show Image Dialog
  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black,
          child: Center(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSportIcon(String description, String? iconPath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconPath != null
            ? CircleAvatar(
          backgroundColor: MyColors.primary,
              maxRadius: 30,
              child: Image.network(
                        iconPath,
                        width: 40,
                        height: 40,
                      ),
            )
            : Container(),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }


}
