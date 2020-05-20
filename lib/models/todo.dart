import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/database.dart';

class Todo {
  String todo;
  DateTime creationTime;
  int index;
  int id;
  
  Todo({ @required String todo, DateTime creationTime, int index, int id })
      : todo = todo,
        creationTime = creationTime ?? DateTime.now(),
        index = index,
        id = id;
}

class TodoList extends ChangeNotifier {
  final List<Todo> _todos = [];

  Todo get current => _todos.length > 0 ? _todos[0] : null;
  int get length => _todos.length;
  List<Todo> get todos => _todos;

  void add(List<Todo> todos) async {
    var index = await getLastIndex() + 1;
    final Database database = await DBProvider.db.database;
    for (var i = 0; i < todos.length; ++i) {
      todos[i].id = await database.insert(
          'todo',
          {
            'todo': todos[i].todo,
            'creationTime': todos[i].creationTime.millisecondsSinceEpoch,
            'index_': index
          },
          conflictAlgorithm: ConflictAlgorithm.abort
      );
      todos[i].index = index;
      index += 1;
    }
    _todos.addAll(todos);
    notifyListeners();
  }

  void pop() async {
    final Database database = await DBProvider.db.database;
    final int result = await database.delete(
      'todo',
      where: 'id = ?',
      whereArgs: [_todos[0].id]
    );
    if (result == 0)
      return;
    _todos.removeAt(0);
    updateIndexes();
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    _todos.insert(newIndex, _todos[oldIndex]);
    if (oldIndex < newIndex)
      _todos.removeAt(oldIndex);
    else
      _todos.removeAt(oldIndex + 1);
    updateIndexes();
    notifyListeners();
  }

  Future<int> getLastIndex() async {
    final Database database = await DBProvider.db.database;
    final query = await database.query(
      'todo',
      columns: ['index_'],
      orderBy: '-index_',
      limit: 1
    );
    if (query.length > 0)
      return (query[0]['index_'] as int);
    return -1;
  }

  void updateIndexes() async {
    final Database database = await DBProvider.db.database;
    final batch = database.batch();
    _todos.asMap().forEach((index, value) {
      batch.update(
        'todo',
        {'index_': index},
        where: 'id = ?',
        whereArgs: [value.id]
      );
      _todos[index].index = index;
    });
    batch.commit(noResult: true);
  }

  void loadFromDatabase() async {
    final Database database = await DBProvider.db.database;
    final List<Map<String, dynamic>> records = await database.query(
      'todo',
      orderBy: 'index_'
    );
    records.forEach((element) {
      _todos.add(Todo(
        todo: element['todo'],
        creationTime: DateTime.fromMillisecondsSinceEpoch(element['creationTime']),
        id: element['id'],
        index: element['index_']
      ));
    });
    notifyListeners();
  }
}