import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            appBarTheme: NeumorphicAppBarThemeData(
                buttonPadding: EdgeInsets.all(14.0), //TODO: fix padding
                buttonStyle:
                    NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
                iconTheme: IconThemeData(
                  color: Style.textColor,
                ),
                icons: NeumorphicAppBarIcons(
                    backIcon: Icon(FontAwesomeIcons.chevronLeft)))),
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
