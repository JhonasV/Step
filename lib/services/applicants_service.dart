import 'dart:convert';
import 'dart:io';
import 'package:Step/config/api_config.dart';
import 'package:Step/models/applicants.dart';
import 'package:Step/models/taskresult.dart';
import 'package:Step/services/auth_service.dart';

import 'package:http/http.dart' as http;

class ApplicantsService {
  // static String _url = "jhonasv-001-site1.ctempurl.com";

  static Future<TaskResult<List<Applicants>>> getAll() async {
    TaskResult<List<Applicants>> result = new TaskResult<List<Applicants>>();
    String token = await AuthService.getToken();

    try {
      var url = new Uri.http(baseUrl, '/api/v1/applicants');
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

  static Future<TaskResult<bool>> create(
      Applicants app,
      List<ApplicantsTrainings> applicantsTrainings,
      List<ApplicantsCompentencies> applicantsCompetencies,
      List<ApplicantsLaborExperiences> applicantsLaborExperiences) async {
    TaskResult<bool> result = new TaskResult<bool>();
    String token = await AuthService.getToken();

    try {
      var url = Uri.http(baseUrl, '/api/v1/applicants');

      http.Response response = await http.post(
        url,
        body: jsonEncode(
          {
            'applicants': Applicants.toMap(app),
            'applicantsTrainings':
                ApplicantsTrainings.toMapList(applicantsTrainings),
            'applicantsCompentencies':
                ApplicantsCompentencies.toMapList(applicantsCompetencies),
            'applicantsLaborExperiences': ApplicantsLaborExperiences.toMapList(
                applicantsLaborExperiences),
          },
        ),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'applicantion/json',
          HttpHeaders.acceptHeader: 'application/json'
        },
      );

      var bodyDecoded = jsonDecode(response.body);
      result.data = bodyDecoded['data'];
      result.messages = bodyDecoded['messages'];

      if (response.statusCode == 200) {
        result.success = true;
      } else if (response.statusCode == 500) {
        result.success = false;
      } else {
        throw new Exception(response.body);
      }
    } catch (e) {
      print(e);
    }

    return result;
  }
}
