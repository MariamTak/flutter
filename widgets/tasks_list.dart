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
