import 'package:Step/models/labor_experiences.dart';
import 'package:Step/models/taskresult.dart';
import 'package:Step/screens/laborexperiences/create_labor_experiences_screen.dart';
import 'package:Step/services/auth_service.dart';
import 'package:Step/services/labor_experience_service.dart';
import 'package:Step/services/languages_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListViewLaborExperience extends StatefulWidget {
  final String id = "listview_LaborExperience_screen";
  _ListViewLaborExperienceState createState() =>
      _ListViewLaborExperienceState();
}

class _ListViewLaborExperienceState extends State<ListViewLaborExperience> {
  List<LaborExperiences> _laborExperiences = [], _auxLaborExperiences = [];
  bool _isLoading = true,
      _deletingLoading = false,
      _noLaborExperiencesAdded = false;
  _setupFetchLaborExperiences() async {
    var currentUser = await AuthService.current();
    TaskResult<List<LaborExperiences>> laborExperiencesFuture;
    var isAdmin = currentUser.data.roles.any((e) => e.name.contains("admin"));
    if (!isAdmin) {
      laborExperiencesFuture =
          await LaborExperiencesService.getAllByCurrentUser(
              currentUser.data.id);
    } else {
      laborExperiencesFuture = await LaborExperiencesService.getAll();
    }

    setState(() {
      _laborExperiences = laborExperiencesFuture.data;
      _auxLaborExperiences = laborExperiencesFuture.data;
      _isLoading = !_isLoading;
      _noLaborExperiencesAdded = laborExperiencesFuture.data.length == 0;
    });
  }

  Column _buildList() {
    List<Container> listTiles = [];
    _laborExperiences.forEach((element) {
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
    _setupFetchLaborExperiences();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: Center(child: CircularProgressIndicator()))
        : _noLaborExperiencesAdded
            ? Container(
                margin: EdgeInsets.only(top: 60.0),
                alignment: Alignment.topCenter,
                child: Text(
                  "No has agregado ninguna experiencia laboral...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
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
      setState(() => _laborExperiences = _auxLaborExperiences);
    } else {
      var filteredCompentencies = _laborExperiences
          .where((e) => e.position.toLowerCase().contains(input.toLowerCase()))
          .toList();

      setState(() => _laborExperiences = filteredCompentencies);
    }
  }

  Container _buildListTile(LaborExperiences item) {
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
          backgroundColor: Colors.green,
        ),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Salario ${item.salary} | ${item.company}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          Text(
            "Desde ${item.initialDate.toString().split(' ')[0]} | Hasta ${item.endDate.toString().split(' ')[0]}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
        ]),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                item.position,
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
                      var result =
                          await LaborExperiencesService.delete(item.id);
                      if (result.success) {
                        var tempLaborExperiences = _laborExperiences;
                        tempLaborExperiences.remove(item);
                        setState(() {
                          _laborExperiences = tempLaborExperiences;
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreateLaborExperiencesScreen(
                            laborExperiences: item),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
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
