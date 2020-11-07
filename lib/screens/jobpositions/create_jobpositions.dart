import 'package:Step/models/jobpositions.dart';
import 'package:Step/models/taskresult.dart';
import 'package:Step/screens/home_screen.dart';
import 'package:Step/screens/jobpositions/jobpositions_screen.dart';
import 'package:Step/services/jobpositions_service.dart';
import 'package:flutter/material.dart';

class CreateJobPositionsScreen extends StatefulWidget {
  static final String id = "create_languages_screen";
  final JobPositions jobPositions;
  CreateJobPositionsScreen({this.jobPositions});
  @override
  _CreateJobPositionsState createState() => _CreateJobPositionsState();
}

class _CreateJobPositionsState extends State<CreateJobPositionsScreen> {
  var _formKey = GlobalKey<FormState>();
  String _name, _riskLevel, _status;
  double _salaryMaxLevel = 0, _salaryMinLevel = 0;
  bool _isLoading = false, _isUpdated = false;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  _submit() async {
    if (_formKey.currentState.validate()) {
      setState(() => _isLoading = !_isLoading);
      _formKey.currentState.save();

      if (_salaryMinLevel > _salaryMaxLevel) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
                "El salario minimo no puede ser mayor que el el maximo.")));
        setState(() => _isLoading = !_isLoading);
        return;
      }

      var jobP = JobPositions(
        name: _name,
        riskLevel: _riskLevel,
        salaryMaxLevel: _salaryMaxLevel,
        salaryMinLevel: _salaryMinLevel,
        id: widget?.jobPositions?.id,
        status: _status == "activo" ? 1 : 0,
      );
      var result = TaskResult<bool>();
      _isUpdated
          ? result = await JobPositionsService.update(jobP)
          : result = await JobPositionsService.create(jobP);

      if (!result.success) {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text(result.messages)));
        setState(() => _isLoading = !_isLoading);
        return;
      }

      Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.id, (Route<dynamic> route) => false);
      Navigator.of(context).pushNamed(JobPositionsScreen.id);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.jobPositions != null) {
      _name = widget.jobPositions.name;
      _riskLevel = widget.jobPositions.riskLevel;
      _salaryMaxLevel = widget.jobPositions.salaryMaxLevel;
      _salaryMinLevel = widget.jobPositions.salaryMinLevel;
      _status = widget.jobPositions.status == 1 ? "activo" : "inactivo";
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
                          "Posiciones de trabajo",
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
                            _buildTextFieldTitle("Nombre"),
                            _buildTextFieldName(""),
                            _buildTextFieldTitle("Estado"),
                            _buildDropDown(),
                            _buildTextFieldTitle("Nivel de riesgo"),
                            _buildDropDownRiskLevel(),
                            _buildTextFieldTitle("Nivel de salario minimo"),
                            _buildTextFieldSalaryMinLevel(""),
                            _buildTextFieldTitle("Nivel de salario máximo"),
                            _buildTextFieldSalaryMaxLevel(""),
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

  Container _buildDropDown() {
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
        value: _isUpdated ? _status : 'activo',
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

  Container _buildDropDownRiskLevel() {
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
        value: _isUpdated ? _riskLevel : 'bajo',
        items: [
          DropdownMenuItem<String>(
            child: Text('Alto'),
            value: 'alto',
          ),
          DropdownMenuItem<String>(
            child: Text('Medio'),
            value: 'medio',
          ),
          DropdownMenuItem<String>(
            child: Text('Bajo'),
            value: 'bajo',
          ),
        ],
        onChanged: (String newValue) => _riskLevel = newValue.trim(),
        onSaved: (String newValue) => _riskLevel = newValue.trim(),
      ),
    );
  }

  Container _buildTextFieldName(String hintText) {
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

  Container _buildTextFieldSalaryMaxLevel(String hintText) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        initialValue: _salaryMaxLevel.toString(),
        validator: (input) => double.parse(input) == 0 || input.length == 0
            ? "Campo obligatorio"
            : null,
        onSaved: (input) => _salaryMaxLevel = double.parse(input.trim()),
        style: TextStyle(fontSize: 21.0),
        decoration: InputDecoration(border: InputBorder.none),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Container _buildTextFieldSalaryMinLevel(String hintText) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        initialValue: _salaryMinLevel.toString(),
        validator: (input) => double.parse(input) == 0 || input.length == 0
            ? "Campo obligatorio"
            : null,
        onSaved: (input) => _salaryMinLevel = double.parse(input.trim()),
        style: TextStyle(fontSize: 21.0),
        decoration: InputDecoration(border: InputBorder.none),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
