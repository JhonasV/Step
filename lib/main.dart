import 'package:Step/screens/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Step",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            "Step",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 27.0,
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {},
              child: Icon(Icons.settings),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(""),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.circle),
              title: Text(""),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.track_changes),
              title: Text(""),
            ),
          ],
        ),
        body: Home(),
      ),
    );
  }
}
