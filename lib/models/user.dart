import 'entitie.dart';

class User {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String userName;
  String password;

  User({this.id, this.createdAt, this.updatedAt, this.userName, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      userName: json['userName'],
      password: json['password'],
    );
  }
}
