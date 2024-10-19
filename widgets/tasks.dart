import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/widgets/new_task.dart';
import 'tasks_list.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() {
    return _TasksState();
  }
}

class _TasksState extends State<Tasks> {
  final List<Task> _registeredTasks = [
    Task(
      title: 'Apprendre Flutter',
      description: 'Suivre le cours pour apprendre de nouvelles compétences',
      date: DateTime.now(),
      category: Category.work,
    ),
    Task(
      title: 'Faire les courses',
      description: 'Acheter des provisions pour la semaine',
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: Category.shopping,
    ),
    Task(
      title: 'Rédiger un CR',
      description: '',
      date: DateTime.now(),
      category: Category.personal,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My To Do List',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 72, 26, 61),
          ),
        ),
        backgroundColor: const Color(0xFFCAA6D6), // Pastel mauve
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Tasks',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B466D), // Darker mauve
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: TasksList(tasks: _registeredTasks),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTaskOverlay,
        backgroundColor: const Color(0xFFCAA6D6), // Pastel mauve
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addTask(Task task) async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _registeredTasks.add(task);
    });
  }

  void _openAddTaskOverlay() {
    showModalBottomSheet(
      backgroundColor: const Color(0xFFEBD9F0), // Lighter pastel mauve
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      isScrollControlled: false, // Set to false to prevent full screen height
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Wrap(
          // Use Wrap to limit the height to the content
          children: [
            NewTask(onAddTask: _addTask),
          ],
        ),
      ),
    );
  }
}
