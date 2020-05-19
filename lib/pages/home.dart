import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/todo.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
        centerTitle: true,
        actionsIconTheme: Theme.of(context).iconTheme,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Provider.of<TodoList>(context, listen: false).pop();
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
          child: CurrentTodo(),
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
}

class CurrentTodo extends StatefulWidget {
  @override
  _CurrentTodoState createState() => _CurrentTodoState();
}

class _CurrentTodoState extends State<CurrentTodo> {
  final DateFormat _dateFormat = DateFormat('dd.MM.yyyy H:mm');

  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<TodoList>(context);
    var todo = todos.current;

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
