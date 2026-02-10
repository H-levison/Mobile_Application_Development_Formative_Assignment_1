import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/data_models.dart';
import 'services/data_service.dart';
import 'screens/dashboard_screen.dart';
import 'screens/assignments_screen.dart';
import 'screens/schedule_screen.dart';
import 'theme/alu_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ALUApp());
}

class ALUApp extends StatefulWidget {
  const ALUApp({Key? key}) : super(key: key);

  @override
  State<ALUApp> createState() => _ALUAppState();
}

class _ALUAppState extends State<ALUApp> {
  final DataService _dataService = DataService();
  List<Assignment> _assignments = [];
  List<AcademicSession> _sessions = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final a = await _dataService.getAssignments();
    final s = await _dataService.getSessions();
    setState(() {
      _assignments = a;
      _sessions = s;
    });
  }

  // --- Handlers ---
  void _addAssignment(Assignment a) {
    setState(() => _assignments.add(a));
    _dataService.saveAssignments(_assignments);
  }

  void _deleteAssignment(String id) {
    setState(() => _assignments.removeWhere((a) => a.id == id));
    _dataService.saveAssignments(_assignments);
  }

  void _toggleAssignment(String id) {
    setState(() {
      final index = _assignments.indexWhere((a) => a.id == id);
      if (index != -1) {
        _assignments[index].isCompleted = !_assignments[index].isCompleted;
      }
    });
    _dataService.saveAssignments(_assignments);
  }

  void _addSession(AcademicSession s) {
    setState(() => _sessions.add(s));
    _dataService.saveSessions(_sessions);
  }

  void _markAttendance(String id, bool? isPresent) {
    setState(() {
      final index = _sessions.indexWhere((s) => s.id == id);
      if (index != -1) {
        _sessions[index].isPresent = isPresent;
      }
    });
    _dataService.saveSessions(_sessions);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      DashboardScreen(assignments: _assignments, sessions: _sessions),
      AssignmentsScreen(assignments: _assignments, onAdd: _addAssignment, onDelete: _deleteAssignment, onToggle: _toggleAssignment),
      ScheduleScreen(sessions: _sessions, onAdd: _addSession, onAttendanceMarked: _markAttendance),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ALU Academic Assistant',
      theme: ThemeData(primaryColor: ALUColors.primaryMaroon, scaffoldBackgroundColor: ALUColors.background),
      home: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: ALUColors.primaryMaroon,
          unselectedItemColor: Colors.grey,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Assignments'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Schedule'),
          ],
        ),
      ),
    );
  }
}