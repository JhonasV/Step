import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.

      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 115.0,
            child: DrawerHeader(
              child: Text(
                'Nombre de Usuario',
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Inicio',
              style: TextStyle(
                fontSize: 19.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
            trailing: Icon(FontAwesomeIcons.home, color: Colors.blue),
          ),
          ListTile(
            title: Text(
              'Perfil',
              style: TextStyle(
                fontSize: 19.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
            trailing: Icon(Icons.supervised_user_circle, color: Colors.blue),
          ),
          ListTile(
            title: Text(
              'Gestión',
              style: TextStyle(
                fontSize: 19.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
            trailing: Icon(Icons.settings, color: Colors.blue),
          ),
          ListTile(
            title: Text(
              'Cerrar Sesión',
              style: TextStyle(
                fontSize: 19.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
            trailing: Icon(Icons.close, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
