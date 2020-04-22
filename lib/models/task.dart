import 'package:flutter/material.dart';

class Task {
  String title;
  String description;
  bool completed;

  Task({@required this.title, this.description, this.completed = false});

  void toggle() {
    completed = !completed;
  }
}
