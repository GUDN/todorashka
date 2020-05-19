import 'package:flutter/material.dart';
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
              Navigator.pushNamed(context, '/list');
            },
            icon: const Icon(Icons.format_list_bulleted)
          )
        ],
      ),
      body: Center(
        child: CurrentTodo(),
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
  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<TodoList>(context);
    var todo = todos.current;

    if (todo == null)
      return Text('No current todo');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(todo.todo),
        Text(todo.creationTime.toString())
      ],
    );
  }
}
