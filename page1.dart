import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Thank You'),
        backgroundColor: const Color(0xFF7A5BBA), // AppBar color
        actions: [
          /*IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // Navigate back to the login page
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),*/
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              // Show an information dialog or navigate to another page
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Information'),
                  content: const Text('This is an example of an info dialog.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
          // Add more buttons as needed
        ],
      ),
      body: const Center(
        child: Text(
          'Page 1',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
