import 'package:Step/screens/jobpositions/create_jobpositions.dart';
import 'package:flutter/material.dart';

import 'listview_jobpositions.dart';

class JobPositionsScreen extends StatefulWidget {
  static final String id = "jobpositions_screen";
  @override
  _JobPositionsState createState() => _JobPositionsState();
}

class _JobPositionsState extends State<JobPositionsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue,
            title: Text("Gestión de Posiciones de trabajo"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateJobPositionsScreen(),
                ),
              );
            },
            child: Icon(Icons.add),
            elevation: 10.0,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: ListViewJobPositions(),
        ),
      ),
    );
  }
}
