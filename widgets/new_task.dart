import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';

class NewTask extends StatefulWidget {
  const NewTask(
      {super.key,
      required this.onAddTask}); // on peut avoir comme argust d'un constructeur une fonction
  final void Function(Task task) onAddTask;

  @override
  State<NewTask> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {
  Category _selectedCategory = Category.personal;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose(); // Dispose the description controller
    super.dispose();
  }

  // Method to submit task data
  void _submitTaskData() {
    if (_titleController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text(
              'Merci de saisir le titre de la tâche à ajouter dans la liste'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddTask(Task(
      title: _titleController.text,
      description: _descriptionController.text,
      date: DateTime.now(),
      category: _selectedCategory,
    )); //pour recupere et construire tache

    Navigator.of(context).pop(); // Close the screen after submission
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: _titleController,
            decoration: const InputDecoration(
              label: Text('Task Title'),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              label: Text('Task Description'), // Added description field
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              DropdownButton<Category>(
                value: _selectedCategory,
                items: Category.values
                    .map((category) => DropdownMenuItem<Category>(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: _submitTaskData, // Call the submit method
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
