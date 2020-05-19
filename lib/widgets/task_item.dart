import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';
import '../models/pages_arguments.dart';
import '../models/task.dart';
import '../bloc/todo.dart';

import '../style.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          Style.mainPadding, Style.mainPadding, Style.mainPadding, 0.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: Style.mainBorderRadius,
            color: Style.bgColor,
            boxShadow: Style.boxShadows),
        child: ClipRRect(
          borderRadius: Style.mainBorderRadius,
          child: Dismissible(
            key: UniqueKey(),
            child: ListTile(
              leading: Checkbox(
                value: task.completed,
                onChanged: (bool checked) {
                  Provider.of<Todo>(context, listen: false)
                      .toggleTodo(task);
                },
              ),
              title: Text(task.title),
              subtitle:
                  task.description != null ? Text(task.description) : null,
            ),
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 10.0),
              color: Style.deleteColor,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            background: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10.0),
              color: Style.editColor,
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                /// edit
                unawaited(Navigator.pushNamed(context, '/task',
                    arguments: PageArguments(task: task)));
                return false;
              } else {
                /// delete
                return true;
              }
            },
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                Provider.of<Todo>(context, listen: false).deleteTodo(task);
              } else {}
            },
          ),
        ),
      ),
    );
  }
}
