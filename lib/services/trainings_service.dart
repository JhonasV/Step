import 'dart:convert';
import 'package:Step/config/api_config.dart';
import 'package:Step/models/taskresult.dart';
import 'package:Step/models/trainings.dart';
import 'package:Step/services/auth_service.dart';
import 'package:http/http.dart' as http;

class TrainingsService {
  static Future<TaskResult<List<Trainings>>> getAll() async {
    TaskResult<List<Trainings>> result = new TaskResult<List<Trainings>>();
    var token = await AuthService.getToken();

    try {
      http.Response response = await http.get(
        "$API_URI/trainings",
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final bodyDecoded = json.decode(response.body);
        result.data = parseTrainings(bodyDecoded["data"]);
        result.success = true;
      }
    } catch (e) {
      result.messages = e.toString();
    }

    return result;
  }

  static Future<TaskResult<bool>> create(Trainings trainings) async {
    var result = new TaskResult<bool>();
    try {
      var token = await AuthService.getToken();
      http.Response response = await http.post(
        "$API_URI/trainings",
        body: jsonEncode(<String, dynamic>{
          "description": trainings.description,
          "level": trainings.level,
          "initialDate":
              trainings.initalDate.toLocal().toString().split(' ')[0],
          "endDate": trainings.endDate.toLocal().toString().split(' ')[0],
          "academy": trainings.academy
        }),
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
          "Error al intentar crear la capacitacion: ${e.toString()}";
    }

    return result;
  }

  static Future<TaskResult<bool>> update(Trainings trainings) async {
    var result = new TaskResult<bool>();
    try {
      var token = await AuthService.getToken();
      http.Response response = await http.put(
        "$API_URI/trainings/${trainings.id}",
        body: jsonEncode(<String, dynamic>{
          "description": trainings.description,
          "level": trainings.level,
          "initialDate":
              trainings.initalDate.toLocal().toString().split(' ')[0],
          "endDate": trainings.endDate.toLocal().toString().split(' ')[0],
          "academy": trainings.academy,
          "id": trainings.id,
        }),
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
      "$API_URI/trainings/$id",
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

  static List<Trainings> parseTrainings(dynamic responseBody) {
    return responseBody
        .map<Trainings>((json) => Trainings.fromJson(json))
        .toList();
  }
}
