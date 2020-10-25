import 'dart:convert';
import 'package:Step/config/api_config.dart';
import 'package:Step/models/competencies.dart';
import 'package:Step/models/taskresult.dart';
import 'package:Step/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class CompetenciesService {
  static Future<List<Competencies>> getAll() async {
    List<Competencies> result = [];
    var token = await AuthService.getToken();

    try {
      http.Response response = await http.get(
        "$API_URI/compentencies",
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final bodyDecoded = json.decode(response.body);
        result = parseCompetencies(bodyDecoded["data"]);
      }
    } catch (e) {
      print(e.message);
    }

    return result;
  }

  static Future<void> create(Competencies competencies) async {
    try {
      var token = await AuthService.getToken();
      http.Response response = await http.post(
        "$API_URI/compentencies",
        body: jsonEncode(<String, dynamic>{
          "description": competencies.description,
          "status": competencies.status
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      if (response.statusCode == 200) {}
    } catch (e) {}
  }

  static Future<void> update(Competencies competencies) async {
    try {
      var token = await AuthService.getToken();
      http.Response response = await http.put(
        "$API_URI/compentencies/${competencies.id}",
        body: jsonEncode(<String, dynamic>{
          "description": competencies.description,
          "status": competencies.status
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      if (response.statusCode == 200) {}
    } catch (e) {}
  }

  static Future<TaskResult<bool>> delete(int id) async {
    var token = await AuthService.getToken();
    http.Response response = await http.delete(
      "$API_URI/compentencies/$id",
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    var result = new TaskResult<bool>();
    if (response.statusCode == 200) {
      bool data = jsonDecode(response.body);
      result.success = data;
      result.data = data;
    }

    return result;
  }

  static List<Competencies> parseCompetencies(dynamic responseBody) {
    return responseBody
        .map<Competencies>((json) => Competencies.fromJson(json))
        .toList();
  }
}
