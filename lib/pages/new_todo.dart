import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/todo.dart';

class NewTodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New todo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NewTodoForm(),
      ),
    );
  }
}

class NewTodoForm extends StatefulWidget {
  @override
  _NewTodoFormState createState() => _NewTodoFormState();
}

class _NewTodoFormState extends State<NewTodoForm> {
  final _formKey = GlobalKey<FormState>();
  final _todoInputController = TextEditingController();

  @override
  void dispose() {
    _todoInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 10),
          TextFormField(
            controller: _todoInputController,
            autocorrect: true,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Enter some todo',
              contentPadding: EdgeInsets.symmetric(horizontal: 5)
            ),
            validator: (value) => value.trim().length > 0 ? null : 'Enter todo',
          ),
          RaisedButton.icon(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _todoInputController.text = _todoInputController.text.trim();
                createTodo();
              }
            },
            icon: const Icon(Icons.add),
            label: Text('Save todo'),
            textColor: Theme.of(context).textTheme.button.color,
            color: Theme.of(context).buttonColor,
          )
        ],
      )
    );
  }

  void createTodo() {
    Provider.of<TodoList>(context, listen: false)
      .add(Todo(todo: _todoInputController.text));
    if (Navigator.canPop(context))
      Navigator.pop(context);
  }
}
