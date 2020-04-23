import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/pages/add_task.dart';
import 'package:todolist/pages/todo.dart';
import 'package:todolist/models/todo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TodoModel())],
      child: MaterialApp(
        title: 'Todo List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => TodoPage(),
          '/task': (context) => AddTask(),
        },
      ),
    );
  }
}
