import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/settings.dart';
import 'bloc/todo.dart';
import 'router.dart';
import 'style.dart';
import 'widgets/neo_app_style.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  //only portrait
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
/*
  runApp(new SplashScreen());
  var foo = await init();
  runApp(new FullApp(foo: foo));
*/

  runApp(
    EasyLocalization(
        supportedLocales: [const Locale('en'), const Locale('ru')],
        path: 'assets/locales',
        fallbackLocale: const Locale('en'),
        useOnlyLangCode: true,
        preloaderColor: prefs.getBool('darkMode') == true
            ? Style.bgColorDark
            : Style.bgColor,
        child: MultiProvider(providers: [
          ChangeNotifierProvider(create: (_) => Todo(), lazy: false),
          ChangeNotifierProvider(create: (_) => Settings(prefs), lazy: false)
        ], child: const MyApp())),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicAppStyle(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'title'.tr(),
        initialRoute: '/',
        onGenerateRoute: geneateRoute,
        themeMode: context.watch<Settings>().themeMode,
        theme: NeumorphicThemeData(
            defaultTextColor: Style.textColor,
            baseColor: Style.bgColor,
            accentColor: Style.primaryColor,
            variantColor: Style.primaryColor,
            intensity: 0.6,
            lightSource: LightSource.topRight,
            depth: 3,
            appBarTheme: NeumorphicAppBarThemeData(
                buttonPadding: const EdgeInsets.all(14.0),
                buttonStyle: const NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle()),
                iconTheme: IconThemeData(
                  color: Style.textColor,
                ),
                icons: NeumorphicAppBarIcons(
                    backIcon: Icon(FontAwesomeIcons.chevronLeft),
                    menuIcon: Icon(FontAwesomeIcons.bars)))),
        darkTheme: NeumorphicThemeData(
            defaultTextColor: Style.textColorDark,
            baseColor: Style.bgColorDark,
            accentColor: Style.primaryColor,
            variantColor: Style.primaryColor,
            intensity: 0.6,
            lightSource: LightSource.topRight,
            shadowDarkColor: Colors.black,
            shadowLightColor: Colors.grey[500],
            depth: 3,
            appBarTheme: NeumorphicAppBarThemeData(
                buttonPadding: const EdgeInsets.all(14.0),
                buttonStyle: const NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle()),
                iconTheme: IconThemeData(
                  color: Style.textColorDark,
                ),
                icons: NeumorphicAppBarIcons(
                    backIcon: Icon(FontAwesomeIcons.chevronLeft),
                    menuIcon: Icon(FontAwesomeIcons.bars)))));
  }
}
