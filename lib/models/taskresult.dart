import 'dart:convert';

class TaskResult<T> {
  T data;
  bool success;
  String messages;

  TaskResult({this.data, this.success, this.messages});

  factory TaskResult.fromJson(Map<String, dynamic> json) {
    return new TaskResult<T>(
        data: json['data'],
        success: json['success'],
        messages: json['messages']);
  }
}
