import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/todo.dart';

class ListTodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All todo'),
        centerTitle: true,
      ),
      body: ListTodo()
    );
  }
}

class ListTodo extends StatefulWidget {
  @override
  _ListTodoState createState() => _ListTodoState();
}

class _ListTodoState extends State<ListTodo> {
  final DateFormat _dateFormat = DateFormat('dd.MM.yyyy H:mm');
  
  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<TodoList>(context);

    if (todos.length == 0)
      return Center(
        child: Text(
          'No todos',
          style: Theme.of(context).textTheme.headline3
        )
      );

    return ReorderableListView(
      onReorder: todos.reorder,
      children: <Widget>[
        for (final todo in todos.todos)
          ListTile(
            key: ValueKey(todo.creationTime.toString()),
            title: Text(todo.todo),
            subtitle: Text(_dateFormat.format(todo.creationTime)),
            trailing: const Icon(Icons.drag_handle),
          ),
      ],
    );
  }
}
