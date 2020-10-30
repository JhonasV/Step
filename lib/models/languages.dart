class Languages {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  int status;

  Languages({this.id, this.status, this.name, this.createdAt, this.updatedAt});

  factory Languages.fromJson(Map<String, dynamic> json) {
    return Languages(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toMap(Languages language) {
    return {
      "id": language.id,
      'status': language.status,
      'name': language.name
    };
  }
}
