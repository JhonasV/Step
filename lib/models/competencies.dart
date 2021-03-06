class Competencies {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String description;
  int status;

  Competencies({this.id, this.description, this.status});

  factory Competencies.fromJson(Map<String, dynamic> json) {
    return Competencies(
        id: json["id"],
        description: json["description"],
        status: json["status"]);
  }

  Map<String, dynamic> toMap(Competencies competencies) {
    return {"description": competencies.description};
  }

  static List<Competencies> toList(dynamic responseBody) {
    return responseBody
        .map<Competencies>((json) => Competencies.fromJson(json))
        .toList();
  }
}
