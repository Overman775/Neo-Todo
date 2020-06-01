import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/todo.dart';
import '../models/pages_arguments.dart';
import '../models/todo_models.dart';
import '../style.dart';

class AddItem extends StatefulWidget {
  final ItemPageArguments args;
  AddItem(this.args, {Key key}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState(args);
}

class _AddItemState extends State<AddItem> {
  final ItemPageArguments args;

  _AddItemState(this.args);

  final _formKey = GlobalKey<FormState>();
  final _titleFormController = TextEditingController();
  final _descriptionFormController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initForm();
  }

  void _initForm() {
    if (_argsHaveitem) {
      _titleFormController.text = args.item.title;
      _descriptionFormController.text = args.item.description;
    }
  }

  bool get _argsHaveitem => args?.item != null;

  //TODO: refactoring form + update style
  void _saveForm() async {
    if (_formKey.currentState.validate()) {
      if (_argsHaveitem) {
        await context.read<Todo>().editItem(
            args.item,
            TodoItem(
                id: args.item.id,
                category: args.category.id,
                title: _titleFormController.text,
                description: _descriptionFormController.text,
                completed: args.item.completed));
      } else {
        await context.read<Todo>().addItem(TodoItem(
            category: args.category.id,
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
    log('Open item ${args?.item?.title}');
    return Scaffold(
      appBar: AppBar(
        title: _argsHaveitem ? Text(args.item.title) : Text('Новая задача'),
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
                        padding: EdgeInsets.symmetric(
                            vertical: Style.mainPadding,
                            horizontal: Style.doublePadding),
                        decoration: BoxDecoration(
                            gradient: Style.addButtonGradient,
                            borderRadius: Style.mainBorderRadius,
                            border:
                                Border.all(color: Style.primaryColor, width: 3),
                            boxShadow: Style.buttonGlow),
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
