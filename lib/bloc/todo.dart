import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:todolist/db/db_hive.dart';
import 'package:todolist/models/task.dart';

class Todo extends ChangeNotifier {
  final TaskDbHive db = TaskDbHive();

  Todo(){
    _init();
  }

  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void _init() async{
    await db.init();

    for (var task in db.getAll()) {
      print(task.title);
      _tasks.add(Task(title: task.title, description: task.description, completed: task.completed));
    }
    notifyListeners();
  }

  void addTodo(Task task) {
    _tasks.add(task);
    db.add(task);
    log('Task add ${task.title}');
    notifyListeners();
  }

  void toggleTodo(Task task) {
    var index = _tasks.indexOf(task); 
    _tasks[index].toggle();
    db.edit(index, _tasks[index]);
    log('Task toggle ${task.title}');
    notifyListeners();
  }

  void deleteTodo(Task task) {
    var index = _tasks.indexOf(task);    
    _tasks.remove(task);
    db.delete(index);
    log('Task delete ${task.title}');
    notifyListeners();
  }

  void editTodo(Task old_task,Task new_task) {
    var index = _tasks.indexOf(old_task);
    _tasks[_tasks.indexOf(old_task)] = new_task;
    db.edit(index, new_task);
    log('Task edited ${old_task.title}');
    notifyListeners();
  }
}
