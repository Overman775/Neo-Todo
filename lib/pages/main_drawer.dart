import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/settings.dart';
import '../style.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: NeumorphicBackground(
        child: Column(children: <Widget>[
          const HeadDrawer(),
          ItemDrawer(
            icon: FontAwesomeIcons.language,
            text: 'settings.locale'.tr(),
            child: DropdownButton<dynamic>(
              value: context.locale,
              dropdownColor: NeumorphicTheme.baseColor(context),
              style:
                  TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
              items: <DropdownMenuItem<dynamic>>[
                const DropdownMenuItem<dynamic>(
                  value: Locale('en'),
                  child: Text('Engish'),
                ),
                const DropdownMenuItem<dynamic>(
                  value: Locale('fr'),
                  child: Text('French'),
                ),
                const DropdownMenuItem<dynamic>(
                  value: Locale('ru'),
                  child: Text('Русский'),
                )
              ],
              onChanged: (dynamic locale) {
                context.locale = locale as Locale;
              },
            ),
          ),
          ItemDrawer(
            icon: FontAwesomeIcons.moon,
            text: 'settings.dark_mode'.tr(),
            child: NeumorphicSwitch(
              value: context.watch<Settings>().isDarkMode,
              onChanged: (dark) {
                if (dark) {
                  context.read<Settings>().themeMode = ThemeMode.dark;
                } else {
                  context.read<Settings>().themeMode = ThemeMode.light;
                }
              },
            ),
          ),
          const Spacer(),
          //wait version info
          const About(),
        ]),
      ),
    );
  }
}

class About extends StatelessWidget {
  const About({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (snapshot.hasData && !snapshot.hasError) {
          return ItemDrawer(
            text:
                'settings.version'.tr(args: [snapshot.data.version.toString()]),
            child: Text(
              'settings.about'.tr(),
              style:
                  TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
            ),
            onTap: () => showAboutDialog(
              context: context,
              applicationVersion: snapshot.data.version.toString(),
              applicationIcon: Image.asset(
                'assets/icon/icon.png',
                height: 50,
              ),
              children: [
                Text('settings.about_text'.tr()),
                Padding(
                  padding: const EdgeInsets.only(top: Style.mainPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.github,
                                color: NeumorphicTheme.accentColor(context),
                              ),
                              onPressed: () =>
                                  launch('https://github.com/Overman775')),
                          const Text('Github')
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.twitter,
                                color: NeumorphicTheme.accentColor(context),
                              ),
                              onPressed: () =>
                                  launch('https://twitter.com/AlexeyZd')),
                          const Text('Twitter')
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.linkedin,
                                color: NeumorphicTheme.accentColor(context),
                              ),
                              onPressed: () => launch(
                                  'https://www.linkedin.com/in/overman775/')),
                          const Text('Linkedin')
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class HeadDrawer extends StatefulWidget {
  const HeadDrawer({Key key}) : super(key: key);

  @override
  _HeadDrawerState createState() => _HeadDrawerState();
}

class _HeadDrawerState extends State<HeadDrawer> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Center(
        child: NeumorphicText('title'.tr(),
            textStyle:
                NeumorphicTextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class ItemDrawer extends StatelessWidget {
  final IconData icon;
  final GestureTapCallback onTap;
  final String text;
  final Widget child;

  const ItemDrawer(
      {this.icon, @required this.text, this.onTap, this.child, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? FaIcon(icon, color: NeumorphicTheme.defaultTextColor(context))
          : null,
      title: Text(
        text,
        style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
      ),
      trailing: child,
      onTap: onTap,
    );
  }
}
