import 'dart:convert';
import 'package:Step/config/api_config.dart';
import 'package:Step/models/competencies.dart';
import 'package:Step/models/taskresult.dart';
import 'package:Step/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

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
        result = Competencies.toList(bodyDecoded["data"]);
      }
    } catch (e) {
      print(e.message);
    }

    return result;
  }

  static Future<TaskResult<bool>> create(Competencies competencies) async {
    var result = new TaskResult<bool>();
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

      if (response.statusCode == 200) {
        result.messages = "Se actualizó el registro exitosamente";
        result.success = jsonDecode(response.body);
        result.data = jsonDecode(response.body);
      }
    } catch (e) {
      result.messages = "Error al intentar borrar el elemento: ${e.toString()}";
    }

    return result;
  }

  static Future<TaskResult<bool>> update(Competencies competencies) async {
    var result = new TaskResult<bool>();
    try {
      var token = await AuthService.getToken();
      http.Response response = await http.put(
        "$API_URI/compentencies/${competencies.id}",
        body: jsonEncode(<String, dynamic>{
          "description": competencies.description,
          "status": competencies.status,
          "id": competencies.id
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
}
