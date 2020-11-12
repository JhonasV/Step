import 'dart:convert';

import 'package:Step/config/api_config.dart';
import 'package:Step/models/labor_experiences.dart';
import 'package:Step/models/taskresult.dart';

import 'auth_service.dart';
import 'package:http/http.dart' as http;

class LaborExperiencesService {
  static Future<TaskResult<List<LaborExperiences>>> getAll() async {
    TaskResult<List<LaborExperiences>> result =
        new TaskResult<List<LaborExperiences>>();
    var token = await AuthService.getToken();

    try {
      http.Response response = await http.get(
        "$API_URI/laborexperiences",
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final bodyDecoded = jsonDecode(response.body);
        result.data = parseLaborExperience(bodyDecoded["data"]);
        result.success = true;
      }
    } catch (e) {
      result.messages = e.toString();
    }

    return result;
  }

  static Future<TaskResult<List<LaborExperiences>>> getAllByCurrentUser(
      int userId) async {
    TaskResult<List<LaborExperiences>> result =
        new TaskResult<List<LaborExperiences>>();
    var token = await AuthService.getToken();

    try {
      http.Response response = await http.get(
        "$API_URI/laborexperiences/getlistbyuserid/$userId",
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final bodyDecoded = jsonDecode(response.body);
        result.data = parseLaborExperience(bodyDecoded["data"]);
        result.success = true;
      }
    } catch (e) {
      result.messages = e.toString();
    }

    return result;
  }

  static Future<TaskResult<bool>> create(
      LaborExperiences laborExperience) async {
    var result = new TaskResult<bool>();
    try {
      var token = await AuthService.getToken();
      var currentUser = await AuthService.current();
      laborExperience.userId = currentUser.data.id;
      http.Response response = await http.post(
        "$API_URI/laborexperiences",
        body: jsonEncode(laborExperience.toMap(laborExperience)),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        result.messages = "Se creó el registro exitosamente";
        result.success = jsonDecode(response.body);
        result.data = jsonDecode(response.body);
      }
    } catch (e) {
      result.messages =
          "Error al intentar crear la experiencia laboral: ${e.toString()}";
    }

    return result;
  }

  static Future<TaskResult<bool>> update(
      LaborExperiences laborExperience) async {
    var result = new TaskResult<bool>();
    try {
      var token = await AuthService.getToken();
      http.Response response = await http.put(
        "$API_URI/laborexperiences/${laborExperience.id}",
        body: jsonEncode(laborExperience.toMap(laborExperience)),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        result.messages = "Elemento actualizado exitosamente";
        result.success = jsonDecode(response.body) as bool;
        result.data = jsonDecode(response.body) as bool;
      }
    } catch (e) {
      result.messages =
          "Error al intentar actualizar el elemento: ${e.toString()}";
    }

    return result;
  }

  static Future<TaskResult<bool>> delete(int id) async {
    var token = await AuthService.getToken();
    http.Response response = await http.delete(
      "$API_URI/laborexperiences/$id",
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

  static List<LaborExperiences> parseLaborExperience(dynamic responseBody) {
    return responseBody
        .map<LaborExperiences>((json) => LaborExperiences.fromJson(json))
        .toList();
  }
}
