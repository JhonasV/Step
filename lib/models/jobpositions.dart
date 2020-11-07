class JobPositions {
  int id;
  String riskLevel;
  String name;
  double salaryMinLevel;
  double salaryMaxLevel;
  int status;

  JobPositions(
      {this.id,
      this.riskLevel,
      this.name,
      this.salaryMaxLevel,
      this.salaryMinLevel,
      this.status});

  factory JobPositions.fromJson(Map<String, dynamic> json) {
    return JobPositions(
        id: json['id'],
        riskLevel: json['riskLevel'],
        name: json['name'],
        salaryMinLevel: json['salaryMinLevel'].toDouble(),
        salaryMaxLevel: json['salaryMaxLevel'].toDouble(),
        status: json['status']);
  }

  Map<String, dynamic> toMap(JobPositions jobPositions) {
    return {
      'id': jobPositions.id,
      'riskLevel': jobPositions.riskLevel,
      'name': jobPositions.name,
      'salaryMaxLevel': jobPositions.salaryMaxLevel,
      'salaryMinLevel': jobPositions.salaryMinLevel,
      'status': jobPositions.status
    };
  }
}
