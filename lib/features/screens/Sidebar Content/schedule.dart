import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<ScheduleItem> _scheduleItems = [
    ScheduleItem(time: '8:00 AM', title: 'Breakfast'),
    ScheduleItem(time: '9:00 AM', title: 'Meeting with team'),
    ScheduleItem(time: '11:00 AM', title: 'Client call'),
    ScheduleItem(time: '12:00 PM', title: 'Lunch'),
    ScheduleItem(time: '2:00 PM', title: 'Design review'),
    ScheduleItem(time: '4:00 PM', title: 'Exercise'),
    ScheduleItem(time: '6:00 PM', title: 'Dinner'),
  ];

  void _addScheduleItem() {
    setState(() {
      _scheduleItems.add(ScheduleItem(time: '', title: ''));
    });
  }

  void _removeScheduleItem(int index) {
    setState(() {
      _scheduleItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red,
        title: Text('Schedule'),
      ),
      body: ListView.builder(
        itemCount: _scheduleItems.length,
        itemBuilder: (context, index) {
          return _buildScheduleItem(index);
        },
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.red,
        onPressed: _addScheduleItem,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }

  Widget _buildScheduleItem(int index) {
    return ListTile(
      leading: Text(
        _scheduleItems[index].time,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      title: TextFormField(
        initialValue: _scheduleItems[index].title,
        decoration: InputDecoration(
          hintText: 'Title',
        ),
        onChanged: (value) {
          setState(() {
            _scheduleItems[index].title = value;
          });
        },
      ),
      trailing: IconButton(
        icon: Icon(Icons.remove),
        onPressed: () {
          _removeScheduleItem(index);
        },
      ),
    );
  }
}

class ScheduleItem {
  String time;
  String title;

  ScheduleItem({required this.time,required this.title});
}
