import 'package:Step/models/trainings.dart';
import 'package:Step/services/trainings_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'create_trainings_screen.dart';

class ListViewTrainings extends StatefulWidget {
  final String id = "listview_Trainings_screen";
  _ListViewTrainingsState createState() => _ListViewTrainingsState();
}

class _ListViewTrainingsState extends State<ListViewTrainings> {
  List<Trainings> _trainings = [], _auxTrainings = [];
  bool _isLoading = true, deletingLoading = false, _noTrainingsAdded = false;
  _setupFetchTrainings() async {
    var result = await TrainingsService.getAll();

    if (result.success) {
      setState(() {
        _trainings = result.data;
        _auxTrainings = result.data;
        _isLoading = !_isLoading;
        _noTrainingsAdded = result.data.length == 0;
      });
    } else {
      setState(() {
        _trainings = result.data;
        _auxTrainings = result.data;
        _isLoading = !_isLoading;
        _noTrainingsAdded = false;
      });
    }
  }

  Column _buildList() {
    List<Container> listTiles = [];
    _trainings.forEach((element) {
      listTiles.add(_buildListTile(element));
    });

    return Column(
      children: listTiles,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  @override
  void initState() {
    super.initState();
    _setupFetchTrainings();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: Center(child: CircularProgressIndicator()))
        : _noTrainingsAdded
            ? Container(
                margin: EdgeInsets.only(top: 60.0),
                alignment: Alignment.topCenter,
                child: Text(
                  "No hay capacitaciones creadas...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              )
            : ListView(
                children: [
                  _buildTextFieldSearch(),
                  Expanded(child: _buildList()),
                ],
              );
  }

  Container _buildListTile(Trainings item) {
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
                      setState(() => deletingLoading != deletingLoading);
                      var result = await TrainingsService.delete(item.id);
                      if (result.success) {
                        var tempTrainings = _trainings;
                        tempTrainings.remove(item);
                        setState(() {
                          _trainings = tempTrainings;
                          deletingLoading = false;
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
                        builder: (context) =>
                            CreateTrainingsScreen(trainings: item),
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
      setState(() => _trainings = _auxTrainings);
    } else {
      var filteredCompentencies = _trainings
          .where(
              (e) => e.description.toLowerCase().contains(input.toLowerCase()))
          .toList();

      setState(() => _trainings = filteredCompentencies);
    }
  }

  Future<bool> showAlertDialog(String text, BuildContext context) async {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ADVERTENCIA"),
      content: deletingLoading
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
