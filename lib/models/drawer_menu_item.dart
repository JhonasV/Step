import 'package:flutter/material.dart';

class DrawerMenuItem {
  String title;
  List<String> access;
  IconData icon;
  dynamic onTap;
  DrawerMenuItem({this.title, this.access, this.icon, this.onTap});
}
