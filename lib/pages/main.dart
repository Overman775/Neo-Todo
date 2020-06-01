import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:todolist/bloc/todo.dart';
import '../widgets/timer.dart';
import '../widgets/appbar.dart';
import '../widgets/carousel.dart';

import '../style.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      appBar: CustomAppBar(
        child: NeumorphicButton(
          boxShape: NeumorphicBoxShape.circle(),
          padding: EdgeInsets.all(Style.halfPadding),
          margin: EdgeInsets.all(Style.halfPadding),
          child: Icon(Icons.more_vert, color: Style.textColor),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: Style.doublePadding),
            child: MainTimer(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                Style.doublePadding, Style.mainPadding, Style.mainPadding, 0.0),
            child: Selector<Todo, int>(
              selector: (_, todo) => todo.total_items,
              builder: (_, total_items, __) {
                return Text('You have $total_items tasks', style: Style.mainTasksTextStyle);
              }
            ),
          ),
          Carousel(),
          SizedBox(
            height: Style.doublePadding
          )          
        ],
      ),
    );
  }
}
