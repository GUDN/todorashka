import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';

class Todo {
  String todo;
  DateTime creationTime;
  
  Todo({ @required String todo, DateTime creationTime })
      : todo = todo,
        creationTime = creationTime ?? DateTime.now();
}

class TodoList extends ChangeNotifier {
  final List<Todo> _todos = [];

  Todo get current => _todos.length > 0 ? _todos[0] : null;
  List<Todo> get todos => _todos;

  void add(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void pop() {
    _todos.removeAt(0);
    notifyListeners();
  }
}