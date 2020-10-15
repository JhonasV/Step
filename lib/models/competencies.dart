class Competencies {
  int id;
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
}
