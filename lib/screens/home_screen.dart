import 'package:Step/widgets/drawer_widget.dart';
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
  // _setCurrentUser() async {}
  List<StepMenu> _buildMenuItems() {
    List<StepMenu> items = [];
    Map<String, dynamic> currentUser = {
      "name": "Nelson",
      "lastName": "Veras",
      "access": ["admin"]
    };
    List<String> userAccess = currentUser["access"];
    List<String> screenAccess = [];
    stepMenuItems.forEach((item) {
      screenAccess = item["access"];
      userAccess.forEach((String access) {
        if (screenAccess.contains(access)) {
          items.add(
            StepMenu(
              title: item["title"],
              subtitle: item["subtitle"],
              icon: item["icon"],
              imageUrl: item["imageUrl"],
              color1: item["color1"],
              color2: item["color2"],
              screenPath: item["screenPath"],
            ),
          );
        }
      });
    });

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        // iconTheme: new IconThemeData(color: Colors.blue, size: 40.0),
        // backgroundColor: Color.fromRGBO(248, 249, 255, 0.5),
        title: Text(
          "Step",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27.0,
              decorationColor: Colors.orange[400]),
        ),
        centerTitle: true,
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: stepMenuItems.length,
              itemBuilder: (context, index) {
                return StepMenu(
                  title: stepMenuItems[index]["title"],
                  subtitle: stepMenuItems[index]["subtitle"],
                  icon: stepMenuItems[index]["icon"],
                  imageUrl: stepMenuItems[index]["imageUrl"],
                  color1: stepMenuItems[index]["color1"],
                  color2: stepMenuItems[index]["color2"],
                  screenPath: stepMenuItems[index]["screenPath"],
                );
              },
              // children: _buildMenuItems(),
            ),
          ),
        ],
      ),
    );
  }
}
