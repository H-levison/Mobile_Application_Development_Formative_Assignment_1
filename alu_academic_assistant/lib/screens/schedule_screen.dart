import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/data_models.dart';
import '../theme/alu_colors.dart';

class ScheduleScreen extends StatefulWidget {
  final List<AcademicSession> sessions;
  final Function(AcademicSession) onAdd;
  final Function(String, bool?) onAttendanceMarked;

  const ScheduleScreen({Key? key, required this.sessions, required this.onAdd, required this.onAttendanceMarked}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {

  void _showAddSessionDialog() {
    final _titleController = TextEditingController();
    DateTime _selectedDate = DateTime.now();
    TimeOfDay _start = const TimeOfDay(hour: 9, minute: 0);
    TimeOfDay _end = const TimeOfDay(hour: 10, minute: 30);
    String _type = 'Class';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Session Title')),
              DropdownButton<String>(
                value: _type,
                items: ['Class', 'Mastery Session', 'Study Group', 'PSL Meeting'].map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                onChanged: (val) => setModalState(() => _type = val!),
              ),
              ListTile(
                title: Text("Date: ${DateFormat('MMM d').format(_selectedDate)}"),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final d = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2025), lastDate: DateTime(2030));
                  if (d != null) setModalState(() => _selectedDate = d);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: ALUColors.primaryMaroon),
                onPressed: () {
                  widget.onAdd(AcademicSession(
                    id: const Uuid().v4(),
                    title: _titleController.text,
                    date: _selectedDate,
                    startTime: _start.format(context),
                    endTime: _end.format(context),
                    type: _type,
                  ));
                  Navigator.pop(context);
                },
                child: const Text("Add Session", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Schedule"), backgroundColor: ALUColors.primaryMaroon, actions: [IconButton(onPressed: _showAddSessionDialog, icon: const Icon(Icons.add))]),
      body: ListView.builder(
        itemCount: widget.sessions.length,
        itemBuilder: (ctx, i) {
          final s = widget.sessions[i];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ExpansionTile(
              title: Text(s.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("${DateFormat('MMM d').format(s.date)} | ${s.startTime}"),
              leading: Icon(Icons.event, color: ALUColors.primaryGold),
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Were you present?"),
                      ChoiceChip(
                        label: const Text("Present"),
                        selected: s.isPresent == true,
                        selectedColor: ALUColors.successGreen,
                        onSelected: (selected) => widget.onAttendanceMarked(s.id, true),
                      ),
                      ChoiceChip(
                        label: const Text("Absent"),
                        selected: s.isPresent == false,
                        selectedColor: ALUColors.warningRed,
                        onSelected: (selected) => widget.onAttendanceMarked(s.id, false),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}