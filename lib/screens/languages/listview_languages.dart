import 'package:Step/models/languages.dart';
import 'package:Step/screens/languages/create_languages.dart';
import 'package:Step/services/languages_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListViewLanguages extends StatefulWidget {
  final String id = "listview_Languages_screen";
  _ListViewLanguagesState createState() => _ListViewLanguagesState();
}

class _ListViewLanguagesState extends State<ListViewLanguages> {
  List<Languages> languages = [];
  bool _isLoading = true, deletingLoading = false, _noLanguagesAdded = false;
  _setupFetchLanguages() async {
    var languagesFuture = await LanguagesService.getAll();
    setState(() {
      languages = languagesFuture;
      _isLoading = !_isLoading;
      _noLanguagesAdded = languagesFuture.length == 0;
    });
  }

  List<Container> _buildList() {
    List<Container> listTiles = [];
    languages.forEach((element) {
      listTiles.add(_buildListTile(element));
    });

    return listTiles;
  }

  @override
  void initState() {
    super.initState();
    _setupFetchLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: Center(child: CircularProgressIndicator()))
        : _noLanguagesAdded
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
            : ListView(children: _buildList());
  }

  Container _buildListTile(Languages item) {
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
                      setState(() => deletingLoading != deletingLoading);
                      var result = await LanguagesService.delete(item.id);
                      if (result.success) {
                        var tempLanguages = languages;
                        tempLanguages.remove(item);
                        setState(() {
                          languages = tempLanguages;
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
                            CreateLanguagesScreen(languages: item),
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
