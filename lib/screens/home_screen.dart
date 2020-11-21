import 'package:Step/models/roles.dart';
import 'package:Step/models/user.dart';
import 'package:Step/services/auth_service.dart';
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
  List<StepMenu> menuItems = [];
  bool _isLoading = false;
  Future<User> _getCurrentUser() async {
    var result = await AuthService.current();
    return result.data;
  }

  Future<void> _buildMenuItems() async {
    setState(() => _isLoading = !_isLoading);
    List<StepMenu> items = [];
    var currentUser = await _getCurrentUser();
    List<String> itemAccess = [];
    for (var item in stepMenuItems) {
      for (Roles role in currentUser.roles) {
        itemAccess = item['access'] as List<String>;
        if (itemAccess.contains(role.name)) {
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
          break;
        }
      }
    }

    setState(() {
      menuItems = items;
      _isLoading = !_isLoading;
    });
  }

  @override
  void initState() {
    super.initState();
    _buildMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(
          "Step",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27.0,
              decorationColor: Colors.orange[400]),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      return StepMenu(
                        title: menuItems[index].title,
                        subtitle: menuItems[index].subtitle,
                        icon: menuItems[index].icon,
                        imageUrl: menuItems[index].imageUrl,
                        color1: menuItems[index].color1,
                        color2: menuItems[index].color2,
                        screenPath: menuItems[index].screenPath,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
