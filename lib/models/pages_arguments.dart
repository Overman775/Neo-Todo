import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../models/todo_models.dart';

class ItemPageArguments {
  final TodoItem item;
  final TodoCategory category;

  ItemPageArguments({this.item, @required this.category});
}

class MainPageArguments {
  final TodoCategory category;
  final CardPosition cardPosition;

  MainPageArguments({this.category, @required this.cardPosition});
}

class CardPosition {
  final double left;
  final double top;
  final double right;
  final double bottom;

  factory CardPosition.getPosition(BuildContext context) {
    //search widget
    final RenderBox renderBox = context.findRenderObject();
    //get position widget
    final position = renderBox.localToGlobal(Offset.zero);
    //get size widget
    final size = renderBox.size;
    //get screen size
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return CardPosition(
        left: position.dx,
        top: position.dy,
        right: screenWidth - size.width - position.dx,
        bottom: screenHeight - size.height - position.dy);
  }

  CardPosition({this.left = 0, this.top = 0, this.right = 0, this.bottom = 0});
}
