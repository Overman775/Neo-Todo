import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todolist/models/pages_arguments.dart';

class AddTask extends StatefulWidget {
  AddTask({Key key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    final PageArguments args = ModalRoute.of(context).settings.arguments;
    log('Open task ${args?.task?.title}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Container(),
    );
  }
}
