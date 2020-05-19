import 'package:flutter/material.dart';
import 'package:todoapp/pages/home.dart' show HomePage;
import 'package:todoapp/pages/list_todo.dart' show ListTodoPage;
import 'package:todoapp/pages/new_todo.dart' show NewTodoPage;

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => HomePage(),
        '/new': (context) => NewTodoPage(),
        '/list': (context) => ListTodoPage()
      },
    );
  }
}
