import 'package:flutter/cupertino.dart';
import 'package:todolist/models/task.dart';

class ToDo extends ChangeNotifier {
  final List<Task> _tasks = [];

  void addTodo(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTodo(Task task) {
    _tasks[_tasks.indexOf(task)].toggle();
    notifyListeners();
  }

  void deleteTodo(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
