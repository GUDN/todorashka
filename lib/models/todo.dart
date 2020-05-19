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
  int get length => _todos.length;
  List<Todo> get todos => _todos;

  void add(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void pop() {
    _todos.removeAt(0);
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    _todos.insert(newIndex, _todos[oldIndex]);
    if (oldIndex < newIndex)
      _todos.removeAt(oldIndex);
    else
      _todos.removeAt(oldIndex + 1);
    notifyListeners();
  }
}