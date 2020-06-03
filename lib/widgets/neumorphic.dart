import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../style.dart';

class NeumorphicWidget extends StatelessWidget {
  final Widget child;
  const NeumorphicWidget({this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
        themeMode: ThemeMode.light,
        theme: NeumorphicThemeData(
          defaultTextColor: Style.textColor,
          baseColor: Style.bgColor,
          accentColor: Style.primaryColor,
          variantColor: Style.primaryColor,
          intensity: 0.6,
          lightSource: LightSource.topRight,
          depth: 3,
        ),
        darkTheme: NeumorphicThemeData(
          //TODO Add black theme
          baseColor: Color(0xFF3E3E3E),
          intensity: 0.6,
          lightSource: LightSource.topRight,
          depth: 3,
        ),
        child: child);
  }
}
