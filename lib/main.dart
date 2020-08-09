//import graphic design
import 'package:flutter/material.dart';

import 'models/item.dart';

//principal function
void main() {
  runApp(MyApp());
}

//principal class
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Material App - Principal Item - always return MaterialApp
    return MaterialApp(
      title: 'TODO App',
      debugShowCheckedModeBanner: false, //disable show's debug
      theme: ThemeData(
        primarySwatch: Colors.blue, //color of application
      ),
      home: HomePage(),
    );
  }
}

//My class Home
class HomePage extends StatefulWidget {
  //list of todo's
  var items = new List<Item>();

  //constructor
  HomePage() {
    items = [];
    //populate my items
    items.add(Item(title: "Item 1", done: false));
    items.add(Item(title: "Item 2", done: true));
    items.add(Item(title: "Item 3", done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //specific widget represents page
      appBar: AppBar(
        title: Text("TODO List"),
      ),
      body: ListView.builder(
        itemCount: widget.items.length, //size from my items
        itemBuilder: (BuildContext ctx, int index) {
          //how to show item in the screen
          return Text(widget.items[index].title);
        },
      ),
    );
  }
}
