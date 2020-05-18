import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:todolist/models/task.dart';

class PageArguments {
  final Task task;
  PageArguments({this.task});
}

class CardPosition {
  final double left;
  final double top;
  final double right;
  final double bottom;

  CardPosition({this.left = 0, this.top = 0, this.right = 0, this.bottom = 0});
}

class MainPageArguments {
  final String category;
  final CardPosition cardPosition;

  MainPageArguments({@required this.category, @required this.cardPosition});
}
