class Trainings {
  int id;
  String description;
  String level;
  DateTime initalDate;
  DateTime endDate;
  String academy;

  Trainings({
    this.id,
    this.description,
    this.level,
    this.initalDate,
    this.endDate,
    this.academy,
  });

  factory Trainings.fromJson(Map<String, dynamic> json) {
    return Trainings(
      id: json['id'],
      description: json['description'],
      level: json['level'],
      initalDate: DateTime.parse(json['initialDate']),
      endDate: DateTime.parse(json['endDate']),
      academy: json['academy'],
    );
  }

  Map<String, dynamic> toMap(Trainings trainings) {
    return {
      'id': trainings.id,
      'description': trainings.description,
      'level': trainings.level,
      'initalDate': trainings.initalDate,
      'endDate': trainings.endDate,
      'academy': trainings.academy,
    };
  }
}
