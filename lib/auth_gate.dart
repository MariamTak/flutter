
import 'package:todolist_app/widgets/tasks.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as ui_auth; // Alias for firebase_ui_auth

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData) {
          // Use the correct EmailAuthProvider from firebase_ui_auth package
          return ui_auth.SignInScreen(
            providers: [
              ui_auth.EmailAuthProvider(), // Use the correct provider
            ],
          );
        } else {
          return const Tasks();
        }
      },
    );
  }
}
