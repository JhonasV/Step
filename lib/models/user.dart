import 'package:Step/models/roles.dart';

import 'entitie.dart';

class User {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String userName;
  String password;
  List<Roles> roles;
  User({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.password,
    this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
      id: json['id'] as int,
      createdAt: json['createdAt'] as DateTime,
      userName: json['userName'],
      password: json['password'],
      roles: json['roles'].map<Roles>((json) => Roles.fromJson(json)).toList(),
    );
  }
}
