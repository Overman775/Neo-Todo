import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todolist/bloc/todo.dart';
import 'package:todolist/models/pages_arguments.dart';
import 'package:todolist/models/todo_models.dart';

import 'package:todolist/style.dart';

class Carousel extends StatelessWidget {
  const Carousel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Selector<Todo, List<TodoCategory>>(
          selector: (_, todo) => todo.categoryes,
          builder: (context, categoryes, _) {
            return PageView(
                scrollDirection: Axis.horizontal,
                controller:
                    PageController(initialPage: 0, viewportFraction: 0.8),
                children: <Widget>[
                  ...categoryes.map((category) => CategoryCard(category)),
                  CategoryAddCard()
                ]);
          },
        ));
  }
}

class CategoryCard extends StatelessWidget {
  final TodoCategory category;
  const CategoryCard(this.category, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      boxShape: NeumorphicBoxShape.roundRect(Style.mainBorderRadius),
      padding: EdgeInsets.all(18.0),
      margin: EdgeInsets.fromLTRB(
          0, Style.doublePadding, Style.doublePadding, Style.doublePadding),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pushNamed(context, '/category',
              arguments: MainPageArguments(
                  category: category,
                  cardPosition: CardPosition.getPosition(context)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FaIcon(
                  category.icon,
                  color: Style.textColor,
                  size: 32,
                ),
                SizedBox(width: Style.mainPadding),
                Expanded(
                    child: Text(
                      category.title,
                      style: Style.cardTitleTextStyle,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      ),
                  
                )
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Style.halfPadding),
              child: Text(
                'Выполнено ${category.completed} из ${category.totalItems}',
                style: Style.mainTasksTextStyle,
              ),
            ),
            NeumorphicProgress(
              percent: category.percent,
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}

class CategoryAddCard extends StatelessWidget {
  const CategoryAddCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      boxShape: NeumorphicBoxShape.roundRect(Style.mainBorderRadius),
      padding: EdgeInsets.all(18.0),
      margin: EdgeInsets.fromLTRB(
          0, Style.doublePadding, Style.doublePadding, Style.doublePadding),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pushNamed(context, '/category/add',
              arguments: MainPageArguments(
                  cardPosition: CardPosition.getPosition(context)));
        },
        child: Center(
          child: FaIcon(
            FontAwesomeIcons.plus,
            color: Style.textColor,
            size: 100,
          ),
        ),
      ),
    );
  }
}
