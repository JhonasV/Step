import 'dart:convert';
import 'dart:io';
import 'package:Step/models/applicants.dart';
import 'package:Step/models/taskresult.dart';
import 'package:Step/services/auth_service.dart';

import 'package:http/http.dart' as http;

class ApplicantsService {
  static String _url = "jhonasv-001-site1.ctempurl.com";

  static Future<TaskResult<List<Applicants>>> getAll() async {
    TaskResult<List<Applicants>> result = new TaskResult<List<Applicants>>();
    String token = await AuthService.getToken();

    try {
      var url = new Uri.http(_url, '/api/v1/applicants');
      http.Response response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'applicantion/json',
        },
      );

      if (response.statusCode == 200) {
        var dataDecoded = json.decode(response.body);
        result.data = Applicants.toList(dataDecoded['data']);
        result.success = true;
      } else {
        throw new Exception(response.body);
      }
    } catch (e) {
      print(e);
    }

    return result;
  }

  static Future<TaskResult<bool>> create(Applicants app) {
    TaskResult<bool> result = new TaskResult<bool>();
  }
}
