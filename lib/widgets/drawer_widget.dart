import 'package:Step/models/drawer_menu_item.dart';
import 'package:Step/models/taskresult.dart';
import 'package:Step/models/user.dart';
import 'package:Step/screens/home_screen.dart';
import 'package:Step/screens/login_screen.dart';
import 'package:Step/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  User _user;
  bool _loading = false, _isLoadinMenuItems = false;
  List<Widget> menuElements = [];
  @override
  void initState() {
    super.initState();
    _setupFunctions();
  }

  Future<User> _setupCurrentUser() async {
    setState(() => _loading = !_loading);
    TaskResult<User> result = await AuthService.current();
    setState(() => _user = result.data);
    return result.data;
  }

  List<DrawerMenuItem> _getMenuItems() {
    List<DrawerMenuItem> items = [];
    var item3 = new DrawerMenuItem();
    item3.title = "Inicio";
    item3.access = ["admin", "applicant"];
    item3.icon = Icons.home;
    item3.onTap = () => Navigator.of(context).pushNamed(HomeScreen.id);
    items.add(item3);
    var item1 = new DrawerMenuItem();
    item1.title = "Perfil";
    item1.access = ["applicant", "admin"];
    item1.icon = FontAwesomeIcons.userAlt;
    item1.onTap = () => Navigator.of(context).pushNamed(HomeScreen.id);
    items.add(item1);
    var item2 = new DrawerMenuItem();
    item2.title = "Gestión";
    item2.access = ["admin"];
    item2.icon = Icons.settings;
    item2.onTap = () => Navigator.of(context).pushNamed(HomeScreen.id);
    items.add(item2);
    var item4 = new DrawerMenuItem();
    item4.title = "Cerrar Sesión";
    item4.access = ["admin", "applicant"];
    item4.icon = FontAwesomeIcons.signOutAlt;
    item4.onTap = () async {
      var result = await AuthService.logOut();
      if (result.data) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(LoginScreen.id, (Route route) => false);
      }
    };
    items.add(item4);

    return items;
  }

  _setupFunctions() async {
    setState(() => _isLoadinMenuItems = !_isLoadinMenuItems);
    var user = await _setupCurrentUser();
    _setupMenuItems(user);
  }

  void _setupMenuItems(User currentUser) {
    var menuItems = _getMenuItems();
    List<Widget> menuEl = [];
    var size = MediaQuery.of(context).size;
    menuEl.add(Container(
      height: size.height * .25,
      child: DrawerHeader(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .02, vertical: 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Menu",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            icon: Icon(Icons.arrow_forward),
                            color: Colors.blue,
                            onPressed: () => Navigator.of(context).pop())
                      ],
                    )
                  ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .02, vertical: size.height * .02),
              child: Row(
                children: [
                  CircleAvatar(radius: 30),
                  SizedBox(width: 10),
                  Text(
                    _user.userName,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
    ));
    for (var item in menuItems) {
      for (var role in currentUser.roles) {
        if (item.access.contains(role.name)) {
          menuEl.add(_buildListTile(item));
          break;
        }
      }
    }

    setState(() {
      menuElements = menuEl;
      _isLoadinMenuItems = !_isLoadinMenuItems;
    });
  }

  ListTile _buildListTile(DrawerMenuItem item) {
    return ListTile(
      title: Text(
        item.title,
        style: TextStyle(
          fontSize: 19.0,
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () => item.onTap(),
      leading: Icon(item.icon, color: Colors.blue),
      trailing: Icon(Icons.arrow_right, color: Colors.blue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: _isLoadinMenuItems
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.zero,
              children: menuElements,
            ),
    );
  }
}
