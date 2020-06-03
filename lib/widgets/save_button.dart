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
      
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(Style.mainBorderRadius),
          border: NeumorphicBorder(
              width: 3, color: canSave ? Style.primaryColor : Style.subTextColor),
          surfaceIntensity: canSave ? 0.5 : 0,
          shape: NeumorphicShape.concave,
          color: canSave ? Style.primaryColor : Style.subTextColor,
          intensity: 0.7,
          lightSource: LightSource.topRight,
          depth: 6,
          shadowDarkColor: Style.primaryColor,
          shadowLightColor: Style.primaryColor,
          ),
      //TODO: migrate isEnabled
      //isEnabled: canSave,
      child: Text(
        'Сохранить',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      onPressed: onPressed,
    );
  }
}