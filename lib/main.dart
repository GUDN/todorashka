import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/pages/home.dart' show HomePage;
import 'package:todoapp/pages/list_todo.dart' show ListTodoPage;
import 'package:todoapp/pages/new_todo.dart' show NewTodoPage;

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoList(),
      child: MaterialApp(
        title: 'Todo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          buttonColor: Colors.blue[400],
          textTheme: const TextTheme(
            button: const TextStyle(
              color: Colors.white
            )
          ),
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
      ),
    );
  }
}
