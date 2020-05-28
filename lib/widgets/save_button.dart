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
    return NeumorphicButton(
      boxShape: NeumorphicBoxShape.roundRect(Style.mainBorderRadius),
      style: NeumorphicStyle(
          border: NeumorphicBorder(
              width: 3, color: canSave ? Style.secondColor : Style.subTextColor),
          surfaceIntensity: canSave ? 0.5 : 0,
          shape: NeumorphicShape.concave,
          color: canSave ? Style.secondColor : Style.subTextColor,
          intensity: 0.7,
          lightSource: LightSource.topRight,
          depth: 6,
          shadowDarkColor: Style.secondColor,
          shadowLightColor: Style.secondColor,
          ),
      isEnabled: canSave,
      child: Text(
        'Сохранить',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      onPressed: onPressed,
    );
  }
}