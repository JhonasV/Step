import 'package:Step/models/competencies.dart';
import 'package:Step/services/competencies_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListViewCompetencies extends StatefulWidget {
  final String id = "listview_competencies_screen";
  _ListViewCompetenciesState createState() => _ListViewCompetenciesState();
}

class _ListViewCompetenciesState extends State<ListViewCompetencies> {
  List<Competencies> competencies = [];
  bool _isLoading = true;
  _setupFetchCompetencies() async {
    var competenciesFuture = await CompetenciesService.getAll();
    setState(() {
      competencies = competenciesFuture;
      _isLoading = !_isLoading;
    });
  }

  List<ListTile> _buildList() {
    List<ListTile> listTiles = [];
    competencies.forEach((element) {
      listTiles.add(_buildListTile(element));
    });

    return listTiles;
  }

  @override
  void initState() {
    super.initState();
    _setupFetchCompetencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: Center(child: CircularProgressIndicator()))
        : ListView(children: _buildList());
  }

  ListTile _buildListTile(Competencies item) {
    return ListTile(
      leading: CircleAvatar(
          backgroundColor: item.status == 1 ? Colors.green : Colors.grey),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              item.description,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(FontAwesomeIcons.solidTrashAlt),
                onPressed: () => print("Delete"),
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.solidEdit),
                onPressed: () => print("Edit"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
