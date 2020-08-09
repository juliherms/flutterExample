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
  //text controller for control input
  var newTaskCtrl = TextEditingController();

  //method responsible to add item
  void add() {
    //check value blank
    if (newTaskCtrl.text.isEmpty) return;

    //update variable state
    setState(() {
      widget.items.add(Item(title: newTaskCtrl.text, done: false));
      newTaskCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //specific widget represents page
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            labelText: "New TODO",
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length, //size from my items
        itemBuilder: (BuildContext ctx, int index) {
          //how to show item in the screen
          final item = widget.items[index];
          return Dismissible(
            child: CheckboxListTile(
              title: Text(item.title),
              value: item.done,
              onChanged: (value) {
                //state required to update value
                setState(() {
                  item.done = value;
                });
              },
            ),
            key: Key(item.title),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add, //call add function
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
