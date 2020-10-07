import 'package:Step/widgets/step_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:Step/config/menu.dart';

class HomeScreen extends StatefulWidget {
  static final String id = "home_screen";
  HomeScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildMenuItems() {
    List<Widget> items = [];
    stepMenuItems.forEach((element) {
      items.add(StepMenu(
        title: element["title"],
        subtitle: element["subtitle"],
        icon: element["icon"],
        imageUrl: element["imageUrl"],
        color1: element["color1"],
        color2: element["color2"],
      ));
    });

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Step",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 27.0,
              decorationColor: Colors.orange[400]),
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
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 2.3,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 5.0,
                children: _buildMenuItems(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
