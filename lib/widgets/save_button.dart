import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../style.dart';

class NeumorphicSaveButton extends StatelessWidget {
  const NeumorphicSaveButton({Key key, this.canSave, this.onPressed})
      : super(key: key);

  final bool canSave;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      drawSurfaceAboveChild: false,
      style: NeumorphicStyle(
          color: canSave ? Style.primaryColor : Style.subTextColor,
          depth: 6,
          boxShape: NeumorphicBoxShape.roundRect(Style.mainBorderRadius),
          intensity: 0.7,
          shape: canSave ? NeumorphicShape.concave : NeumorphicShape.flat,
          shadowDarkColor: Style.primaryColor,
          shadowLightColor: Style.primaryColor,
          disableDepth: !canSave),
      child: NeumorphicButton(
          onPressed: onPressed,
          margin: EdgeInsets.all(3),
          padding: EdgeInsets.all(14.0),
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(Style.mainBorderRadius),
            color: canSave ? Style.primaryColor : Style.subTextColor,
            depth: 0,
            shape: canSave ? NeumorphicShape.convex : NeumorphicShape.flat,
          ),
          child: Text(
            'Сохранить',
            style: TextStyle(color: Colors.white, fontSize: 16),
          )),
    );
  }
}
