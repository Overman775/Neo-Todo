import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/pages_arguments.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/models/todo.dart';

class AddTask extends StatefulWidget {
  final PageArguments args;
  AddTask(this.args, {Key key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState(args);
}

class _AddTaskState extends State<AddTask> {
  PageArguments args;

  _AddTaskState(this.args);

  final _formKey = GlobalKey<FormState>();
  final _titleFormController = TextEditingController();
  final _descriptionFormController = TextEditingController();
  
  TodoModel todo;

  @override
  void initState() {
    super.initState();
    todo = Provider.of<TodoModel>(context, listen: false);
    _initForm();
  }

  void _initForm() {
    if (_argsHaveTask) {
      _titleFormController.text = args.task.title;
      _descriptionFormController.text = args.task.description;
    }
  }

  bool get _argsHaveTask => args?.task != null;

  void _saveForm() {
    if (_formKey.currentState.validate()) {
      if (_argsHaveTask) {
        todo.editTodo(args.task, Task(
            title: _titleFormController.text,
            description: _descriptionFormController.text));
      } else {
        todo.addTodo(Task(
            title: _titleFormController.text,
            description: _descriptionFormController.text));
      }

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
    log('Open task ${args?.task?.title}');
    return Scaffold(
      appBar: AppBar(
        title: _argsHaveTask? Text(args.task.title) : Text('Add Task'),
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
