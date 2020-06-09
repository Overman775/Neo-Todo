import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'pages/add_category.dart';
import 'pages/add_item.dart';
import 'models/pages_arguments.dart';
import 'pages/main.dart';
import 'pages/todo.dart';
import 'style.dart';

Route geneateRoute(RouteSettings settings) {
  //check named route and return page
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => MainPage());
    case '/item/edit':
      return MaterialPageRoute(
          builder: (context) => AddItem(settings.arguments));
    case '/category':
      //return router with card animation
      return CardRoute(
          widget: TodoPage(settings.arguments), arguments: settings.arguments);
    case '/category/add':
      return CardRoute(
          widget: AddCategory(settings.arguments),
          arguments: settings.arguments);
    case '/category/edit':
      return MaterialPageRoute(
          builder: (context) => AddCategory(settings.arguments));
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
            //return AnimationPageInjection(child: widget, animationPage: animation);
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
          transitionDuration: Style.pageDuration,
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
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(borderAnim),
          ),

          margin: EdgeInsets.fromLTRB(0, paddingAnim, paddingAnim, paddingAnim),

          ///https://flutter.dev/docs/perf/rendering/best-practices#pitfalls
          ///TODO: optimization opacity
          child: AnimatedOpacity(
            opacity: animValue,
            duration: Duration(),
            child:
                AnimationPageInjection(child: child, animationPage: animation),
          ),
        ),
      ),
    ]);
  }
}

//animation page injector
class AnimationPageInjection extends InheritedWidget {
  final Animation<double> animationPage;

  const AnimationPageInjection({
    Key key,
    @required this.animationPage,
    @required Widget child,
  })  : assert(child != null),
        assert(animationPage != null),
        super(key: key, child: child);

  static AnimationPageInjection of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AnimationPageInjection>();
  }

  @override
  bool updateShouldNotify(AnimationPageInjection oldWidget) =>
      animationPage != oldWidget.animationPage;
}
