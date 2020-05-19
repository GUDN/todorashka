import 'package:flutter/material.dart';

class NewTodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New todo'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('New todo here'),
      )
    );
  }
}
