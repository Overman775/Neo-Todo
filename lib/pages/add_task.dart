import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/todo.dart';
import '../models/task.dart';
import '../style.dart';

class AddTask extends StatefulWidget {
  final args;
  AddTask(this.args, {Key key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState(args);
}

class _AddTaskState extends State<AddTask> {
  final args;

  _AddTaskState(this.args);

  final _formKey = GlobalKey<FormState>();
  final _titleFormController = TextEditingController();
  final _descriptionFormController = TextEditingController();

  Todo todo;

  @override
  void initState() {
    super.initState();
    todo = Provider.of<Todo>(context, listen: false);
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
        todo.editTodo(
            args.task,
            Task(
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
        title: _argsHaveTask ? Text(args.task.title) : Text('Новая задача'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 16),
        child: Form(
          key: _formKey,
          child: Wrap(
            direction: Axis.horizontal,
            runSpacing: Style.doublePadding,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: Style.mainBorderRadius,
                    color: Style.bgColor,
                    boxShadow: Style.boxShadows),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Заголовок',
                      contentPadding: EdgeInsets.all(Style.mainPadding),
                      border: OutlineInputBorder(
                        borderRadius: Style.mainBorderRadius,
                      )),
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
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: Style.mainBorderRadius,
                    color: Style.bgColor,
                    boxShadow: Style.boxShadows),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Описание',
                      contentPadding: EdgeInsets.all(Style.mainPadding),
                      border: OutlineInputBorder(
                          borderRadius: Style.mainBorderRadius)),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  controller: _descriptionFormController,
                ),
              ),
              Center(
                child: ClipRRect(
                    borderRadius: Style.mainBorderRadius,
                    child: FlatButton(
                    color: Style.primaryColor,
                    onPressed: _saveForm,
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: Style.mainPadding, horizontal:  Style.doublePadding),
                        decoration: BoxDecoration(
                          gradient: Style.addButtonGradient,
                          borderRadius: Style.mainBorderRadius,
                          border: Border.all(
                            color: Style.primaryColor,
                            width: 3
                          ),
                          boxShadow: Style.buttonGlow
                        ),
                        child: Text(
                          'Сохранить',
                          style: Style.buttonTextStyle,
                          )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
