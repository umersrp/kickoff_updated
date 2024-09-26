import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DemoApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {

  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draggable Scroll Bar'),
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> NextPAge()));
              }
          )
        ],
      ),
      body: DraggableScrollbar.semicircle(
       // child: Container(
       //  height: 500,
       //  child: Text(""),
       // )
        child: ListView.builder(
          itemCount: 100,
          controller: _controller,
          itemBuilder: (context, index){
            return Container(
              child: ListTile(
                title: Text(index.toString()),
                subtitle: Text('More!.................'),
              ),
            );
          },
        ),
        controller: _controller,
        backgroundColor: Colors.blue,
        heightScrollThumb: 40.0,
        alwaysVisibleScrollThumb: false,
      ),
    );
  }
}














