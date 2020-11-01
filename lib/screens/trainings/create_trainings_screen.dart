import 'package:Step/models/taskresult.dart';
import 'package:Step/models/trainings.dart';
import 'package:Step/screens/home_screen.dart';
import 'package:Step/screens/trainings/trainings_screen.dart';
import 'package:Step/services/trainings_service.dart';
import 'package:flutter/material.dart';

class CreateTrainingsScreen extends StatefulWidget {
  static final String id = "create_Trainings_screen";
  final Trainings trainings;
  CreateTrainingsScreen({this.trainings});
  @override
  _CreateTrainingsState createState() => _CreateTrainingsState();
}

class _CreateTrainingsState extends State<CreateTrainingsScreen> {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  String _description, _level, _academy;
  DateTime _initialDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  bool _isLoading = false, _isUpdated = false;

  _submit() async {
    if (_formKey.currentState.validate()) {
      setState(() => _isLoading = !_isLoading);
      _formKey.currentState.save();

      var training = Trainings(
        description: _description,
        level: _level,
        academy: _academy,
        initalDate: _initialDate,
        endDate: _endDate,
        id: widget?.trainings?.id,
      );
      var result = TaskResult<bool>();
      _isUpdated
          ? result = await TrainingsService.update(training)
          : result = await TrainingsService.create(training);

      if (!result.success) {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text(result.messages)));
        setState(() => _isLoading = !_isLoading);
        return;
      }

      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.id, (Route<dynamic> route) => false);
      Navigator.of(context).pushNamed(TrainingsScreen.id);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.trainings != null) {
      _description = widget.trainings.description;
      _academy = widget.trainings.academy;
      _level = widget.trainings.level;
      _initialDate = widget.trainings.initalDate;
      _endDate = widget.trainings.endDate;
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
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue,
          ),
          body: Column(
            children: [
              _isLoading ? LinearProgressIndicator() : SizedBox.shrink(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: ListView(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 40.0),
                        child: Text(
                          "Capacitaciones",
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
                            _buildTextFieldTitle("Descripción"),
                            _buildTextFieldDescription(""),
                            _buildTextFieldTitle("Academia"),
                            _buildTextFieldAcademy(""),
                            _buildTextFieldTitle("Nivel"),
                            _buildDropDownLevel(),
                            _buildTextFieldTitle("Desde"),
                            _buildTextFieldInitialDate(""),
                            _buildTextFieldTitle("Hasta"),
                            _buildTextFieldEndDate(""),
                            _buildFlatButton(),
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

  Container _buildDropDownLevel() {
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
        value: _isUpdated ? widget.trainings.level : 'grado',
        items: [
          DropdownMenuItem<String>(
            child: Text('Grado'),
            value: 'grado',
          ),
          DropdownMenuItem<String>(
            child: Text('Post-grado'),
            value: 'post-grado',
          ),
          DropdownMenuItem<String>(
            child: Text('Maestria'),
            value: 'maestria',
          ),
          DropdownMenuItem<String>(
            child: Text('Doctorado'),
            value: 'doctorado',
          ),
          DropdownMenuItem<String>(
            child: Text('Técnico'),
            value: 'tecnico',
          ),
        ],
        onChanged: (String newValue) => _level = newValue.trim(),
        onSaved: (String newValue) => _level = newValue.trim(),
      ),
    );
  }

  Container _buildTextFieldDescription(String hintText) {
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

  Container _buildTextFieldAcademy(String hintText) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        initialValue: _academy,
        validator: (input) =>
            input.length < 5 ? "Ingresar mÍnimo 5 carácteres" : null,
        onSaved: (input) => _academy = input.trim(),
        style: TextStyle(fontSize: 21.0),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  GestureDetector _buildTextFieldInitialDate(String hintText) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => _selectInitialDate(context),
      child: Container(
        height: size.height * .06,
        width: size.width,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(6.0),
            color: Colors.white),
        margin: EdgeInsets.only(bottom: 30.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        alignment: Alignment.centerLeft,
        child: Text(
          '${_initialDate.toLocal()}'.split(' ')[0],
          style: TextStyle(fontSize: 21.0),
        ),
      ),
    );
  }

  GestureDetector _buildTextFieldEndDate(String hintText) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => _selectEndDate(context),
      child: Container(
        height: size.height * .06,
        width: size.width,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(6.0),
            color: Colors.white),
        margin: EdgeInsets.only(bottom: 30.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        alignment: Alignment.centerLeft,
        child: Text(
          '${_endDate.toLocal()}'.split(' ')[0],
          style: TextStyle(fontSize: 21.0),
        ),
      ),
    );
  }

  _selectInitialDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => _initialDate = picked);
    }
  }

  _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => _endDate = picked);
    }
  }
}
