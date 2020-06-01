import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../models/todo_models.dart';
import '../style.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({
    Key key,
    @required this.category,
  }) : super(key: key);

  final TodoCategory category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '${category.totalItems} задач',
          style: Style.mainTasksTextStyle,
        ),
        Text(
          category.title,
          style: Style.cardTitleTextStyle,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: Style.mainPadding,
        ),
        Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: NeumorphicProgress(
                percent: category.percent,
                height: 8,
              ),
            ),
            SizedBox(
              width: Style.mainPadding,
            ),
            Text(
              category.percentString,
              style: Style.mainTasksTextStyle,
            )
          ],
        )
      ],
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
