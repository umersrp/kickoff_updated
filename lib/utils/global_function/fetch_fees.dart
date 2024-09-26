// import 'package:flutter/material.dart';
//
// class UpdateFeesStatusScreen extends StatefulWidget {
//   @override
//   _UpdateFeesStatusScreenState createState() => _UpdateFeesStatusScreenState();
// }
//
// class _UpdateFeesStatusScreenState extends State<UpdateFeesStatusScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<void> updateFeesStatus() async {
//     try {
//       // Get all documents in the Academy collection
//       QuerySnapshot academySnapshot = await _firestore.collection('Academy').get();
//
//       // Create a list of futures for updating each document
//       List<Future<void>> updateFutures = [];
//
//       for (QueryDocumentSnapshot academyDoc in academySnapshot.docs) {
//         // Get all documents in the 'Admission' subcollection
//         QuerySnapshot admissionSnapshot = await academyDoc.reference.collection('Admission').get();
//
//         for (QueryDocumentSnapshot admissionDoc in admissionSnapshot.docs) {
//           // Add update operation to the list of futures
//           updateFutures.add(admissionDoc.reference.update({
//             'fees_status': false // Set fees_status to false
//           }));
//         }
//       }
//
//       // Wait for all updates to complete
//       await Future.wait(updateFutures);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All documents updated with fees_status set to false.')));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating documents: $e')));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Update Fees Status')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await updateFeesStatus();
//           },
//           child: Text('Update All Documents'),
//         ),
//       ),
//     );
//   }
// }
