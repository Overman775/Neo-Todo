import 'package:flutter/widgets.dart';

class Glow extends StatelessWidget {
  final Widget child;
  final Color color;
  final double intensity;
  final double radius;
  final double spread;

  const Glow({
    Key key,
    @required this.child,
    @required this.color,
    this.intensity = 1.0,
    this.radius = 10.0,
    this.spread = 5.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: intensity,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color,
                  blurRadius: radius,
                  spreadRadius: spread,
                )
              ],
            ),
            child: child,
          ),
        ),
        child
      ],
    );
  }
}
