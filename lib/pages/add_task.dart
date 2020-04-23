import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/pages_arguments.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/models/todo.dart';

class AddTask extends StatefulWidget {
  AddTask({Key key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  final _titleFormController = TextEditingController();
  final _descriptionFormController = TextEditingController();

  TodoModel todo;

  @override
  void initState() {
    super.initState();
    todo = Provider.of<TodoModel>(context, listen: false);
  }

  void _saveForm() {
    if (_formKey.currentState.validate()) {
      todo.addTodo(Task(
          title: _titleFormController.text,
          description: _descriptionFormController.text));
      //go back
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleFormController.dispose();
    _descriptionFormController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PageArguments args = ModalRoute.of(context).settings.arguments;
    log('Open task ${args?.task?.title}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Заголовок'),
                controller: _titleFormController,
                autofocus: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Введите текст';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Описание'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                controller: _descriptionFormController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: _saveForm,
                  child: Text('Сохранить'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
