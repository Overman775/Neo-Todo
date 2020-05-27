import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:todolist/pages/add_category.dart';
import 'package:todolist/pages/add_item.dart';
import 'package:todolist/models/pages_arguments.dart';
import 'package:todolist/pages/main.dart';
import 'package:todolist/pages/todo.dart';
import 'package:todolist/style.dart';

Route geneateRoute(RouteSettings settings) {

  //check named route and return page
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => MainPage());    
    case '/item':    
      return MaterialPageRoute(builder: (context) => AddItem(settings.arguments));
    case '/category':
      //return router with card animation
      return CardRoute(widget: TodoPage(settings.arguments), arguments: settings.arguments);   
    case '/category/add':
      return CardRoute(widget: AddCategory(settings.arguments), arguments: settings.arguments);  
    default:
      return MaterialPageRoute(builder: (context) => MainPage());
  }

  //TODO: add 404 page

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
          ///https://flutter.dev/docs/perf/rendering/best-practices#pitfalls
          ///TODO: optimization opacity
          child: Opacity(
            opacity: animValue,
            child: child,
          ),
        ),
      ),
    ]);
  }
}
