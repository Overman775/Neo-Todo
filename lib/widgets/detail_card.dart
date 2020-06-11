import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/todo_models.dart';
import '../style.dart';
import 'animated_percent.dart';

class HeroProgress extends StatelessWidget {
  const HeroProgress({
    Key key,
    @required this.category,
  }) : super(key: key);

  final TodoCategory category;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'progress_${category.id}',
      flightShuttleBuilder: flightShuttleBuilderFix,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'task_card',
            style: TextStyle(
                color:
                    NeumorphicTheme.defaultTextColor(context).withOpacity(0.5),
                fontSize: 16.00),
          ).plural(category.totalItems),
          SizedBox(
            height: Style.halfPadding,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: NeumorphicProgress(
                    percent: category.percent,
                    height: 8,
                    duration: Duration(milliseconds: 300),
                    style: ProgressStyle(
                        depth: NeumorphicTheme.depth(
                            context) // TODO: fix depth and others
                        )),
              ),
              SizedBox(
                width: Style.mainPadding,
              ),
              Container(
                width: 48,
                alignment: Alignment.centerRight,
                child: AnimatedPercent(
                  category.percent,
                  style: TextStyle(
                      color: NeumorphicTheme.defaultTextColor(context)
                          .withOpacity(0.5),
                      fontSize: 16.00),
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class HeroTitle extends StatelessWidget {
  const HeroTitle({
    Key key,
    @required this.category,
  }) : super(key: key);

  final TodoCategory category;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'title_${category.id}',
      flightShuttleBuilder: flightShuttleBuilderFix,
      child: Text(
        category.title,
        style: TextStyle(
            color: NeumorphicTheme.defaultTextColor(context), fontSize: 40.00),
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class HeroIcon extends StatelessWidget {
  const HeroIcon({
    Key key,
    @required this.category,
  }) : super(key: key);

  final TodoCategory category;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'icon_${category.id}',
      child: Neumorphic(
        padding: EdgeInsets.all(16),
        style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
        child: FaIcon(
          category.icon,
          color: Style.primaryColor,
          size: 32,
        ),
      ),
    );
  }
}

Widget flightShuttleBuilderFix(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  ///fix overflow flex
  return SingleChildScrollView(
    //fix missed style
    child: DefaultTextStyle(
        style: DefaultTextStyle.of(fromHeroContext).style,
        child: fromHeroContext.widget),
  );
}
