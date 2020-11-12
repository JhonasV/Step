import 'package:flutter/material.dart';

import 'create_labor_experiences_screen.dart';
import 'listview_labor_experiences.dart';

class LaborExperiencesScreen extends StatefulWidget {
  static final String id = "labor_experiences_screen";
  @override
  _LaborExperiencesScreen createState() => _LaborExperiencesScreen();
}

class _LaborExperiencesScreen extends State<LaborExperiencesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue,
            title: Text("Gestión de Experiencia Laboral"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateLaborExperiencesScreen(),
                ),
              );
            },
            child: Icon(Icons.add),
            elevation: 10.0,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: ListViewLaborExperience(),
        ),
      ),
    );
  }
}
