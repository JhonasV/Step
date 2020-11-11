import 'package:Step/models/user.dart';

class LaborExperience {
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

  LaborExperience(
      {this.id,
      this.userId,
      this.company,
      this.initialDate,
      this.endDate,
      this.salary,
      this.position});

  factory LaborExperience.fromJson(Map<String, dynamic> json) {
    return LaborExperience(
      id: json['id'],
      company: json['company'],
      userId: json['userId'],
      initialDate: DateTime.parse(json['initialDate']),
      endDate: DateTime.parse(json['endDate']),
      salary: json['salary'] / 1,
      position: json['position'],
    );
  }

  Map<String, dynamic> toMap(LaborExperience laborExperience) {
    return {
      "id": laborExperience.id,
      'company': laborExperience.company,
      'initialDate':
          laborExperience.initialDate.toLocal().toString().split(' ')[0],
      'endDate': laborExperience.endDate.toLocal().toString().split(' ')[0],
      'salary': laborExperience.salary,
      'position': laborExperience.position,
    };
  }
}
