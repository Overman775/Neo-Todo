import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:todolist/widgets/appbar.dart';
import 'package:todolist/widgets/carousel.dart';

import '../style.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      appBar: CustomAppBar(
        child:           NeumorphicButton(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Thusday', style: Style.mainDateTextStyle),
                Text('5 may', style: Style.mainDateSubTextStyle)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                Style.doublePadding, Style.mainPadding, Style.mainPadding, 0.0),
            child: Text('You have 5 tasks', style: Style.mainTasksTextStyle),
          ),
          Carousel()
        ],
      ),
    );
  }
}
