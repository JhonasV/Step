import 'package:Step/models/jobpositions.dart';
import 'package:Step/services/jobpositions_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'create_jobpositions.dart';

class ListViewJobPositions extends StatefulWidget {
  final String id = "listview_JobPositions_screen";
  _ListViewJobPositionsState createState() => _ListViewJobPositionsState();
}

class _ListViewJobPositionsState extends State<ListViewJobPositions> {
  List<JobPositions> _jobPositions = [], _auxJobPositions = [];
  bool _isLoading = true,
      _deletingLoading = false,
      _noJobPositionsAdded = false;
  _setupFetchJobPositions() async {
    var jobPositionsFuture = await JobPositionsService.getAll();
    setState(() {
      _jobPositions = jobPositionsFuture;
      _auxJobPositions = jobPositionsFuture;
      _isLoading = !_isLoading;
      _noJobPositionsAdded = jobPositionsFuture.length == 0;
    });
  }

  Column _buildList() {
    List<Container> listTiles = [];
    _jobPositions.forEach((element) {
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
    _setupFetchJobPositions();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: Center(child: CircularProgressIndicator()))
        : _noJobPositionsAdded
            ? Container(
                margin: EdgeInsets.only(top: 60.0),
                alignment: Alignment.topCenter,
                child: Text(
                  "No hay lenguajes creados...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              )
            : Column(
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
      setState(() => _jobPositions = _auxJobPositions);
    } else {
      var filteredCompentencies = _jobPositions
          .where((e) => e.name.toLowerCase().contains(input.toLowerCase()))
          .toList();

      setState(() => _jobPositions = filteredCompentencies);
    }
  }

  Container _buildListTile(JobPositions item) {
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
        subtitle: Text(
          "Salario ${item.salaryMinLevel} - ${item.salaryMaxLevel}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        leading: CircleAvatar(
          backgroundColor: item.status == 1 ? Colors.green : Colors.grey,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                item.name,
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
                      var result = await JobPositionsService.delete(item.id);
                      if (result.success) {
                        var tempJobPositions = _jobPositions;
                        tempJobPositions.remove(item);
                        setState(() {
                          _jobPositions = tempJobPositions;
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
                        builder: (context) =>
                            CreateJobPositionsScreen(jobPositions: item),
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
