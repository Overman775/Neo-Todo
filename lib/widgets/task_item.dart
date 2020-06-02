import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';
import '../models/pages_arguments.dart';
import '../bloc/todo.dart';
import '../models/todo_models.dart';

import '../style.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItem item;
  final TodoCategory category;

  TodoItemWidget(this.item, this.category);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      boxShape: NeumorphicBoxShape.roundRect(Style.mainBorderRadius),
      margin: EdgeInsets.symmetric(vertical: Style.halfPadding),
      style: NeumorphicStyle(depth: 3, intensity: 0.5),
      child: Dismissible(
        key: Key('item_${item.id}'),
        child: ListTile(
          leading: Checkbox(
            value: item.completed,
            onChanged: (bool checked) {
              context.read<Todo>().toggleItem(item);
            },
          ),
          title: Text(item.title),
          subtitle: item.description != null ? Text(item.description) : null,
          //go to edit page
          onTap: () => unawaited(Navigator.pushNamed(context, '/item',
              arguments: ItemPageArguments(item: item, category: category))),
        ),
        background: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Neumorphic(
            drawSurfaceAboveChild: false,
            boxShape: NeumorphicBoxShape.roundRect(Style.mainBorderRadius),
            padding: EdgeInsets.only(left: Style.mainPadding),
            style: NeumorphicStyle(
              depth: -6,
              color: Style.editColor,
              lightSource: LightSource.topLeft,
              intensity: 1,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FaIcon(
                FontAwesomeIcons.check,
                color: Colors.white,
              ),
            ),
          ),
        ),
        secondaryBackground: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Neumorphic(
            drawSurfaceAboveChild: false,
            boxShape: NeumorphicBoxShape.roundRect(Style.mainBorderRadius),
            padding: EdgeInsets.only(right: Style.mainPadding),
            style: NeumorphicStyle(
              depth: -6,
              color: Style.deleteColor,
              lightSource: LightSource.topRight,
              intensity: 1,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: FaIcon(
                FontAwesomeIcons.trashAlt,
                color: Colors.white,
              ),
            ),
          ),
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            context.read<Todo>().deleteItem(item);
          } else if(direction == DismissDirection.startToEnd){
            context.read<Todo>().toggleItem(item);
          }
        },
      ),
    );
  }
}
