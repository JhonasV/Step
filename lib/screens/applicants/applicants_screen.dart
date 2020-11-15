import 'package:flutter/material.dart';

class ApplicantsScreen extends StatefulWidget {
  static final String id = "applicants_screen";
  @override
  _ApplicantsScreenState createState() => _ApplicantsScreenState();
}

class _ApplicantsScreenState extends State<ApplicantsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mantenimiento de aplicantes"),
      ),
      body: Center(
        child: Hero(
          tag: ApplicantsScreen.id,
          child: Container(
            height: 300,
            width: 300,
            child: Text(""),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/candidates.jpg"))),
          ),
        ),
      ),
    );
  }
}
