import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AnimatedPercent extends ImplicitlyAnimatedWidget {
  final double percent;
  final TextStyle style;

  AnimatedPercent(
    this.percent, {
    Key key,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.linear,
    this.style,
  }) : super(duration: duration, curve: curve, key: key);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedPercentState();
}

class _AnimatedPercentState extends AnimatedWidgetBaseState<AnimatedPercent> {
  Tween<double> _percent;

  @override
  Widget build(BuildContext context) {
    var percentString =
        NumberFormat.percentPattern().format(_percent.evaluate(animation));
    return Text(
      percentString,
      style: widget.style,
      maxLines: 1,
      softWrap: false,
    );
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    _percent = visitor(_percent, widget.percent,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>;
  }
}
