// /// Show the dialog to enter pitch details
// void showMultiPitchDialog2(int numberOfPitches) {
//   /// Create TextEditingControllers for each pitch
//   List<TextEditingController> pitchNameControllers =
//       List.generate(numberOfPitches, (index) => TextEditingController());
//   List<TextEditingController> sportTypeControllers =
//       List.generate(numberOfPitches, (index) => TextEditingController());
//   List<TextEditingController> sizeControllers =
//       List.generate(numberOfPitches, (index) => TextEditingController());

//   var availabilityDayControllers = List.generate(numberOfPitches,
//       (index) => <TextEditingController>[TextEditingController()]).obs;
//   var availabilityStartTimeControllers = List.generate(numberOfPitches,
//       (index) => <TextEditingController>[TextEditingController()]).obs;
//   var availabilityEndTimeControllers = List.generate(numberOfPitches,
//       (index) => <TextEditingController>[TextEditingController()]).obs;

//   ///
//   Get.dialog(
//     barrierDismissible: false,
//     Dialog(
//       backgroundColor: Colors.white, // Dialog background color
//       child: Container(
//         width: Get.width, //* 0.9, // Custom width (90% of the screen)
//         height: Get.height * 0.85, // Custom height (85% of the screen)
//         padding: EdgeInsets.all(16), // Padding inside the dialog
//         child: Column(
//           children: [
//             Text(
//               'Enter Details for Pitches',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blueAccent, // Title color
//               ),
//             ),
//             SizedBox(height: 10),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: List.generate(numberOfPitches, (index) {
//                     int pitchNumber = index + 1;
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Pitch $pitchNumber Details',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                               color: Colors.green, // Section title color
//                             ),
//                           ),
//                           SizedBox(height: 8),

//                           // Pitch Name
//                           CustomTextFormField(
//                             controller: pitchNameControllers[index],
//                             hintText: 'Pitch Name',
//                             hintStyle: TextStyle(color: Colors.grey),
//                             filled: true,
//                             fillColor:
//                                 Colors.grey.shade200, // Input field background
//                           ),
//                           SizedBox(height: 10),

//                           // Sport Type
//                           CustomTextFormField(
//                             controller: sportTypeControllers[index],
//                             hintText: 'Sport Type',
//                             hintStyle: TextStyle(color: Colors.grey),
//                             filled: true,
//                             fillColor: Colors.grey.shade200,
//                           ),
//                           SizedBox(height: 10),

//                           // Pitch Size
//                           CustomTextFormField(
//                             controller: sizeControllers[index],
//                             hintText: 'Pitch Size (e.g., 50x100)',
//                             hintStyle: TextStyle(color: Colors.grey),
//                             filled: true,
//                             fillColor: Colors.grey.shade200,
//                           ),
//                           SizedBox(height: 10),

//                           /// Availability fields for this pitch
//                           Obx(
//                             () => Column(
//                               children: List.generate(
//                                 availabilityDayControllers[index].length,
//                                 (availIndex) => Row(
//                                   children: [
//                                     // Day
//                                     Expanded(
//                                       child: CustomTextFormField(
//                                         controller:
//                                             availabilityDayControllers[index]
//                                                 [availIndex],
//                                         hintText: 'Day (e.g., Monday)',
//                                         hintStyle:
//                                             TextStyle(color: Colors.grey),
//                                         filled: true,
//                                         fillColor: Colors.grey.shade200,
//                                       ),
//                                     ),
//                                     SizedBox(width: 10),

//                                     // Start Time
//                                     Expanded(
//                                       child: CustomTextFormField(
//                                         controller:
//                                             availabilityStartTimeControllers[
//                                                 index][availIndex],
//                                         hintText: 'Start Time (e.g., 08:00)',
//                                         hintStyle:
//                                             TextStyle(color: Colors.grey),
//                                         filled: true,
//                                         fillColor: Colors.grey.shade200,
//                                       ),
//                                     ),
//                                     SizedBox(width: 10),

//                                     // End Time
//                                     Expanded(
//                                       child: CustomTextFormField(
//                                         controller:
//                                             availabilityEndTimeControllers[
//                                                 index][availIndex],
//                                         hintText: 'End Time (e.g., 20:00)',
//                                         hintStyle:
//                                             TextStyle(color: Colors.grey),
//                                         filled: true,
//                                         fillColor: Colors.grey.shade200,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               availabilityDayControllers[index]
//                                   .add(TextEditingController());
//                               availabilityStartTimeControllers[index]
//                                   .add(TextEditingController());
//                               availabilityEndTimeControllers[index]
//                                   .add(TextEditingController());

