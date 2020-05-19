import 'package:flutter/material.dart';

class ListTodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All todo'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('All todo here'),
      )
    );
  }
}
