//import graphic design
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controller for control input
  var newTaskCtrl = TextEditingController();

  //constructor
  _HomePageState() {
    load();
  }
  //method responsible to add item
  void add() {
    //check value blank
    if (newTaskCtrl.text.isEmpty) return;

    //update variable state
    setState(() {
      widget.items.add(Item(title: newTaskCtrl.text, done: false));
      newTaskCtrl.clear();
    });
    save();
  }

  //Method responsible to remove item
  void remove(int index) {
    setState(() {
      widget.items.removeAt(index);
    });
    save();
  }

  //method responsible to read storage
  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((e) => Item.fromJson(e)).toList();
      //update items
      setState(() {
        widget.items = result;
      });
    }
  }

  //method responsible to save information in shared preferences
  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
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
                  save();
                });
              },
            ),
            key: Key(item.title),
            background: Container(
              color: Colors.red.withOpacity(0.2),
            ),
            onDismissed: (direction) {
              remove(index);
            },
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
