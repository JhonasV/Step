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
        "content-type": "application/json",
        "Authorization": BEARER_TOKEN
      },
    );

    if (response.statusCode == 200 || response.statusCode == 401) {
      result = TaskResult<String>.fromJson(jsonDecode(response.body));
    }

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
        "content-type": "application/json",
        "Authorization": BEARER_TOKEN
      },
    );

    if (response.statusCode == 200) {
      result = TaskResult<User>.fromJson(jsonDecode(response.body));
    }

    return result;
  }

  static Future<TaskResult<User>> current() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("BEARER_TOKEN");
    var result = new TaskResult<User>();
    http.Response response = await http.get(
      "$API_URI/auth/current",
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": token
      },
    );

    if (response.statusCode == 200) {
      result = TaskResult<User>.fromJson(jsonDecode(response.body));
    }

    return result;
  }
}
