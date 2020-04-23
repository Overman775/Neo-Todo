import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  bool completed;

  Task({@required this.title, this.description, this.completed = false});

  void toggle() {
    completed = !completed;
  }
}
