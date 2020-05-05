import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  const CustomAppBar({this.child, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    final bool canPop = Navigator.canPop(context);

    return Padding(
      padding: EdgeInsets.only(top: statusbarHeight),
      child: Container(
        height: 60,
        child: Row(
          children: <Widget>[
            if (canPop)
              NeumorphicButton(
                boxShape: NeumorphicBoxShape.circle(),
                padding: EdgeInsets.all(Style.halfPadding),
                margin: EdgeInsets.all(Style.halfPadding),
                child: Icon(Icons.arrow_back, color: Style.textColor),
              ),
            Spacer(),
            if (child != null) child
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
