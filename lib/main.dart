import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'bloc/todo.dart';
import 'style.dart';

import 'router.dart';
import 'widgets/neumorphic.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Todo())],
      child: NeumorphicWidget(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todo List',
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
