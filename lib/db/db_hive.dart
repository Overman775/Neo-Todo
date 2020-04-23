import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todolist/models/task.dart';

import 'db.dart';


class TaskDbHive implements Db {
  Box tasks_box;

  @override
  void add(Task task) {
    tasks_box.add(task);
  }

  @override
  void init() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive
      ..init(dir.path)
      ..registerAdapter(TaskAdapter());

    tasks_box = await Hive.openBox('tasks');
  }

  @override
  void delete(int index) {
    tasks_box.deleteAt(index);
  }

  @override
  void edit(int index, Task task) {
    tasks_box.putAt(index, task);
  }

  @override
  List getAll() {
    return tasks_box.toMap().values.toList();
  }
}
