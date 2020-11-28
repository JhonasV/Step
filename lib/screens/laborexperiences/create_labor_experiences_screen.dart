import 'package:Step/models/jobpositions.dart';
import 'package:Step/models/labor_experiences.dart';
import 'package:Step/models/taskresult.dart';
import 'package:Step/screens/home_screen.dart';
import 'package:Step/screens/jobpositions/jobpositions_screen.dart';
import 'package:Step/screens/laborexperiences/labor_experiences_screen.dart';
import 'package:Step/services/jobpositions_service.dart';
import 'package:Step/services/labor_experience_service.dart';
import 'package:flutter/material.dart';

class CreateLaborExperiencesScreen extends StatefulWidget {
  static final String id = "create_labor_experiences_screen";
  final LaborExperiences laborExperiences;
  CreateLaborExperiencesScreen({this.laborExperiences});
  @override
  _CreateLaborExperiencesState createState() => _CreateLaborExperiencesState();
}

class _CreateLaborExperiencesState extends State<CreateLaborExperiencesScreen> {
  var _formKey = GlobalKey<FormState>();
  String _company, _position;
  DateTime _initialDate = DateTime.now(), _endDate = DateTime.now();
  double _salary = 0;
  bool _isLoading = false, _isUpdated = false;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  _submit() async {
    if (_formKey.currentState.validate()) {
      setState(() => _isLoading = !_isLoading);
      _formKey.currentState.save();

      var laborExperiences = LaborExperiences(
        company: _company,
        position: _position,
        initialDate: _initialDate,
        endDate: _endDate,
        id: widget?.laborExperiences?.id,
        userId: widget?.laborExperiences?.userId,
        salary: _salary,
      );
      var result = TaskResult<bool>();
      _isUpdated
          ? result = await LaborExperiencesService.update(laborExperiences)
          : result = await LaborExperiencesService.create(laborExperiences);

      if (!result.success) {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text(result.messages)));
        setState(() => _isLoading = !_isLoading);
        return;
      }

      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.id, (Route<dynamic> route) => false);
      Navigator.of(context).pushNamed(LaborExperiencesScreen.id);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.laborExperiences != null) {
      _company = widget.laborExperiences.company;
      _position = widget.laborExperiences.position;
      _initialDate = widget.laborExperiences.initialDate;
      _endDate = widget.laborExperiences.endDate;
      _salary = widget.laborExperiences.salary;
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
                  margin: EdgeInsets.only(top: 50.0),
                  padding: EdgeInsets.all(20.0),
                  child: ListView(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: 40.0),
                        child: Text(
                          "Experiencia Laboral",
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
                            _buildTextFieldTitle("Compañía"),
                            _buildTextFieldCompany(""),
                            _buildTextFieldTitle("Posición"),
                            _buildTextFieldPosition(""),
                            _buildTextFieldTitle("Salario"),
                            _buildTextFieldSalary(""),
                            _buildTextFieldTitle("Fecha inicial"),
                            _buildTextFieldInitialDate(""),
                            _buildTextFieldTitle("Fecha final"),
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

  Container _buildTextFieldCompany(String hintText) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        initialValue: _company,
        validator: (input) =>
            input.length < 5 ? "Ingresar mÍnimo 5 carácteres" : null,
        onSaved: (input) => _company = input.trim(),
        style: TextStyle(fontSize: 21.0),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Container _buildTextFieldPosition(String hintText) {
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

  Container _buildTextFieldSalary(String hintText) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        initialValue: _salary.toString(),
        validator: (input) => double.parse(input) == 0 || input.length == 0
            ? "Campo obligatorio"
            : null,
        onSaved: (input) => _salary = double.parse(input.trim()),
        style: TextStyle(fontSize: 21.0),
        decoration: InputDecoration(border: InputBorder.none),
        keyboardType: TextInputType.number,
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
