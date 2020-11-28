import 'dart:convert';

import 'package:Step/config/api_config.dart';
import 'package:Step/models/jobpositions.dart';
import 'package:Step/models/taskresult.dart';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class JobPositionsService {
  static Future<TaskResult<List<JobPositions>>> getAll() async {
    TaskResult<List<JobPositions>> result =
        new TaskResult<List<JobPositions>>();
    var token = await AuthService.getToken();

    try {
      http.Response response = await http.get(
        "$API_URI/jobpositions",
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final bodyDecoded = json.decode(response.body);
        result.data = JobPositions.toList(bodyDecoded["data"]);
        result.success = true;
      }
    } catch (e) {
      print(e.toString());
    }

    return result;
  }

  static Future<TaskResult<bool>> create(JobPositions jobPositions) async {
    var result = new TaskResult<bool>();
    try {
      var token = await AuthService.getToken();
      http.Response response = await http.post(
        "$API_URI/jobpositions",
        body: jsonEncode(<String, dynamic>{
          "riskLevel": jobPositions.riskLevel,
          "name": jobPositions.name,
          "salaryMinLevel": jobPositions.salaryMinLevel,
          "salaryMaxLevel": jobPositions.salaryMaxLevel,
          "status": jobPositions.status
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        result.messages = "Se actualizó el registro exitosamente";
        result.success = jsonDecode(response.body);
        result.data = jsonDecode(response.body);
      }

      if (response.statusCode == 400) {
        result.messages = jsonDecode(response.body)['data'];
      }
    } catch (e) {
      result.messages = "Error al intentar borrar el elemento: ${e.toString()}";
    }

    return result;
  }

  static Future<TaskResult<bool>> update(JobPositions jobPositions) async {
    var result = new TaskResult<bool>();
    try {
      var token = await AuthService.getToken();
      http.Response response = await http.put(
        "$API_URI/jobpositions/${jobPositions.id}",
        body: jsonEncode(<String, dynamic>{
          "id": jobPositions.id,
          "riskLevel": jobPositions.riskLevel,
          "name": jobPositions.name,
          "salaryMinLevel": jobPositions.salaryMinLevel,
          "salaryMaxLevel": jobPositions.salaryMaxLevel,
          "status": jobPositions.status
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        result.messages = "Elemento removido exitosamente";
        result.success = jsonDecode(response.body) as bool;
        result.data = jsonDecode(response.body) as bool;
      }
    } catch (e) {
      result.messages = "Error al intentar borrar el elemento: ${e.toString()}";
    }

    return result;
  }

  static Future<TaskResult<bool>> delete(int id) async {
    var token = await AuthService.getToken();
    http.Response response = await http.delete(
      "$API_URI/jobpositions/$id",
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
}
