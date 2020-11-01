import 'package:Step/screens/trainings/listview_trainings.dart';
import 'package:flutter/material.dart';

import 'create_trainings_screen.dart';

class TrainingsScreen extends StatefulWidget {
  static final String id = "trainings_screen";
  @override
  _TrainingsState createState() => _TrainingsState();
}

class _TrainingsState extends State<TrainingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue,
            title: Text("Gestión de Capacitaciones"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateTrainingsScreen(),
                ),
              );
            },
            child: Icon(Icons.add),
            elevation: 10.0,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: ListViewTrainings(),
        ),
      ),
    );
  }
}
