import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/data_models.dart';

class DataService {
  static const String _assignmentsKey = 'assignments';
  static const String _sessionsKey = 'sessions';

  Future<void> saveAssignments(List<Assignment> assignments) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(assignments.map((e) => e.toJson()).toList());
    await prefs.setString(_assignmentsKey, encodedData);
  }

  Future<List<Assignment>> getAssignments() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(_assignmentsKey);
    if (encodedData == null) return [];
    final List<dynamic> decodedData = jsonDecode(encodedData);
    return decodedData.map((e) => Assignment.fromJson(e)).toList();
  }

  Future<void> saveSessions(List<AcademicSession> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(sessions.map((e) => e.toJson()).toList());
    await prefs.setString(_sessionsKey, encodedData);
  }

  Future<List<AcademicSession>> getSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(_sessionsKey);
    if (encodedData == null) return [];
    final List<dynamic> decodedData = jsonDecode(encodedData);
    return decodedData.map((e) => AcademicSession.fromJson(e)).toList();
  }
}