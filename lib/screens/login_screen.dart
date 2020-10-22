import 'package:Step/models/taskresult.dart';
import 'package:Step/models/user.dart';
import 'package:Step/screens/home_screen.dart';
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
      print(_userName);
      print(_password);
      var result = await AuthService.login(
          new User(userName: _userName, password: _password));

      if (result.success) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("BEARER_TOKEN", result.data);
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.id, (Route<dynamic> route) => false);
      } else {
        // Show error message
      }
      // Navigator.of(context).pop();

    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
            child: _validatingLoggedIn
                ? Center(child: CircularProgressIndicator())
                : Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        _isLoading
                            ? LinearProgressIndicator()
                            : SizedBox.shrink(),
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
                        TextFormField(
                          obscureText: false,
                          initialValue: _userName,
                          onSaved: (input) => _userName = input.trim(),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          "Contraseña",
                          style: TextStyle(fontSize: 17.0),
                        ),
                        TextFormField(
                          obscureText: true,
                          initialValue: _password,
                          onSaved: (input) => _password = input.trim(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.center,
                          color: Colors.blue,
                          child: FlatButton(
                            onPressed: () => _submit(),
                            child: Text("Login",
                                style: TextStyle(
                                    fontSize: 19.0, color: Colors.white)),
                          ),
                        ),
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
                        Container(
                          alignment: Alignment.center,
                          child: FlatButton(
                            onPressed: () => print("test"),
                            child: Text("Registrate",
                                style: TextStyle(
                                    fontSize: 19.0, color: Colors.blue)),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
