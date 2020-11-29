import 'package:Step/screens/applicants/create_applicants_screen.dart';
import 'package:Step/screens/applicants/listview_applicants.dart';
import 'package:flutter/material.dart';

class ApplicantsScreen extends StatefulWidget {
  static final String id = "applicants_screen";
  final dynamic menuItem;
  ApplicantsScreen({this.menuItem});
  @override
  _ApplicantsScreenState createState() => _ApplicantsScreenState();
}

class _ApplicantsScreenState extends State<ApplicantsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Candidatos"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateApplicantsScreen(applicants: null),
            ),
          );
        },
      ),
      body: Center(
        child: ListViewApplicants(),
      ),
    );
  }
}
