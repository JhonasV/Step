class Roles {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  Roles({this.id, this.name, this.createdAt, this.updatedAt});

  factory Roles.fromJson(Map<String, dynamic> json) {
    return new Roles(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
