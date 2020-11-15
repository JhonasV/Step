import 'package:Step/models/user.dart';

class LaborExperiences {
  int id;
  String company;
  String position;
  int userId;
  DateTime initialDate;
  DateTime endDate;
  double salary;
  User user;
  DateTime createAt;
  DateTime updatedAt;

  LaborExperiences(
      {this.id,
      this.userId,
      this.company,
      this.initialDate,
      this.endDate,
      this.salary,
      this.position,
      this.user});

  factory LaborExperiences.fromJson(Map<String, dynamic> json) {
    return LaborExperiences(
      id: json['id'],
      company: json['company'],
      userId: json['userId'],
      initialDate: DateTime.parse(json['initialDate']),
      endDate: DateTime.parse(json['endDate']),
      salary: json['salary'] / 1,
      position: json['position'],
      user:
          json['users'] == null ? json['users'] : User.fromJson(json['users']),
    );
  }

  Map<String, dynamic> toMap(LaborExperiences laborExperience) {
    return {
      "id": laborExperience.id == null ? 0 : laborExperience.id,
      'company': laborExperience.company,
      'initialDate':
          laborExperience.initialDate.toLocal().toString().split(' ')[0],
      'endDate': laborExperience.endDate.toLocal().toString().split(' ')[0],
      'salary': laborExperience.salary,
      'position': laborExperience.position,
      'userId': laborExperience.userId
    };
  }

  static List<LaborExperiences> toList(dynamic responseBody) {
    return responseBody
        .map<LaborExperiences>((json) => LaborExperiences.fromJson(json))
        .toList();
  }
}
