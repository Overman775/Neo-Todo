import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:todolist/pages/add_task.dart';
import 'package:todolist/pages/main.dart';
import 'package:todolist/pages/todo.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TodoModel())],
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
        onGenerateRoute: (RouteSettings settings) {
          var routes = <String, Widget>{
            '/': MainPage(),
            '/list': TodoPage(),
            '/task': AddTask(settings.arguments),
          };
          WidgetBuilder builder = (context) => NeumorphicWidget(routes[settings.name]);
          return MaterialPageRoute(builder: (context) => builder(context));
        },
      ),
    );
  }
}

class NeumorphicWidget extends StatelessWidget {
  final child;

  const NeumorphicWidget(this.child, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
        usedTheme: UsedTheme.LIGHT,
        theme: NeumorphicThemeData(
          baseColor: Style.bgColor,
          intensity: 1,
          lightSource: LightSource.topRight,
          depth: 10,
        ),
        darkTheme: NeumorphicThemeData(
          //TODO Add black theme
          baseColor: Color(0xFF3E3E3E),
          intensity: 0.5,
          lightSource: LightSource.topRight,
          depth: 6,
        ),
        child: child);
  }
}