//                               // Refresh to rebuild the UI
//                               availabilityDayControllers.refresh();
//                               availabilityStartTimeControllers.refresh();
//                               availabilityEndTimeControllers.refresh();
//                             },
//                             child: Text(
//                               'Add Another Availability',
//                               style: TextStyle(
//                                   color: Colors.blue), // Button text color
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     for (int i = 0; i < numberOfPitches; i++) {
//                       List<Map<String, String>> availabilityList = [];
//                       for (var j = 0;
//                           j < availabilityDayControllers[i].length;
//                           j++) {
//                         availabilityList.add({
//                           'day': availabilityDayControllers[i][j].text,
//                           'startTime':
//                               availabilityStartTimeControllers[i][j].text,
//                           'endTime': availabilityEndTimeControllers[i][j].text,
//                         });
//                       }
//                       // Add pitch details to the pitches list
//                       pitches.add({
//                         'pitchName': pitchNameControllers[i].text,
//                         'sportType': sportTypeControllers[i].text,
//                         'size': sizeControllers[i].text,
//                         'availability': availabilityList,
//                       });
//                     }
//                     Get.back();
//                   },
//                   child: Text(
//                     'Add Pitches',
//                     style: TextStyle(color: Colors.green), // Button text color
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Get.back();
//                   },
//                   child: Text(
//                     'Cancel',
//                     style: TextStyle(color: Colors.red), // Button text color
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

// void showMultiPitchDialogDONE(int numberOfPitches) {
//   /// Create TextEditingControllers for each pitch
//   List<TextEditingController> pitchNameControllers =
//       List.generate(numberOfPitches, (index) => TextEditingController());
//   List<TextEditingController> sportTypeControllers =
//       List.generate(numberOfPitches, (index) => TextEditingController());
//   List<TextEditingController> sizeControllers =
//       List.generate(numberOfPitches, (index) => TextEditingController());

//   /// Nested list of controllers for availability (day, startTime, endTime)
//   /// Observable nested list of controllers for availability (day, startTime, endTime)

//   var availabilityDayControllers = List.generate(numberOfPitches,
//       (index) => <TextEditingController>[TextEditingController()]).obs;
//   var availabilityStartTimeControllers = List.generate(numberOfPitches,
//       (index) => <TextEditingController>[TextEditingController()]).obs;
//   var availabilityEndTimeControllers = List.generate(numberOfPitches,
//       (index) => <TextEditingController>[TextEditingController()]).obs;

//   ///
//   Get.dialog(
//     barrierDismissible: false,
//     AlertDialog(
//       title: Text('Enter Details for Pitches'),
//       content: SizedBox(
//         width: double.maxFinite,
//         // height: double.maxFinite,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: List.generate(numberOfPitches, (index) {
//               int pitchNumber = index + 1;
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     /// text title
//                     Text(
//                       'Pitch $pitchNumber Details',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 8),

//                     /// Pitch Name
//                     CustomTextFormField(
//                       controller: pitchNameControllers[index],
//                       hintText: 'Pitch Name',
//                       hintStyle: TextStyle(color: Colors.grey),
//                       filled: true,
//                     ),
//                     SizedBox(height: 10),

//                     /// Sport Type
//                     CustomTextFormField(
//                       controller: sportTypeControllers[index],
//                       hintText: 'Sport Type',
//                       hintStyle: TextStyle(color: Colors.grey),
//                       filled: true,
//                     ),
//                     SizedBox(height: 10),

//                     /// Pitch Size
//                     CustomTextFormField(
//                       controller: sizeControllers[index],
//                       hintText: 'Pitch Size (e.g., 50x100)',
//                       hintStyle: TextStyle(color: Colors.grey),
//                       filled: true,
//                     ),
//                     SizedBox(height: 10),

//                     /// Reactive Availability fields for this pitch
//                     Obx(
//                       () => Column(
//                         children: List.generate(
//                           availabilityDayControllers[index].length,
//                           (availIndex) => Padding(
//                             padding: const EdgeInsets.only(bottom: 12.0),
//                             child: Row(
//                               children: [
//                                 /// Day
//                                 Expanded(
//                                   flex: 1,
//                                   child: CustomTextFormField(
//                                     controller:
//                                         availabilityDayControllers[index]
//                                             [availIndex],
//                                     hintText: 'Day (e.g., Monday)',
//                                     hintStyle: TextStyle(color: Colors.grey),
//                                     filled: true,
//                                   ),
//                                 ),
//                                 SizedBox(width: 10),
//                                 // Start Time
//                                 Expanded(
//                                   flex: 1,
//                                   child: CustomTextFormField(
//                                     controller:
//                                         availabilityStartTimeControllers[index]
//                                             [availIndex],
//                                     hintText: 'Start Time (e.g., 08:00)',
//                                     hintStyle: TextStyle(color: Colors.grey),
//                                     filled: true,
//                                   ),
//                                 ),
//                                 SizedBox(width: 10),
//                                 // End Time
//                                 Expanded(
//                                   flex: 1,
//                                   child: CustomTextFormField(
//                                     controller:
//                                         availabilityEndTimeControllers[index]
//                                             [availIndex],
//                                     hintText: 'End Time (e.g., 20:00)',
//                                     hintStyle: TextStyle(color: Colors.grey),
//                                     filled: true,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         log('Add Another Availability Button pressed!');
//                         availabilityDayControllers[index]
//                             .add(TextEditingController());
//                         availabilityStartTimeControllers[index]
//                             .add(TextEditingController());
//                         availabilityEndTimeControllers[index]
//                             .add(TextEditingController());
//                         // Refresh to rebuild the UI
//                         availabilityDayControllers.refresh();
//                         availabilityStartTimeControllers.refresh();
//                         availabilityEndTimeControllers.refresh();
//                       },
//                       child: Text('Add Another Availability'),
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             // Collect all the pitch details and close dialog
//             for (int i = 0; i < numberOfPitches; i++) {
//               // Add pitch details logic here
//               // Collect availability for each pitch
//               List<Map<String, String>> availabilityList = [];
//               for (var j = 0; j < availabilityDayControllers[i].length; j++) {
//                 availabilityList.add({
//                   'day': availabilityDayControllers[i][j].text,
//                   'startTime': availabilityStartTimeControllers[i][j].text,
//                   'endTime': availabilityEndTimeControllers[i][j].text,
//                 });
//               }
//               // Add pitch details to the pitches list
//               pitches.add({
//                 'pitchName': pitchNameControllers[i].text,
//                 'sportType': sportTypeControllers[i].text,
//                 'size': sizeControllers[i].text,
//                 'availability': availabilityList,
//               });
//             }
//             Get.back();
//           },
//           child: Text('Add Pitches'),
//         ),
//         TextButton(
//           onPressed: () {
//             Get.back();
//           },
//           child: Text('Cancel'),
//         ),
//       ],
//     ),
//   );
// }
