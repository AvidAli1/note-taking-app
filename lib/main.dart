import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note_view_model.dart'; // Replace 'task_viewModel.dart' with 'note_view_model.dart'
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'welcome_screen.dart'; // Keep this if you have a Welcome Screen

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter bindings are initialized before Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteViewModel(), // Use NoteViewModel here
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App', // Update the title to Notes App
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WelcomeScreen(), // Start with the Welcome Screen
      ),
    );
  }
}
