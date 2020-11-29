import 'package:Step/models/competencies.dart';
import 'package:Step/models/labor_experiences.dart';
import 'package:Step/models/trainings.dart';

class Applicants {
  int id;
  String documenNumber;
  String name;
  int jobPositionId;
  String department;
  double salaryAspiration;
  String recommendedBy;
  int usersId;
  List<Competencies> competencies;
  List<Trainings> trainings;
  List<LaborExperiences> laborExperiences;

  Applicants({
    this.id,
    this.documenNumber,
    this.name,
    this.jobPositionId,
    this.department,
    this.salaryAspiration,
    this.recommendedBy,
    this.usersId,
    this.competencies,
    this.trainings,
    this.laborExperiences,
  });

  factory Applicants.fromJson(Map<String, dynamic> json) {
    return Applicants(
      id: json['id'],
      documenNumber: json['documentNumber'],
      name: json['name'],
      jobPositionId: json['jobPositionId'],
      department: json['department'],
      salaryAspiration: json['salaryAspiration'] / 1,
      recommendedBy: json['recommendedBy'],
      usersId: json['usersId'],
      competencies: Competencies.toList(json['compentencies']),
      trainings: Trainings.toList(json['trainings']),
      laborExperiences: LaborExperiences.toList(json['laborExperiences']),
    );
  }

  static Map<String, dynamic> toMap(Applicants applicants) {
    return {
      'id': applicants.id,
      'documentNumber': applicants.documenNumber,
      'name': applicants.name,
      'jobPositionId': applicants.jobPositionId,
      'department': applicants.department,
      'salaryAspiration': applicants.salaryAspiration,
      'recommendedBy': applicants.recommendedBy,
      'usersId': applicants.usersId,
    };
  }

  static List<Applicants> toList(dynamic jsonList) {
    return jsonList
        .map<Applicants>((json) => Applicants.fromJson(json))
        .toList();
  }
}

class ApplicantsCompentencies {
  int applicantsId;
  int competenciesId;

  ApplicantsCompentencies({this.applicantsId, this.competenciesId});

  static Map<String, dynamic> toMap(
      ApplicantsCompentencies applicantsCompentencies) {
    return {
      'applicantsId': applicantsCompentencies.applicantsId,
      'compentenciesId': applicantsCompentencies.competenciesId,
    };
  }

  static List<Map<String, dynamic>> toMapList(
      List<ApplicantsCompentencies> applicantsCompentencies) {
    List<Map<String, dynamic>> mapList = [];

    Map<String, dynamic> map = {};

    for (var item in applicantsCompentencies) {
      map = {
        'applicantsId': item.applicantsId,
        'compentenciesId': item.competenciesId,
      };

      mapList.add(map);
    }

    return mapList;
  }
}

class ApplicantsTrainings {
  int applicantsId;
  int trainingsId;

  ApplicantsTrainings({this.applicantsId, this.trainingsId});

  static Map<String, dynamic> toMap(ApplicantsTrainings applicantsTrainings) {
    return {
      'applicantsId': applicantsTrainings.applicantsId,
      'trainingsId': applicantsTrainings.trainingsId,
    };
  }

  static List<Map<String, dynamic>> toMapList(
      List<ApplicantsTrainings> applicantsTrainings) {
    List<Map<String, dynamic>> mapList = [];

    Map<String, dynamic> map = {};

    for (var item in applicantsTrainings) {
      map = {
        'applicantsId': item.applicantsId,
        'trainingsId': item.trainingsId,
      };

      mapList.add(map);
    }

    return mapList;
  }
}

class ApplicantsLaborExperiences {
  int applicantsId;
  int laborExperiencesId;

  ApplicantsLaborExperiences({this.applicantsId, this.laborExperiencesId});

  static Map<String, dynamic> toMap(
      ApplicantsLaborExperiences applicantsLaborExperiences) {
    return {
      'applicantsId': applicantsLaborExperiences.applicantsId,
      'laborExperiencesId': applicantsLaborExperiences.laborExperiencesId,
    };
  }

  static List<Map<String, dynamic>> toMapList(
      List<ApplicantsLaborExperiences> applicantsLaborExperiences) {
    List<Map<String, dynamic>> mapList = [];

    Map<String, dynamic> map = {};

    for (var item in applicantsLaborExperiences) {
      map = {
        'applicantsId': item.applicantsId,
        'laborExperiencesId': item.laborExperiencesId,
      };

      mapList.add(map);
    }

    return mapList;
  }
}
