// import 'package:draggable_scrollbar/draggable_scrollbar.dart';
// import 'package:flutter/material.dart';
//
// class NextPAge extends StatefulWidget {
//   @override
//   _NextPAgeState createState() => _NextPAgeState();
// }
//
// class _NextPAgeState extends State<NextPAge> {
//
//   ScrollController _controller = ScrollController();
//
//   final itemExtent = 100.0;
//
//
//
//   List<TextEditingController> _controllers = [];
//   String _selectedDropdownValue = 'Option 1';
//   int _selectedRadioValue = 0;
//   final ScrollController _scrollController = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         child: DraggableScrollbar.semicircle(
//           child: ListView(
//             controller: _controller,
//             children: [
//             DropdownButtonFormField<String>(
//             value: _selectedDropdownValue,
//             onChanged: (newValue) {
//               setState(() {
//                 _selectedDropdownValue = newValue;
//               });
//             },
//             items: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
//                 .map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//             decoration: InputDecoration(
//               labelText: 'Dropdown',
//               border: OutlineInputBorder(),
//             ),
//           ),
//             SizedBox(height: 8),
//             RadioListTile<int>(
//               title: Text('Radio Button 1'),
//               value: 0,
//               groupValue: _selectedRadioValue,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedRadioValue = value;
//                 });
//               },
//             ),
//             RadioListTile<int>(
//               title: Text('Radio Button 2'),
//               value: 1,
//               groupValue: _selectedRadioValue,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedRadioValue = value;
//                 });
//               },
//             ),
//             SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: _selectedDropdownValue,
//                 onChanged: (newValue) {
//                   setState(() {
//                     _selectedDropdownValue = newValue;
//                   });
//                 },
//                 items: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 decoration: InputDecoration(
//                   labelText: 'Dropdown',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 8),
//               RadioListTile<int>(
//                 title: Text('Radio Button 1'),
//                 value: 0,
//                 groupValue: _selectedRadioValue,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedRadioValue = value;
//                   });
//                 },
//               ),
//               RadioListTile<int>(
//                 title: Text('Radio Button 2'),
//                 value: 1,
//                 groupValue: _selectedRadioValue,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedRadioValue = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: _selectedDropdownValue,
//                 onChanged: (newValue) {
//                   setState(() {
//                     _selectedDropdownValue = newValue;
//                   });
//                 },
//                 items: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 decoration: InputDecoration(
//                   labelText: 'Dropdown',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 8),
//               RadioListTile<int>(
//                 title: Text('Radio Button 1'),
//                 value: 0,
//                 groupValue: _selectedRadioValue,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedRadioValue = value;
//                   });
//                 },
//               ),
//               RadioListTile<int>(
//                 title: Text('Radio Button 2'),
//                 value: 1,
//                 groupValue: _selectedRadioValue,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedRadioValue = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: _selectedDropdownValue,
//                 onChanged: (newValue) {
//                   setState(() {
//                     _selectedDropdownValue = newValue;
//                   });
//                 },
//                 items: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 decoration: InputDecoration(
//                   labelText: 'Dropdown',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 8),
//               RadioListTile<int>(
//                 title: Text('Radio Button 1'),
//                 value: 0,
//                 groupValue: _selectedRadioValue,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedRadioValue = value;
//                   });
//                 },
//               ),
//               RadioListTile<int>(
//                 title: Text('Radio Button 2'),
//                 value: 1,
//                 groupValue: _selectedRadioValue,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedRadioValue = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: _selectedDropdownValue,
//                 onChanged: (newValue) {
//                   setState(() {
//                     _selectedDropdownValue = newValue;
//                   });
//                 },
//                 items: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 decoration: InputDecoration(
//                   labelText: 'Dropdown',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 8),
//               RadioListTile<int>(
//                 title: Text('Radio Button 1'),
//                 value: 0,
//                 groupValue: _selectedRadioValue,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedRadioValue = value;
//                   });
//                 },
//               ),
//               RadioListTile<int>(
//                 title: Text('Radio Button 2'),
//                 value: 1,
//                 groupValue: _selectedRadioValue,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedRadioValue = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: _selectedDropdownValue,
//                 onChanged: (newValue) {
//                   setState(() {
//                     _selectedDropdownValue = newValue;
//                   });
//                 },
//                 items: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 decoration: InputDecoration(
//                   labelText: 'Dropdown',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 8),
//               RadioListTile<int>(
//                 title: Text('Radio Button 1'),
//                 value: 0,
//                 groupValue: _selectedRadioValue,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedRadioValue = value;
//                   });
//                 },
//               ),
//               RadioListTile<int>(
//                 title: Text('Radio Button 2'),
//                 value: 1,
//                 groupValue: _selectedRadioValue,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedRadioValue = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: _selectedDropdownValue,
//                 onChanged: (newValue) {
//                   setState(() {
//                     _selectedDropdownValue = newValue;
//                   });
//                 },
//                 items: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 decoration: InputDecoration(
//                   labelText: 'Dropdown',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 8),
//               RadioListTile<int>(
//                 title: Text('Radio Button 1'),
//                 value: 0,
//                 groupValue: _selectedRadioValue,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedRadioValue = value;
//                   });
//                 },
//               ),
//               RadioListTile<int>(
//                 title: Text('Radio Button 2'),
//                 value: 1,
//                 groupValue: _selectedRadioValue,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedRadioValue = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: _selectedDropdownValue,
//                 onChanged: (newValue) {
//                   setState(() {
//                     _selectedDropdownValue = newValue;
//                   });
//                 },
//                 items: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 decoration: InputDecoration(
//                   labelText: 'Dropdown',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 8),
//               RadioListTile<int>(
//                 title: Text('Radio Button 1'),
//                 value: 0,
//                 groupValue: _selectedRadioValue,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedRadioValue = value;
//                   });
//                 },
//               ),
//               RadioListTile<int>(
//                 title: Text('Radio Button 2'),
//                 value: 1,
//                 groupValue: _selectedRadioValue,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedRadioValue = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 8),
//             // Display multiple text fields using ListView.builder
//
//             ]
//         ),
//           // child: ListView.builder(
//           //   itemCount: 100,
//           //   controller: _controller,
//           //   itemExtent: itemExtent,
//           //   itemBuilder: (context,index){
//           //     return Container(
//           //       child: ListTile(
//           //         title: Text(index.toString()),
//           //         subtitle: Text('More...............'),
//           //       ),
//           //     );
//           //   },
//           // ),
//           controller: _controller,
//           backgroundColor: Colors.lightGreenAccent,
//           labelConstraints: BoxConstraints.tightFor(width: 80,height: 40),
//           labelTextBuilder: (double offset)=> Text('${offset ~/ itemExtent}'),
//           alwaysVisibleScrollThumb: true,
//           heightScrollThumb: 48.0,
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
