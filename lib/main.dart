import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/pages/add_task.dart';
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
        title: 'Todo List',
        theme: ThemeData(
          primarySwatch: Style.primaryColorMaterial,
          primaryColor: Style.primaryColor,
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            color: Style.bgColor,
            textTheme: TextTheme(
              title: Style.headerTextStyle
            ),
            iconTheme: IconThemeData(
              color: Style.primaryColor
            )
          ),
          scaffoldBackgroundColor: Style.bgColor
        ),
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          var routes = <String, WidgetBuilder>{
            "/": (context) => TodoPage(),
            "/task": (context) => AddTask(settings.arguments),
          };
          WidgetBuilder builder = routes[settings.name];
          return MaterialPageRoute(builder: (context) => builder(context));
        },
      ),
    );
  }
}
