import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'models/pages_arguments.dart';
import 'pages/add_task.dart';
import 'pages/main.dart';
import 'pages/todo.dart';
import 'style.dart';

Route geneateRoute(RouteSettings settings) {
  var routes = <String, Widget>{
    '/': MainPage(),
    '/list': TodoPage(),
    '/task': AddTask(settings.arguments),
  };

  if (settings.name == '/list') {
    return CardRoute(widget: TodoPage(), arguments: settings.arguments);
  }

  return MaterialPageRoute(builder: (context) => routes[settings.name]);
}

class CardRoute extends PageRouteBuilder {
  final Widget widget;
  final MainPageArguments arguments;

  CardRoute({@required this.widget, @required this.arguments})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            var curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            );

            return CardTransition(
                child: child,
                animation: curvedAnimation,
                cardPosition: arguments.cardPosition);
          },
          transitionDuration: Duration(milliseconds: 300),
        );
}

class CardTransition extends AnimatedWidget {
  const CardTransition(
      {Key key,
      @required Animation<double> animation,
      this.child,
      @required this.cardPosition})
      : assert(animation != null),
        super(key: key, listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;
  final Widget child;
  final CardPosition cardPosition;

  @override
  Widget build(BuildContext context) {
    var animValue = animation.value;
    var paddingAnim = Style.doublePadding - Style.doublePadding * animValue;
    var borderAnim = BorderRadius.circular(
        Style.mainBorderRadiusValue - Style.mainBorderRadiusValue * animValue);

    var animLeft = cardPosition.left - cardPosition.left * animValue;
    var animRight = cardPosition.right - cardPosition.right * animValue;
    var animTop = cardPosition.top - cardPosition.top * animValue;
    var animBottom = cardPosition.bottom - cardPosition.bottom * animValue;

    return Stack(children: <Widget>[
      Positioned(
        left: animLeft,
        right: animRight,
        top: animTop,
        bottom: animBottom,
        child: Neumorphic(
          duration: Duration(),
          boxShape: NeumorphicBoxShape.roundRect(borderAnim),
          margin: EdgeInsets.fromLTRB(0, paddingAnim, paddingAnim, paddingAnim),
          child: Opacity(
            opacity: animValue,
            child: child,
          ),
        ),
      ),
    ]);
  }
}
