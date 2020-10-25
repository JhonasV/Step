import 'dart:convert';

import 'package:Step/config/api_config.dart';
import 'package:Step/models/taskresult.dart';
import 'package:Step/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<TaskResult<String>> login(User user) async {
    var result = new TaskResult<String>();
    http.Response response = await http.post(
      "$API_URI/auth/login",
      body: jsonEncode(<String, dynamic>{
        "userName": user.userName,
        "password": user.password
      }),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var data = body["data"];
      result = TaskResult<String>.fromJson(body, data);
    }

    if (response.statusCode == 401) {
      result = TaskResult<String>.fromJson(body, "");
    }

    return result;
  }

  static Future<TaskResult<String>> register(User user) async {
    var result = new TaskResult<String>();
    http.Response response = await http.post(
      "$API_URI/auth/register",
      body: jsonEncode(<String, dynamic>{
        "userName": user.userName,
        "password": user.password
      }),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var data = body["data"];
      result = TaskResult<String>.fromJson(body, data);
    }

    if (response.statusCode == 400) {
      result = TaskResult<String>.fromJson(body, "");
    }

    return result;
  }

  static Future<TaskResult<User>> current() async {
    var token = await getToken();
    http.Response response = await http.get(
      "$API_URI/auth/current",
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    TaskResult<User> result = new TaskResult<User>();
    User user = new User();
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      user = User.fromJson(body["data"]);
      result = TaskResult<User>.fromJson(body, user);
    } else {
      await removeToken();
    }

    return result;
  }

  static Future<TaskResult<bool>> logOut() async {
    var token = await getToken();

    if (token != null) {
      await removeToken();
    }

    var result = TaskResult<bool>();
    result.data = true;

    return result;
  }

  static Future<void> saveToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(TOKEN_KEY, token);
  }

  static Future<void> removeToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(TOKEN_KEY);
  }

  static Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(TOKEN_KEY);
  }
}
