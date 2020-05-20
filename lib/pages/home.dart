import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/todo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateFormat _dateFormat = DateFormat('dd.MM.yyyy H:mm');

  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<TodoList>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
        centerTitle: true,
        actionsIconTheme: Theme.of(context).iconTheme,
        actions: <Widget>[
          if (todos.current != null) IconButton(
            onPressed: () {
              todos.pop();
            },
            icon: const Icon(Icons.done)
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/list');
            },
            icon: const Icon(Icons.format_list_bulleted)
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: currentTodo(todos.current),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new');
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget currentTodo(todo) {
    if (todo == null)
      return Text(
        'No current todo',
        style: Theme.of(context).textTheme.headline3,
      );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          todo.todo,
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          _dateFormat.format(todo.creationTime),
          style: Theme.of(context).textTheme.headline6,
        )
      ],
    );
  }
}
