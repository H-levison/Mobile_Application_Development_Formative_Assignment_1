import 'dart:convert';

class Assignment {
  final String id;
  final String title;
  final DateTime dueDate;
  final String courseName;
  final String priority; // 'High', 'Medium', 'Low'
  bool isCompleted;

  Assignment({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.courseName,
    this.priority = 'Medium',
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'dueDate': dueDate.toIso8601String(),
    'courseName': courseName,
    'priority': priority,
    'isCompleted': isCompleted,
  };

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
    id: json['id'],
    title: json['title'],
    dueDate: DateTime.parse(json['dueDate']),
    courseName: json['courseName'],
    priority: json['priority'],
    isCompleted: json['isCompleted'],
  );
}

class AcademicSession {
  final String id;
  final String title;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String type; // 'Class', 'Mastery Session', etc.
  bool? isPresent; // null = not marked yet, true = present, false = absent

  AcademicSession({
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.type,
    this.isPresent,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'date': date.toIso8601String(),
    'startTime': startTime,
    'endTime': endTime,
    'type': type,
    'isPresent': isPresent,
  };

  factory AcademicSession.fromJson(Map<String, dynamic> json) => AcademicSession(
    id: json['id'],
    title: json['title'],
    date: DateTime.parse(json['date']),
    startTime: json['startTime'],
    endTime: json['endTime'],
    type: json['type'],
    isPresent: json['isPresent'],
  );
}                                      