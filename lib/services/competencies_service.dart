import 'dart:convert';
import 'package:Step/config/api_config.dart';
import 'package:Step/models/competencies.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class CompetenciesService {
  static String bearerToken = "Bearer $AUTH_TOKEN";
  static Future<List<Competencies>> getAll() async {
    List<Competencies> result = [];

    print(bearerToken);
    try {
      http.Response response = await http.get(
        "$API_URI/compentencies",
        headers: {"Authorization": bearerToken},
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
      http.Response response = await http.post(
        "$API_URI/compentencies",
        body: jsonEncode(<String, dynamic>{
          "description": competencies.description,
          "status": competencies.status
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": bearerToken
        },
      );

      if (response.statusCode == 200) {}
    } catch (e) {}
  }

  static Future<void> update(Competencies competencies) async {
    try {
      http.Response response = await http.put(
        "$API_URI/compentencies/${competencies.id}",
        body: jsonEncode(<String, dynamic>{
          "description": competencies.description,
          "status": competencies.status
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Authorization": bearerToken
        },
      );

      if (response.statusCode == 200) {}
    } catch (e) {}
  }

  static List<Competencies> parseCompetencies(dynamic responseBody) {
    return responseBody
        .map<Competencies>((json) => Competencies.fromJson(json))
        .toList();
  }
}
