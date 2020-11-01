import 'package:Step/models/competencies.dart';
import 'package:Step/models/taskresult.dart';
import 'package:Step/screens/home_screen.dart';
import 'package:Step/services/competencies_service.dart';
import 'package:Step/screens/competencies/competencies_screen.dart';
import 'package:Step/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateCompentenciesScreen extends StatefulWidget {
  static final String id = "create_compentencies_screen";
  final Competencies competencies;
  CreateCompentenciesScreen({this.competencies});
  @override
  _CreateCompentenciesState createState() => _CreateCompentenciesState();
}

class _CreateCompentenciesState extends State<CreateCompentenciesScreen> {
  var _formKey = GlobalKey<FormState>();
  String _description, _status;
  bool _isLoading = false, _isUpdated = false;

  _submit() async {
    if (_formKey.currentState.validate()) {
      setState(() => _isLoading = !_isLoading);
      _formKey.currentState.save();

      var comp = Competencies(
        description: _description,
        status: _status == "activo" ? 1 : 0,
        id: widget?.competencies?.id,
      );
      var result = TaskResult<bool>();
      _isUpdated
          ? result = await CompetenciesService.update(comp)
          : result = await CompetenciesService.create(comp);

      if (!result.success) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(result.messages)));
        return;
      }

      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.id, (Route<dynamic> route) => false);
      Navigator.of(context).pushNamed(CompentenciesScreen.id);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.competencies != null) {
      _description = widget.competencies.description;
      _status = widget.competencies.status == 1 ? "activo" : "inactivo";
      _isUpdated = !_isUpdated;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
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
                          "Compentencias",
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
        initialValue: _description,
        validator: (input) =>
            input.length < 5 ? "Ingresar mÍnimo 5 carácteres" : null,
        onSaved: (input) => _description = input.trim(),
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
