import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/widgets/task_item.dart';

import '../style.dart';

class TodoPage extends StatefulWidget {
  TodoPage({Key key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo List'),
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
              boxShadow: Style.buttonGlow
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/task');
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          child: Consumer<TodoModel>(builder: (context, todo, child) {
            List<Widget> getTasks() {
              return todo.tasks.map((task) => TaskItem(task)).toList();
            }
            return ListView(
              padding: EdgeInsets.only(bottom: 80),
              children: getTasks(),
            );
          }),
        ));
  }
}
