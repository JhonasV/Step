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

    if (response.statusCode == 401) {}

    return result;
  }

  static Future<TaskResult<User>> register(User user) async {
    var result = new TaskResult<User>();
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

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var user = User.fromJson(body["data"]);
      result = TaskResult<User>.fromJson(body, user);
    }

    return result;
  }

  static Future<TaskResult<User>> current() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("BEARER_TOKEN");
    http.Response response = await http.get(
      "$API_URI/auth/current",
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var body = jsonDecode(response.body);
    var user = User.fromJson(body["data"]);
    return TaskResult<User>.fromJson(body, user);
  }

  static Future<TaskResult<bool>> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("BEARER_TOKEN");

    if (token != null) {
      prefs.remove("BEARER_TOKEN");
    }

    var result = TaskResult<bool>();
    result.data = true;

    return result;
  }
}
