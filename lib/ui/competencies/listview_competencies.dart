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

  List<Container> _buildList() {
    List<Container> listTiles = [];
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

  Container _buildListTile(Competencies item) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: item.status == 1 ? Colors.green : Colors.grey,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                item.description,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.trash, color: Colors.red),
                  onPressed: () {
                    print("ID ${item.id} pressed");
                    // Confirm
                    // Competencies.remove(item.id)
                  },
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.solidEdit,
                      color: Colors.yellow[300]),
                  onPressed: () => print("Edit"),
                ),
              ],
            )
          ],
        ),
        // trailing: Icon(FontAwesomeIcons.arrowAltCircleRight),
      ),
    );
  }
}
