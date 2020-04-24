import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../style.dart';

class EmpltyTodo extends StatelessWidget {
  const EmpltyTodo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 30,
          children: <Widget>[
            Text(
              'Список пуст',
              style: Style.headerTextStyle,
              ),
              SvgPicture.asset(
                'assets/images/list.svg',
                height: 100,
                )
          ],
        )
      ),
    );
  }
}