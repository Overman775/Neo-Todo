import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:todolist/models/task.dart';

class TodoModel extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(title: 'Задача 1'),
    Task(title: 'Задача 2', description: 'Описание задачи'),
    Task(title: 'Задача 3'),
  ];

  List<Task> get tasks => _tasks;

  void addTodo(Task task) {
    _tasks.add(task);
    log('Task add ${task.title}');
    notifyListeners();
  }

  void toggleTodo(Task task) {
    _tasks[_tasks.indexOf(task)].toggle();
    log('Task toggle ${task.title}');
    notifyListeners();
  }

  void deleteTodo(Task task) {
    _tasks.remove(task);
    log('Task delete ${task.title}');
    notifyListeners();
  }

  void editTodo(Task old_task,Task new_task) {
    _tasks[_tasks.indexOf(old_task)] = new_task;
    log('Task edited ${old_task.title}');
    notifyListeners();
  }
}
