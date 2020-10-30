import 'package:Step/models/taskresult.dart';
import 'package:Step/models/user.dart';
import 'package:Step/screens/home_screen.dart';
import 'package:Step/screens/register_screen.dart';
import 'package:Step/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static final id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _formKey = new GlobalKey<FormState>();
  String _userName = "", _password = "";
  bool _isLoading = false;
  bool _validatingLoggedIn = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  initState() {
    super.initState();
    _redirectLoggedOut();
  }

  void _redirectLoggedOut() async {
    setState(() => _validatingLoggedIn = !_validatingLoggedIn);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("BEARER_TOKEN");
    if (token == null) {
      setState(() => _validatingLoggedIn = !_validatingLoggedIn);
      return;
    }

    TaskResult<User> result = await AuthService.current();
    if (!result.success) {
      setState(() => _validatingLoggedIn = !_validatingLoggedIn);
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil(
        HomeScreen.id, (Route<dynamic> route) => false);
  }

  _submit() async {
    if (_formKey.currentState.validate()) {
      setState(() => _isLoading = !_isLoading);
      _formKey.currentState.save();
      var result = await AuthService.login(
          new User(userName: _userName, password: _password));

      if (result.success) {
        await AuthService.saveToken(result.data);
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.id, (Route<dynamic> route) => false);
      } else {
        final snackBar = SnackBar(
          content: Text(
            result.messages,
            style: TextStyle(fontSize: 19.5, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
        setState(() {
          _isLoading = !_isLoading;
          _password = "";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: _scaffoldKey,
          body: Column(
            children: [
              _isLoading ? LinearProgressIndicator() : SizedBox.shrink(),
              Expanded(
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
                  child: _validatingLoggedIn
                      ? Center(child: CircularProgressIndicator())
                      : _buildForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              "Step",
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            "Nombre de usuario",
            style: TextStyle(fontSize: 17.0),
          ),
          _buildTextFieldUserName(),
          SizedBox(height: 20.0),
          Text(
            "Contraseña",
            style: TextStyle(fontSize: 17.0),
          ),
          _buildTextFieldPassword(),
          SizedBox(height: 20.0),
          _buildLoginFlatButton(),
          SizedBox(height: 10.0),
          Text(
            "O",
            style: TextStyle(
                fontSize: 22.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.0),
          _buildRegisterFlatButton(),
        ],
      ),
    );
  }

  Container _buildRegisterFlatButton() {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: _isLoading
            ? null
            : () => {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RegisterScreen.id, (Route<dynamic> route) => false)
                },
        child: Text("Registrate",
            style: TextStyle(fontSize: 19.0, color: Colors.blue)),
      ),
    );
  }

  Container _buildLoginFlatButton() {
    return Container(
      alignment: Alignment.center,
      color: Colors.blue,
      child: SizedBox(
        width: double.infinity,
        child: FlatButton(
          onPressed: _isLoading ? null : () => _submit(),
          child: Text("Login",
              style: TextStyle(fontSize: 19.0, color: Colors.white)),
        ),
      ),
    );
  }

  Container _buildTextFieldUserName() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        enabled: !_isLoading,
        initialValue: _userName,
        validator: (input) =>
            input.length < 5 ? "Ingresar mÍnimo 5 carácteres" : null,
        onSaved: (input) => _userName = input.trim(),
        style: TextStyle(fontSize: 21.0),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Container _buildTextFieldPassword() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        enabled: !_isLoading,
        obscureText: true,
        initialValue: _password,
        validator: (input) =>
            input.length < 5 ? "Ingresar mÍnimo 5 carácteres" : null,
        onSaved: _isLoading ? null : (input) => _password = input.trim(),
        style: TextStyle(fontSize: 21.0),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
