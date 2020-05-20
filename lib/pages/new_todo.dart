import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/todo.dart';

class NewTodoPage extends StatefulWidget {
  @override
  _NewTodoPageState createState() => _NewTodoPageState();
}

class _NewTodoPageState extends State<NewTodoPage> {
  final _formKey = GlobalKey<FormState>();
  final _todoInputController = TextEditingController();
  final List<String> _todos = [];

  @override
  void dispose() {
    _todoInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('New todo'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: createTodosFirst,
            icon: const Icon(Icons.vertical_align_top),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Text(
              'Long tap to delete',
              style: Theme.of(context).textTheme.caption,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    _todos[index],
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  trailing: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                  onLongPress: () {
                    setState(() {
                      _todos.removeAt(index);
                    });
                  },
                ),
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      controller: _todoInputController,
                      autocorrect: true,
                      autofocus: true,
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: InputDecoration(
                          labelText: 'Enter any todo',
                          labelStyle: Theme.of(context).textTheme.bodyText1,
                          contentPadding: EdgeInsets.symmetric(horizontal: 5)
                      ),
                      validator: (value) => value.trim().length > 0 ? null : 'Enter todo',
                    ),
                    RaisedButton.icon(
                      onPressed: addTodo,
                      icon: const Icon(Icons.add),
                      label: Text('Add another todo'),
                      textColor: Theme.of(context).textTheme.button.color,
                      color: Theme.of(context).buttonColor,
                    )
                  ],
                )
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 75),
        child: FloatingActionButton(
          onPressed: createTodos,
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(
            Icons.vertical_align_bottom,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void createTodos() {
    addTodo();
    Provider.of<TodoList>(context, listen: false)
        .add(_todos.map((e) => Todo(todo: e)).toList());
    if (Navigator.canPop(context))
      Navigator.pop(context);
  }

  void createTodosFirst() {
    addTodo();
    Provider.of<TodoList>(context, listen: false)
        .addFirst(_todos.map((e) => Todo(todo: e)).toList());
    if (Navigator.canPop(context))
      Navigator.pop(context);
  }

  void addTodo() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _todos.add(_todoInputController.text);
      });
      _todoInputController.text = '';
    }
  }
}