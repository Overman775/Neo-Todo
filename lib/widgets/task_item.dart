import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/pages_arguments.dart';
import 'package:todolist/bloc/todo.dart';
import 'package:todolist/models/todo_models.dart';

import 'package:todolist/style.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItem item;
  final TodoCategory category;

  TodoItemWidget(this.item, this.category);

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
                value: item.completed,
                onChanged: (bool checked) {
                  context.read<Todo>().toggleItem(item);
                },
              ),
              title: Text(item.title),
              subtitle:
                  item.description != null ? Text(item.description) : null,
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
                unawaited(Navigator.pushNamed(context, '/item',
                    arguments: ItemPageArguments(item: item, category: category)));
                return false;
              } else {
                /// delete
                return true;
              }
            },
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                context.read<Todo>().deleteItem(item);
              } else {}
            },
          ),
        ),
      ),
    );
  }
}
