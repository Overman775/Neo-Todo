import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:todolist/models/todo_models.dart';

class ItemPageArguments{
  final TodoItem item;
  final TodoCategory category;

  ItemPageArguments({this.item, @required this.category});
}

class MainPageArguments{
  final TodoCategory category;
  final CardPosition cardPosition;

  MainPageArguments({@required this.category, @required this.cardPosition});
}

class CardPosition {
  final double left;
  final double top;
  final double right;
  final double bottom;

  CardPosition({this.left = 0, this.top = 0, this.right = 0, this.bottom = 0});
}