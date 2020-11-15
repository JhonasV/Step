import 'dart:convert';
import 'dart:io';

import 'package:Step/config/api_config.dart';
import 'package:Step/models/applicants.dart';
import 'package:Step/services/auth_service.dart';

import 'package:http/http.dart' as http;

class ApplicantsService {
  static Future<List<Applicants>> getAll() async {
    List<Applicants> result = new List();
    String token = await AuthService.getToken();

    try {
      var url = Uri.http(API_URI, '/applicants');
      http.Response response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'applicantion/json',
        },
      );

      if (response.statusCode == 200) {
        var dataDecoded = json.decode(response.body);
        result = Applicants.toList(dataDecoded['data']);
      } else {
        throw new Exception(response.body);
      }
    } catch (e) {}

    return result;
  }
}
