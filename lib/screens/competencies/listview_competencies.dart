import 'package:Step/models/competencies.dart';
import 'package:Step/services/competencies_service.dart';
import 'package:Step/screens/competencies/create_competencies.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListViewCompetencies extends StatefulWidget {
  final String id = "listview_competencies_screen";
  _ListViewCompetenciesState createState() => _ListViewCompetenciesState();
}

class _ListViewCompetenciesState extends State<ListViewCompetencies> {
  List<Competencies> _competencies = [], _auxCompentencies = [];
  String _query;
  bool _isLoading = true,
      _deletingLoading = false,
      _noCompetenciesAdded = false;
  _setupFetchCompetencies() async {
    var result = await CompetenciesService.getAll();
    setState(() {
      _competencies = result.data;
      _auxCompentencies = result.data;
      _isLoading = !_isLoading;
      _noCompetenciesAdded = result.data.length == 0;
    });
  }

  Column _buildList() {
    List<Container> listTiles = [];
    _competencies.forEach((element) {
      listTiles.add(_buildListTile(element));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: listTiles,
    );
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
        : _noCompetenciesAdded
            ? Container(
                margin: EdgeInsets.only(top: 60.0),
                alignment: Alignment.topCenter,
                child: Text(
                  "No hay competencias creadas...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              )
            : ListView(
                children: [
                  _buildTextFieldSearch(),
                  Expanded(child: _buildList())
                ],
              );
  }

  Container _buildTextFieldSearch() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue), color: Colors.white),
      child: TextFormField(
        onChanged: (input) => _filterManager(input),
        decoration:
            InputDecoration(icon: Icon(Icons.search), border: InputBorder.none),
      ),
    );
  }

  void _filterManager(String input) {
    if (input.length < 3) {
      setState(() => _competencies = _auxCompentencies);
    } else {
      var filteredCompentencies = _competencies
          .where(
              (e) => e.description.toLowerCase().contains(input.toLowerCase()))
          .toList();

      setState(() => _competencies = filteredCompentencies);
    }
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
                  onPressed: () async {
                    bool deleted = await showAlertDialog(
                        "¿Seguro de eliminar este recurso?", context);

                    if (deleted) {
                      setState(() => _deletingLoading != _deletingLoading);
                      var result = await CompetenciesService.delete(item.id);
                      if (result.success) {
                        var tempCompetencies = _competencies;
                        tempCompetencies.remove(item);
                        setState(() {
                          _competencies = tempCompetencies;
                          _deletingLoading = false;
                        });
                      } else {
                        await showAlertDialog(
                          "Hubo un error al intentar eliminar el recurso, intente más tarde.",
                          context,
                        );
                      }
                    }
                  },
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.solidEdit,
                      color: Colors.yellow[300]),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            CreateCompentenciesScreen(competencies: item)));
                  },
                ),
              ],
            )
          ],
        ),
        // trailing: Icon(FontAwesomeIcons.arrowAltCircleRight),
      ),
    );
  }

  Future<bool> showAlertDialog(String text, BuildContext context) async {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ADVERTENCIA"),
      content: _deletingLoading
          ? Center(child: CircularProgressIndicator())
          : Text(text),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        FlatButton(
          child: Text("CANCELAR"),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    );

    bool result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

    return result;
  }
}
