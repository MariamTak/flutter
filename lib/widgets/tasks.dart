import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/widgets/task_item.dart';
import 'package:todolist_app/widgets/new_task.dart';
import 'package:todolist_app/services/firestore.dart';
import 'tasks_list.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final FirestoreService firestoreService = FirestoreService();
  final List<Task> _registeredTasks = [
  ];

void _addTask(Task task) async {
  await firestoreService.addTask(task);
  setState(() {
    _registeredTasks.add(task);
  });
}



void _openAddTaskOverlay() {
  showModalBottomSheet(
    backgroundColor: const Color(0xFFEBD9F0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    context: context,
    isScrollControlled: true,
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Wrap(
        children: [
          NewTask(
            onAddTask: (task) {
              _addTask(task); // This adds the task and updates Firestore
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My To Do List',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 72, 26, 61)),
        ),
        backgroundColor: const Color(0xFFCAA6D6),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Tasks',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF6B466D)),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: TasksList(
              tasks: _registeredTasks,
             
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTaskOverlay,
        backgroundColor: const Color(0xFFCAA6D6),
        child: const Icon(Icons.add),
      ),
    );
  }
}