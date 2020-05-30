import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/bloc/todo.dart';
import 'package:todolist/models/pages_arguments.dart';
import 'package:todolist/widgets/empty.dart';
import 'package:todolist/widgets/task_item.dart';

import 'package:todolist/style.dart';

class TodoPage extends StatefulWidget {
  final MainPageArguments args;

  TodoPage(this.args, {Key key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState(args);
}

class _TodoPageState extends State<TodoPage> {
  final MainPageArguments args;

  _TodoPageState(this.args);

  @override
  void initState() {
    context.read<Todo>().getItems(args.category.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(args.category.title),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Style.primaryColor,
          elevation: 0,
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                gradient: Style.addButtonGradient,
                shape: BoxShape.circle,
                boxShadow: Style.buttonGlow),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/item',
                arguments: ItemPageArguments(category: widget.args.category));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          child: Consumer<Todo>(builder: (context, todo, child) {
            List<Widget> getTasks() {
              return todo.items
                  .map((item) => TodoItemWidget(item, widget.args.category))
                  .toList();
            }

            if (todo.items.isNotEmpty) {
              return ListView(
                padding: EdgeInsets.only(bottom: 80),
                children: getTasks(),
              );
            } else {
              return EmpltyTodo();
            }
          }),
        ));
  }
}
