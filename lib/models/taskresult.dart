import 'dart:convert';

class TaskResult<T> {
  T data;
  bool success;
  String messages;

  TaskResult({this.data, this.success = false, this.messages = ""});

  factory TaskResult.fromJson(Map<String, dynamic> json, T data) {
    return new TaskResult<T>(
        data: data, success: json['success'], messages: json['messages']);
  }
}
