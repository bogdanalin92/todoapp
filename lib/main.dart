import 'package:flutter/material.dart';
import 'package:todoapp/mainScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TodoApp());
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        primaryColor: Colors.lightGreen[700],
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}
