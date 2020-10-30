import 'package:Step/models/competencies.dart';
import 'package:Step/models/languages.dart';
import 'package:Step/models/taskresult.dart';
import 'package:Step/screens/home_screen.dart';
import 'package:Step/screens/languages/languages_screen.dart';
import 'package:Step/services/languages_service.dart';

import 'package:Step/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class CreateLanguagesScreen extends StatefulWidget {
  static final String id = "create_languages_screen";
  final Languages languages;
  CreateLanguagesScreen({this.languages});
  @override
  _CreateLanguagesState createState() => _CreateLanguagesState();
}

class _CreateLanguagesState extends State<CreateLanguagesScreen> {
  var _formKey = GlobalKey<FormState>();
  String _name, _status;
  bool _isLoading = false, _isUpdated = false;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  _submit() async {
    if (_formKey.currentState.validate()) {
      setState(() => _isLoading = !_isLoading);
      _formKey.currentState.save();

      var lang = Languages(
        name: _name,
        status: _status == "activo" ? 1 : 0,
        id: widget?.languages?.id,
      );
      var result = TaskResult<bool>();
      _isUpdated
          ? result = await LanguagesService.update(lang)
          : result = await LanguagesService.create(lang);

      if (!result.success) {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text(result.messages)));
        return;
      }

      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.id, (Route<dynamic> route) => false);
      Navigator.of(context).pushNamed(LanguagesScreen.id);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.languages != null) {
      _name = widget.languages.name;
      _status = widget.languages.status == 1 ? "activo" : "inactivo";
      _isUpdated = !_isUpdated;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: _scaffoldKey,
          drawer: DrawerWidget(),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue,
          ),
          body: Column(
            children: [
              _isLoading ? LinearProgressIndicator() : SizedBox.shrink(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 50.0),
                  padding: EdgeInsets.all(20.0),
                  child: ListView(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 40.0),
                        child: Text(
                          "Lenguajes",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 30.0,
                              decorationColor: Colors.orange[400]),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTextFieldTitle("Descripción"),
                            buildTextFieldDescription(""),
                            buildTextFieldTitle("Estado"),
                            buildDropDown(),
                            buildFlatButton(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTextFieldTitle(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 22.0),
      ),
    );
  }

  Container buildFlatButton() {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 40.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.blue,
      ),
      height: 45.0,
      width: double.infinity,
      child: FlatButton(
        onPressed: _isLoading ? null : _submit,
        child: Text(
          _isUpdated ? "Actualizar" : "Guardar",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 23.0,
          ),
        ),
      ),
    );
  }

  Container buildDropDown() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 40.0),
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(border: InputBorder.none),
        value: 'activo',
        items: [
          DropdownMenuItem<String>(
            child: Text('Activo'),
            value: 'activo',
          ),
          DropdownMenuItem<String>(
            child: Text('Inactivo'),
            value: 'inactivo',
          ),
        ],
        onChanged: (String newValue) => _status = newValue.trim(),
        onSaved: (String newValue) => _status = newValue.trim(),
      ),
    );
  }

  Container buildTextFieldDescription(String hintText) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        initialValue: _name,
        validator: (input) =>
            input.length < 5 ? "Ingresar mÍnimo 5 carácteres" : null,
        onSaved: (input) => _name = input.trim(),
        style: TextStyle(fontSize: 21.0),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Container buildTextFieldId(String hintText) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        style: TextStyle(fontSize: 21.0),
        readOnly: true,
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
