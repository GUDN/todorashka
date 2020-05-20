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
        title: 'Todorashka',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.grey[800],
          canvasColor: Colors.grey[700],
          backgroundColor: Colors.grey[900],
          buttonColor: Colors.grey[800],
          textTheme: const TextTheme(
            button: const TextStyle(
              color: Colors.white
            ),
            headline3: const TextStyle(
              color: Colors.white,
            ),
            headline6: const TextStyle(
              color: Colors.grey,
            ),
            caption: const TextStyle(
              color: Colors.grey,
            ),
            bodyText1: const TextStyle(
              color: Colors.grey
            ),
            bodyText2: const TextStyle(
              color: Colors.white
            )
          ),
          iconTheme: const IconThemeData(
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
