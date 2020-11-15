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

  Map<String, dynamic> toMap(Applicants applicants) {
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

  Map<String, dynamic> toMap(ApplicantsCompentencies applicantsCompentencies) {
    return {
      'applicantsId': applicantsCompentencies.applicantsId,
      'compentenciesId': applicantsCompentencies.competenciesId,
    };
  }
}

class ApplicantsTrainings {
  int applicantsId;
  int trainingsId;

  ApplicantsTrainings({this.applicantsId, this.trainingsId});

  Map<String, dynamic> toMap(ApplicantsTrainings applicantsCompentencies) {
    return {
      'applicantsId': applicantsCompentencies.applicantsId,
      'trainingsId': applicantsCompentencies.trainingsId,
    };
  }
}

class ApplicantsLaborExperiences {
  int applicantsId;
  int laborExperiencesId;

  ApplicantsLaborExperiences({this.applicantsId, this.laborExperiencesId});

  Map<String, dynamic> toMap(
      ApplicantsLaborExperiences applicantsCompentencies) {
    return {
      'applicantsId': applicantsCompentencies.applicantsId,
      'laborExperiencesId': applicantsCompentencies.laborExperiencesId,
    };
  }
}
