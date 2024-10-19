import 'package:flutter/material.dart';
import 'page1.dart'; // Import your main page

class Login extends StatefulWidget {
  const Login();

  @override
  LoginPage createState() {
    return LoginPage();
  }
}

class LoginPage extends State<Login> {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  Future<void> handlePressed() async {
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, display a dialog and navigate to Page1
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Nice!'),
          content: Text('Hello, $email!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page1()),
                );
              },
              child: const Text('Thanks!'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6D8F0), // Pastel purple background
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Card(
          color: const Color(0xFFFBF2FF), // Light pastel purple card
          shadowColor: Colors.purple[200], // Soft shadow color
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'My To-Do List',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF7A5BBA),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.purple),
                      ),
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.purple),
                      ),
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText =
                                !_obscureText; // Toggle password visibility
                          });
                        },
                      ),
                    ),
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: handlePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7A5BBA), // Button color
                      foregroundColor: Colors.white, // Text color for button
                    ),
                    child: const Text("Login"),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Navigate to signup or password recovery page
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
