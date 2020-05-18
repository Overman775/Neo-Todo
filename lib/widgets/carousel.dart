import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:todolist/models/pages_arguments.dart';

import '../style.dart';

class Carousel extends StatelessWidget {
  const Carousel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: PageController(initialPage: 0, viewportFraction: 0.8),
          itemBuilder: (context, index) => TaskCard()),
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({Key key}) : super(key: key);

  CardPosition _getPosition(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      boxShape: NeumorphicBoxShape.roundRect(Style.mainBorderRadius),
      padding: EdgeInsets.all(18.0),
      margin: EdgeInsets.fromLTRB(
          0, Style.doublePadding, Style.doublePadding, Style.doublePadding),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pushNamed(context, '/list',
              arguments: MainPageArguments(
                  category: 'category', cardPosition: _getPosition(context)));
        },
      ),
    );
  }
}
