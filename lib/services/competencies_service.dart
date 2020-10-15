import 'dart:convert';
import 'package:Step/config/api_config.dart';
import 'package:Step/models/competencies.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class CompetenciesService {
  static Future<List<Competencies>> getAll() async {
    List<Competencies> result = [];
    try {
      http.Response response = await http.get("$API_URI/compentencies");

      if (response.statusCode == 200) {
        final bodyDecoded = json.decode(response.body);
        result = parseCompetencies(bodyDecoded);
      }
    } catch (e) {
      print(e.message);
    }

    return result;
  }

  static Future<void> create(Competencies competencies) async {
    try {
      var body = jsonEncode(competencies);
      http.Response response = await http.post(
        "$API_URI/compentencies",
        body: body,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
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
