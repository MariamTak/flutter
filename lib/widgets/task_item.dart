import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function(String) onDelete;

  const TaskItem({
    super.key,
    required this.task,
    required this.onDelete,
  });

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text("Update"),
              onTap: () {
                Navigator.of(context).pop();
                // Implement update functionality here
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text("Delete"),
              onTap: () {
                Navigator.of(context).pop();
                onDelete(task.title);  // Call the delete function
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(task.date);

    return GestureDetector(
      onTap: () => _showOptions(context),
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              if (task.description.isNotEmpty)
                Text(
                  task.description,
                  style: const TextStyle(color: Colors.grey),
                ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category: ${task.category.toString().split('.').last}',
                    style: const TextStyle(fontSize: 14, color: Colors.purple),
                  ),
                  Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
