import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:todolist/bloc/todo.dart';
import '../widgets/timer.dart';
import '../widgets/carousel.dart';

import '../style.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      appBar: NeumorphicAppBar(),
      body: Container(
        child: Column(
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
                  shouldRebuild: (old_total, new_total) => old_total != new_total,
                  builder: (_, total_items, __) {
                    return Text('You have $total_items tasks',
                        style: Style.mainTasksTextStyle);
                  }),
            ),
            Carousel(),
            SizedBox(height: Style.doublePadding)
          ],
        ),
      ),
    );
  }
}
