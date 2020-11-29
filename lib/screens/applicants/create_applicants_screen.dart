import 'package:Step/models/applicants.dart';
import 'package:Step/models/competencies.dart';
import 'package:Step/models/jobpositions.dart';
import 'package:Step/models/labor_experiences.dart';
import 'package:Step/models/taskresult.dart';
import 'package:Step/models/trainings.dart';
import 'package:Step/screens/applicants/applicants_screen.dart';
import 'package:Step/screens/home_screen.dart';
import 'package:Step/services/applicants_service.dart';
import 'package:Step/services/competencies_service.dart';
import 'package:Step/services/jobpositions_service.dart';
import 'package:Step/services/labor_experience_service.dart';
import 'package:Step/services/trainings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class CreateApplicantsScreen extends StatefulWidget {
  static final String id = "create_applicants_screen";
  final Applicants applicants;

  CreateApplicantsScreen({this.applicants});
  @override
  _CreateApplicantsScreenState createState() => _CreateApplicantsScreenState();
}

class _CreateApplicantsScreenState extends State<CreateApplicantsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _documentNumber = '',
      _name = '',
      _department = '',
      _recommendedBy = '',
      _aspirationSalary = '';

  int _position = 0;

  List<int> _compentenciesSelected = [];
  List<int> _laborExperiencesSelected = [];
  List<int> _trainingsSelected = [];

  List<Competencies> _competencies = [];
  List<LaborExperiences> _laborExperiences = [];
  List<Trainings> _trainings = [];
  List<JobPositions> _jobPositions = [];

  bool _loadingCompetencies = true,
      _loadingLaborExperiences = true,
      _loadingTrainings = true,
      _loadingJoPositions = true;

  bool _isLoading = false, _isUpdated = false;
  @override
  void initState() {
    super.initState();

    _setupCompetencies();
    _setupLaborExperiences();
    _setupTrainings();
    _setupJobPositions();
    _setupInitialValues();
  }

  _setupInitialValues() {
    if (widget.applicants != null) {
      setState(
        () {
          _documentNumber = widget.applicants?.documenNumber;
          _name = widget.applicants?.name;
          _department = widget.applicants?.department;
          _recommendedBy = widget.applicants?.recommendedBy;
          _aspirationSalary = widget.applicants?.salaryAspiration.toString();
          _position = widget.applicants?.jobPositionId;
          _isUpdated = true;

          var selectedCompIds = widget.applicants.competencies.map((e) => e.id);
          _compentenciesSelected.addAll(selectedCompIds);

          var selectedTrainsIds = widget.applicants.trainings.map((e) => e.id);
          _trainingsSelected.addAll(selectedTrainsIds);

          var selectedLabExpIds =
              widget.applicants.laborExperiences.map((e) => e.id);
          _laborExperiencesSelected.addAll(selectedLabExpIds);
        },
      );
    }
  }

  _setupJobPositions() async {
    var result = await JobPositionsService.getAll();

    if (result.success) {
      setState(() {
        _jobPositions = result.data;
      });
    } else {
      final snackBar = SnackBar(
        content: Text(
          result.messages,
          style: TextStyle(fontSize: 19.5, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    setState(() => _loadingJoPositions = !_loadingJoPositions);
  }

  _setupCompetencies() async {
    var result = await CompetenciesService.getAll();

    if (result.success) {
      setState(() {
        _competencies = result.data;
      });
    } else {
      final snackBar = SnackBar(
        content: Text(
          result.messages,
          style: TextStyle(fontSize: 19.5, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    setState(() => _loadingCompetencies = !_loadingCompetencies);
  }

  _setupLaborExperiences() async {
    var result = await LaborExperiencesService.getAll();

    if (result.success) {
      setState(() {
        _laborExperiences = result.data;
      });
    } else {
      final snackBar = SnackBar(
        content: Text(
          result.messages,
          style: TextStyle(fontSize: 19.5, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    setState(() => _loadingLaborExperiences = !_loadingLaborExperiences);
  }

  _setupTrainings() async {
    var result = await TrainingsService.getAll();

    if (result.success) {
      setState(() {
        _trainings = result.data;
      });
    } else {
      final snackBar = SnackBar(
        content: Text(
          result.messages,
          style: TextStyle(fontSize: 19.5, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    setState(() => _loadingTrainings = !_loadingTrainings);
  }

  _onSubmit() async {
    if (_formKey.currentState.validate()) {
      setState(() => _isLoading = !_isLoading);
      _formKey.currentState.save();
      // Populate Applicant
      Applicants applicants = new Applicants();
      applicants.department = _department;
      applicants.documenNumber = _documentNumber;
      applicants.jobPositionId = _position;
      applicants.name = _name;
      applicants.recommendedBy = _recommendedBy;
      applicants.salaryAspiration = int.parse(_aspirationSalary).toDouble();

      print(applicants);

      // Populate ApplicantsTraining
      List<ApplicantsTrainings> applicantsTrainings = [];

      for (int id in _trainingsSelected) {
        ApplicantsTrainings appTraining =
            new ApplicantsTrainings(trainingsId: id);
        applicantsTrainings.add(appTraining);
      }

      print(applicantsTrainings);
      // Populate ApplicantsCompetencies
      List<ApplicantsCompentencies> applicantsCompetencies = [];

      for (int id in _compentenciesSelected) {
        ApplicantsCompentencies app =
            new ApplicantsCompentencies(competenciesId: id);
        applicantsCompetencies.add(app);
      }

      print(applicantsCompetencies);
      // Populate ApplicantsLaborExperiences
      List<ApplicantsLaborExperiences> applicantsLaborExperiences = [];

      for (int id in _laborExperiencesSelected) {
        ApplicantsLaborExperiences app =
            new ApplicantsLaborExperiences(laborExperiencesId: id);

        applicantsLaborExperiences.add(app);
      }

      print(applicantsLaborExperiences);
      //

      var result = await ApplicantsService.create(
        applicants,
        applicantsTrainings,
        applicantsCompetencies,
        applicantsLaborExperiences,
      );

      if (result.success) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.id, (route) => false);

        Navigator.pushNamed(context, ApplicantsScreen.id);
      } else {
        var snackBar = new SnackBar(content: Text(result.messages));

        _scaffoldKey.currentState.showSnackBar(snackBar);
      }

      setState(() => _isLoading = !_isLoading);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
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
                      _buildDropDownJobPositions(),
                      _buildTextFieldTitle("Aspiracion Salarial"),
                      _buildTextFieldAspirationSalary(),
                      _buildCompentenciesMultiSelect(),
                      _buildLaborExperiencesMultiSelect(),
                      _buildTrainigsMultiSelect(),
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
            input.length < 2 ? "Ingresar mÍnimo 2 carácteres" : null,
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
        keyboardType: TextInputType.name,
        initialValue: _name,
        validator: (input) =>
            input.length < 2 ? "Ingresar mÍnimo 2 carácteres" : null,
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
            input.length < 2 ? "Ingresar mÍnimo 2 carácteres" : null,
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
            input.length < 2 ? "Ingresar mÍnimo 2 carácteres" : null,
        onSaved: (input) => _recommendedBy = input.trim(),
        style: TextStyle(fontSize: 21.0),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Container _buildTextFieldAspirationSalary() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        initialValue: _aspirationSalary,
        validator: (dynamic input) =>
            input.length < 2 ? "Ingresar mÍnimo 2 carácteres" : null,
        onSaved: (dynamic input) => _aspirationSalary = input,
        style: TextStyle(fontSize: 21.0),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  _buildCompentenciesMultiSelect() {
    var dataSource = [];

    for (Competencies comp in _competencies) {
      Map<String, dynamic> dataSourceItem = {};
      dataSourceItem["display"] = comp.description;
      dataSourceItem["value"] = comp.id;
      dataSource.add(dataSourceItem);
    }

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: MultiSelectFormField(
        autovalidate: false,
        chipBackGroundColor: Colors.blue,
        chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
        checkBoxActiveColor: Colors.blue,
        checkBoxCheckColor: Colors.green,
        title: _buildTextFieldTitle("Competencias"),
        dataSource: dataSource,
        textField: 'display',
        valueField: 'value',
        okButtonLabel: 'OK',
        cancelButtonLabel: 'CANCELAR',
        hintWidget: Text('Selecciona tus competencias'),
        initialValue: _compentenciesSelected,
        onSaved: (values) {
          if (values == null) return;
          setState(
            () {
              for (int id in values) {
                _compentenciesSelected.add(id);
              }
            },
          );
        },
      ),
    );
  }

  Container _buildDropDownJobPositions() {
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
        value: _position,
        items: _populateJobPositionsDropDown(),
        onChanged: (int newValue) => _position = newValue,
      ),
    );
  }

  _populateJobPositionsDropDown() {
    List<DropdownMenuItem<int>> items = [];

    var defaultDdMenuitem = DropdownMenuItem<int>(
      child: Row(
        children: [
          Text("Seleccione la posicion a la que aspira"),
        ],
      ),
      value: 0,
    );

    items.add(defaultDdMenuitem);

    for (var jobPosition in _jobPositions) {
      final ddMenuItem = DropdownMenuItem<int>(
        child: Row(
          children: [
            Text(jobPosition.name),
          ],
        ),
        value: jobPosition.id,
      );

      items.add(ddMenuItem);
    }

    return items;
  }

  _buildLaborExperiencesMultiSelect() {
    var dataSource = [];

    for (LaborExperiences labExp in _laborExperiences) {
      Map<String, dynamic> dataSourceItem = {};
      dataSourceItem["display"] = "${labExp.position} - ${labExp.company}";
      dataSourceItem["value"] = labExp.id;
      dataSource.add(dataSourceItem);
    }

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: MultiSelectFormField(
        autovalidate: false,
        chipBackGroundColor: Colors.blue,
        chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
        checkBoxActiveColor: Colors.blue,
        checkBoxCheckColor: Colors.green,
        title: _buildTextFieldTitle("Experiencia Laboral"),
        dataSource: dataSource,
        textField: 'display',
        valueField: 'value',
        okButtonLabel: 'OK',
        cancelButtonLabel: 'CANCELAR',
        hintWidget: Text('Selecciona tu experiencia laboral'),
        initialValue: _laborExperiencesSelected,
        onSaved: (values) {
          if (values == null) return;
          setState(
            () {
              for (int id in values) {
                _laborExperiencesSelected.add(id);
              }
            },
          );
        },
      ),
    );
  }

  _buildTrainigsMultiSelect() {
    var dataSource = [];

    for (Trainings traing in _trainings) {
      Map<String, dynamic> dataSourceItem = {};
      dataSourceItem["display"] = traing.description;
      dataSourceItem["value"] = traing.id;
      dataSource.add(dataSourceItem);
    }

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: MultiSelectFormField(
        autovalidate: false,
        chipBackGroundColor: Colors.blue,
        chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
        checkBoxActiveColor: Colors.blue,
        checkBoxCheckColor: Colors.green,
        title: _buildTextFieldTitle("Capacitaciones"),
        dataSource: dataSource,
        textField: 'display',
        valueField: 'value',
        okButtonLabel: 'OK',
        cancelButtonLabel: 'CANCELAR',
        hintWidget: Text('Selecciona tus capacitaciones'),
        initialValue: _trainingsSelected,
        onSaved: (values) {
          if (values == null) return;
          setState(
            () {
              for (int id in values) {
                _trainingsSelected.add(id);
              }
            },
          );
        },
      ),
    );
  }
}
