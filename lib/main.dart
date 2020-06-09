import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'bloc/todo.dart';
import 'style.dart';

import 'router.dart';
import 'widgets/neumorphic.dart';

void main() {
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ru')],
      path: 'assets/locales',
      fallbackLocale: Locale('en'),
      useOnlyLangCode: true,
      preloaderColor: Style.bgColor,
      child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Todo(), lazy: false)],
      child: NeumorphicWidget(
        child: MaterialApp(
          //showPerformanceOverlay: true,
          //debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'title'.tr(),
          theme: ThemeData(
              primarySwatch: Style.primaryColorMaterial,
              primaryColor: Style.primaryColor,
              appBarTheme: AppBarTheme(
                  elevation: 0.0,
                  color: Style.bgColor,
                  textTheme: TextTheme(headline6: Style.headerTextStyle),
                  iconTheme: IconThemeData(color: Style.primaryColor)),
              scaffoldBackgroundColor: Style.bgColor),

          initialRoute: '/',
          onGenerateRoute: geneateRoute,
        ),
      ),
    );
  }
}
