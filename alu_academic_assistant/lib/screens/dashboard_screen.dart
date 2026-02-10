import 'package:flutter/material.dart';
import '../models/data_models.dart';
import '../theme/alu_colors.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatelessWidget {
  final List<Assignment> assignments;
  final List<AcademicSession> sessions;

  const DashboardScreen({Key? key, required this.assignments, required this.sessions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1. Calculate Logic
    final today = DateTime.now();
    final todaysSessions = sessions.where((s) => isSameDay(s.date, today)).toList();

    // Filter assignments due within 7 days
    final upcomingAssignments = assignments.where((a) {
      final difference = a.dueDate.difference(today).inDays;
      return difference >= 0 && difference <= 7 && !a.isCompleted;
    }).toList();

    // Attendance Math
    int totalMarked = sessions.where((s) => s.isPresent != null).length;
    int totalPresent = sessions.where((s) => s.isPresent == true).length;
    double attendancePercent = totalMarked == 0 ? 100.0 : (totalPresent / totalMarked) * 100;

    return Scaffold(
      backgroundColor: ALUColors.background,
      appBar: AppBar(title: const Text("ALU Assistant"), backgroundColor: ALUColors.primaryMaroon),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Header
            Text(DateFormat('EEEE, MMMM d').format(today), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: ALUColors.primaryMaroon)),
            const SizedBox(height: 20),

            // Attendance Card
            _buildAttendanceCard(attendancePercent),
            const SizedBox(height: 20),

            // Today's Sessions
            const Text("Today's Schedule", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            if (todaysSessions.isEmpty) const Text("No classes today!"),
            ...todaysSessions.map((s) => Card(
              child: ListTile(
                leading: Icon(Icons.class_, color: ALUColors.primaryGold),
                title: Text(s.title),
                subtitle: Text("${s.startTime} - ${s.endTime} | ${s.type}"),
              ),
            )),
            const SizedBox(height: 20),

            // Assignments Due Soon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Due Soon (7 Days)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                CircleAvatar(
                  backgroundColor: ALUColors.primaryMaroon,
                  radius: 14,
                  child: Text("${upcomingAssignments.length}", style: const TextStyle(color: Colors.white, fontSize: 12)),
                )
              ],
            ),
            ...upcomingAssignments.map((a) => Card(
              color: Colors.white,
              child: ListTile(
                title: Text(a.title),
                subtitle: Text("Due: ${DateFormat('MMM d').format(a.dueDate)}"),
                trailing: Text(a.priority, style: TextStyle(color: a.priority == 'High' ? Colors.red : Colors.grey)),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceCard(double percent) {
    bool isWarning = percent < 75;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isWarning ? ALUColors.warningRed.withOpacity(0.1) : ALUColors.successGreen.withOpacity(0.1),
        border: Border.all(color: isWarning ? ALUColors.warningRed : ALUColors.successGreen, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Attendance Rate", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              Text("${percent.toStringAsFixed(1)}%", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: isWarning ? ALUColors.warningRed : ALUColors.successGreen)),
            ],
          ),
          if (isWarning) const Icon(Icons.warning_amber_rounded, color: ALUColors.warningRed, size: 40),
        ],
      ),
    );
  }

  bool isSameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;
}