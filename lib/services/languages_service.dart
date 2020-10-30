import 'dart:convert';

import 'package:Step/config/api_config.dart';
import 'package:Step/models/languages.dart';
import 'package:Step/models/taskresult.dart';
import 'package:Step/services/auth_service.dart';
import 'package:http/http.dart' as http;

class LanguagesService {
  static Future<List<Languages>> getAll() async {
    List<Languages> result = [];
    var token = await AuthService.getToken();

    try {
      http.Response response = await http.get(
        "$API_URI/languages",
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final bodyDecoded = json.decode(response.body);
        result = parseLanguages(bodyDecoded["data"]);
      }
    } catch (e) {
      print(e.message);
    }

    return result;
  }

  static Future<TaskResult<bool>> create(Languages languages) async {
    var result = new TaskResult<bool>();
    try {
      var token = await AuthService.getToken();
      http.Response response = await http.post(
        "$API_URI/languages",
        body: jsonEncode(<String, dynamic>{
          "name": languages.name,
          "status": languages.status
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

  static Future<TaskResult<bool>> update(Languages languages) async {
    var result = new TaskResult<bool>();
    try {
      var token = await AuthService.getToken();
      http.Response response = await http.put(
        "$API_URI/languages/${languages.id}",
        body: jsonEncode(<String, dynamic>{
          "name": languages.name,
          "status": languages.status,
          "id": languages.id
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
      "$API_URI/languages/$id",
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

  static List<Languages> parseLanguages(dynamic responseBody) {
    return responseBody
        .map<Languages>((json) => Languages.fromJson(json))
        .toList();
  }
}
