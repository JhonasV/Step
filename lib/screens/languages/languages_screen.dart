import 'package:Step/screens/competencies/listview_competencies.dart';
import 'package:Step/screens/languages/create_languages.dart';
import 'package:Step/screens/languages/listview_languages.dart';
import 'package:Step/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class LanguagesScreen extends StatefulWidget {
  static final String id = "languages_screen";
  @override
  _LanguagesState createState() => _LanguagesState();
}

class _LanguagesState extends State<LanguagesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue,
            title: Text("Gestión de Lenguajes"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateLanguagesScreen(),
                ),
              );
            },
            child: Icon(Icons.add),
            elevation: 10.0,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: ListViewLanguages(),
        ),
      ),
    );
  }
}
