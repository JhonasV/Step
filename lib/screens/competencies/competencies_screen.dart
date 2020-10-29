import 'package:Step/screens/competencies/create_competencies.dart';
import 'package:Step/screens/competencies/listview_competencies.dart';
import 'package:Step/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class CompentenciesScreen extends StatefulWidget {
  static final String id = "compentencies_screen";
  @override
  _CompentenciesState createState() => _CompentenciesState();
}

class _CompentenciesState extends State<CompentenciesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          drawer: DrawerWidget(),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue,
            title: Text("Gestión de Competencias"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateCompentenciesScreen())),
            child: Icon(Icons.add),
            elevation: 10.0,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: ListViewCompetencies(),
        ),
      ),
    );
  }
}
