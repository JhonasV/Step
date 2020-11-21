import 'package:Step/models/competencies.dart';
import 'package:Step/models/labor_experiences.dart';
import 'package:Step/models/trainings.dart';
import 'package:flutter/material.dart';

class CreateApplicantsScreen extends StatefulWidget {
  static final String id = "create_applicants_screen";
  @override
  _CreateApplicantsScreenState createState() => _CreateApplicantsScreenState();
}

class _CreateApplicantsScreenState extends State<CreateApplicantsScreen> {
  final _formKey = GlobalKey<FormState>();
  String _documentNumber = '',
      _name = '',
      _department = '',
      _recommendedBy = '',
      _position = '';

  List<int> _compentenciesSelected = [];
  List<int> _laborExperiencesSelected = [];
  List<int> _trainingsSelected = [];

  bool _isLoading = false, _isUpdated = false;
  _onSubmit() {
    if (_formKey.currentState.validate()) {
      print('Valor actual de _name');
      print(_name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Expanded(
                  child: ListView(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 40.0),
                        child: Text(
                          "Candidatos",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 30.0,
                              decorationColor: Colors.orange[400]),
                        ),
                      ),
                      // Text("Cedula"),
                      _buildTextFieldTitle("Cédula"),
                      _buildTextFieldDocumentNumber(),
                      _buildTextFieldTitle("Nombre"),
                      _buildTextFieldName(),
                      _buildTextFieldTitle("Departamento"),
                      _buildTextFielDepartment(),
                      _buildTextFieldTitle("Recomendado por"),
                      _buildTextFieldRecommendedBy(),
                      _buildTextFieldTitle("Posicion"),
                      _buildTextFieldPosition(),
                      _buildTextFieldTitle("Competencias"),
                      _buildDropDownCompetencies(),
                      _buildTextFieldTitle("Experiencia laboral"),
                      _buildDropDownLaborExperiences(),
                      _buildTextFieldTitle("Capacitaciones"),
                      _buildDropDownTrainings(),
                      _buildFlatButton(),
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

  Text _buildTitle() => Text("Formulario de candidatos");

  Container _buildTextFieldTitle(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 22.0),
      ),
    );
  }

  Container _buildFlatButton() {
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
        onPressed: _isLoading ? null : _onSubmit,
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

  Container _buildTextFieldDocumentNumber() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        initialValue: _documentNumber,
        validator: (input) =>
            input.length < 5 ? "Ingresar mÍnimo 5 carácteres" : null,
        onSaved: (input) => _documentNumber = input.trim(),
        style: TextStyle(fontSize: 21.0),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Container _buildTextFieldName() {
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

  Container _buildTextFielDepartment() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        initialValue: _department,
        validator: (input) =>
            input.length < 5 ? "Ingresar mÍnimo 5 carácteres" : null,
        onSaved: (input) => _department = input.trim(),
        style: TextStyle(fontSize: 21.0),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Container _buildTextFieldRecommendedBy() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        initialValue: _recommendedBy,
        validator: (input) =>
            input.length < 5 ? "Ingresar mÍnimo 5 carácteres" : null,
        onSaved: (input) => _recommendedBy = input.trim(),
        style: TextStyle(fontSize: 21.0),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Container _buildTextFieldPosition() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        initialValue: _position,
        validator: (input) =>
            input.length < 5 ? "Ingresar mÍnimo 5 carácteres" : null,
        onSaved: (input) => _position = input.trim(),
        style: TextStyle(fontSize: 21.0),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Container _buildDropDownCompetencies() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 40.0),
      width: double.infinity,
      child: DropdownButtonFormField<int>(
        decoration: InputDecoration(border: InputBorder.none),
        value: 0,
        items: [
          DropdownMenuItem<int>(
            child: Text('Selecciona una competencia'),
            value: 0,
          ),
          DropdownMenuItem<int>(
            child: Row(
              children: [
                Text(
                  'Buena comunicacion',
                ),
                _isCompetencieSelected(1)
                    ? Icon(Icons.select_all_rounded)
                    : SizedBox.shrink(),
              ],
            ),
            value: 1,
          ),
          DropdownMenuItem<int>(
            child: Text('Buen teamplayer'),
            value: 2,
          ),
        ],
        onChanged: (int newValue) => _onCompetenciesSelectedChange(newValue),
      ),
    );
  }

  Container _buildDropDownLaborExperiences() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 40.0),
      width: double.infinity,
      child: DropdownButtonFormField<int>(
        decoration: InputDecoration(border: InputBorder.none),
        value: 0,
        items: [
          DropdownMenuItem<int>(
            child: Text('Selecciona una competencia'),
            value: 0,
          ),
          DropdownMenuItem<int>(
            child: Row(
              children: [
                Text(
                  'Buena comunicacion',
                ),
                _isCompetencieSelected(1)
                    ? Icon(Icons.select_all_rounded)
                    : SizedBox.shrink(),
              ],
            ),
            value: 1,
          ),
          DropdownMenuItem<int>(
            child: Text('Buen teamplayer'),
            value: 2,
          ),
        ],
        onChanged: (int newValue) => _onCompetenciesSelectedChange(newValue),
      ),
    );
  }

  Container _buildDropDownTrainings() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 40.0),
      width: double.infinity,
      child: DropdownButtonFormField<int>(
        decoration: InputDecoration(border: InputBorder.none),
        value: 0,
        items: [
          DropdownMenuItem<int>(
            child: Text('Selecciona una competencia'),
            value: 0,
          ),
          DropdownMenuItem<int>(
            child: Row(
              children: [
                Text(
                  'Buena comunicacion',
                ),
                _isCompetencieSelected(1)
                    ? Icon(Icons.select_all_rounded)
                    : SizedBox.shrink(),
              ],
            ),
            value: 1,
          ),
          DropdownMenuItem<int>(
            child: Text('Buen teamplayer'),
            value: 2,
          ),
        ],
        onChanged: (int newValue) => _onCompetenciesSelectedChange(newValue),
      ),
    );
  }

  _onCompetenciesSelectedChange(int value) {
    if (_isCompetencieSelected(value)) {
      _compentenciesSelected.remove(value);
    } else {
      _compentenciesSelected.add(value);
    }
    setState(() {});
  }

  Color _isCompetencieSelectedColor(int id) {
    var result = _isCompetencieSelected(id);
    return result ? Colors.green : Colors.white;
  }

  bool _isCompetencieSelected(int id) {
    return _compentenciesSelected.any((item) => item == id);
  }
}
