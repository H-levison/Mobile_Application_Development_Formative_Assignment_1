import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/data_models.dart';
import '../theme/alu_colors.dart';

class AssignmentsScreen extends StatefulWidget {
  final List<Assignment> assignments;
  final Function(Assignment) onAdd;
  final Function(String) onDelete;
  final Function(String) onToggle;

  const AssignmentsScreen({Key? key, required this.assignments, required this.onAdd, required this.onDelete, required this.onToggle}) : super(key: key);

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  // We keep the logic simple here for the "Add" modal
  void _showAddDialog() {
    final _titleController = TextEditingController();
    final _courseController = TextEditingController();
    DateTime _selectedDate = DateTime.now();
    String _priority = 'Medium';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Assignment Title')),
              TextField(controller: _courseController, decoration: const InputDecoration(labelText: 'Course Name')),
              DropdownButton<String>(
                value: _priority,
                items: ['High', 'Medium', 'Low'].map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                onChanged: (val) => setModalState(() => _priority = val!),
              ),
              Row(
                children: [
                  Text("Due Date: ${DateFormat('MMM d').format(_selectedDate)}"),
                  IconButton(
                    icon: const Icon(Icons.calendar_today, color: ALUColors.primaryMaroon),
                    onPressed: () async {
                      final d = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2030));
                      if (d != null) setModalState(() => _selectedDate = d);
                    },
                  )
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: ALUColors.primaryMaroon),
                onPressed: () {
                  if (_titleController.text.isEmpty) return;
                  widget.onAdd(Assignment(
                    id: const Uuid().v4(),
                    title: _titleController.text,
                    courseName: _courseController.text,
                    dueDate: _selectedDate,
                    priority: _priority,
                  ));
                  Navigator.pop(context);
                },
                child: const Text("Add Assignment", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sort by due date
    final sortedList = List<Assignment>.from(widget.assignments)..sort((a, b) => a.dueDate.compareTo(b.dueDate));

    return Scaffold(
      appBar: AppBar(title: const Text("Assignments"), backgroundColor: ALUColors.primaryMaroon, actions: [IconButton(onPressed: _showAddDialog, icon: const Icon(Icons.add))]),
      body: ListView.builder(
        itemCount: sortedList.length,
        itemBuilder: (ctx, i) {
          final item = sortedList[i];
          return Dismissible(
            key: Key(item.id),
            background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.delete, color: Colors.white)),
            onDismissed: (_) => widget.onDelete(item.id),
            child: CheckboxListTile(
              title: Text(item.title, style: TextStyle(decoration: item.isCompleted ? TextDecoration.lineThrough : null)),
              subtitle: Text("${item.courseName} - ${DateFormat('MMM d').format(item.dueDate)}"),
              value: item.isCompleted,
              activeColor: ALUColors.primaryGold,
              onChanged: (_) => widget.onToggle(item.id),
              secondary: CircleAvatar(
                backgroundColor: item.priority == 'High' ? Colors.red[100] : Colors.grey[200],
                child: Text(item.priority[0], style: TextStyle(color: item.priority == 'High' ? Colors.red : Colors.black)),
              ),
            ),
          );
        },
      ),
    );
  }
}