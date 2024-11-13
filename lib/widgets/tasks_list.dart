import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist_app/services/firestore.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/widgets/task_item.dart';

class TasksList extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();
  final List<Task> tasks; 
  TasksList({super.key, required this.tasks});  // Updated constructor

  void _deleteTask(String taskTitle) async {
  int deletedCount = await firestoreService.deleteTaskByTitle(taskTitle);
  print('$deletedCount tasks deleted.'); 
}


  void _updateTask(Task task) {
    // Implement update functionality, e.g., open a dialog with task data to edit
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getTasks(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final taskLists = snapshot.data!.docs;
        List<Task> taskItems = [];

        for (var document in taskLists) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;

          String title = data['taskTitle']?.toString() ?? 'Untitled';
          String description = data['taskDesc']?.toString() ?? '';
          DateTime date = data['taskDate'] != null
              ? DateTime.tryParse(data['taskDate'].toString()) ?? DateTime.now()
              : DateTime.now();

          String categoryString = (data['taskCategory'] ?? 'personal').toLowerCase();
          Category category;
          switch (categoryString) {
            case 'personal':
              category = Category.personal;
              break;
            case 'work':
              category = Category.work;
              break;
            case 'shopping':
              category = Category.shopping;
              break;
            default:
              category = Category.others;
          }

          Task task = Task(
            title: title,
            description: description,
            date: date,
            category: category,
          );

          taskItems.add(task);
        }

        return ListView.builder(
          itemCount: taskItems.length,
          itemBuilder: (ctx, index) {
            return TaskItem(
              task: taskItems[index],
              onDelete: _deleteTask,
            );
          },
        );
      },
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:intl/intl.dart'; // Import intl package

class TasksList extends StatelessWidget {
  final List<Task> tasks;

  const TasksList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (ctx, index) {
        final task = tasks[index];
        // Format the date and time using DateFormat from intl package
        final formattedDateTime =
            DateFormat('dd/MM/yyyy HH:mm').format(task.date);

        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListTile(
            title: Text(
              task.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (task.description.isNotEmpty) Text(task.description),
                const SizedBox(height: 5),
                Text(
                  'Added on: $formattedDateTime', // Display the formatted date and time
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
*/
