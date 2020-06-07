import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../bloc/todo.dart';
import '../models/pages_arguments.dart';
import '../models/todo_models.dart';

import '../style.dart';
import 'detail_card.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);

  final double scaleFraction = 0.9;
  final double scaleDepth = 0.5;
  final double fullScale = 1.0;
  final double viewPortFraction = 0.8;

  double page = 0;

  bool _handlePageNotification(ScrollNotification notification) {
    if (notification.depth == 0 && notification is ScrollUpdateNotification) {
      setState(() {
        page = _pageController.page;
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Selector<Todo, List<TodoCategory>>(
          selector: (_, todo) => todo.categoryes,
          shouldRebuild: (old_categoryes, new_categoryes) =>
              !listEquals(old_categoryes, new_categoryes),
          builder: (context, categoryes, _) {
            return NotificationListener<ScrollNotification>(
                onNotification:
                    _handlePageNotification, //listen scroll and update page
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount:
                      categoryes.length + 1, // +1 need for add CategoryAddCard
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    final scale =
                        max(scaleFraction, (fullScale - (index - page).abs()));
                    final depth =
                        max(scaleDepth, (fullScale - (index - page).abs()));

                    if (index < categoryes.length) {
                      return CategoryCard(categoryes[index], scale, depth);
                    } else {
                      return CategoryAddCard(scale, depth);
                    }
                  },
                ));
          },
        ));
  }
}

class CategoryCard extends StatelessWidget {
  final TodoCategory category;
  final double scale;
  final double scaleDepth;
  const CategoryCard(this.category, this.scale, this.scaleDepth, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      alignment: Alignment.centerLeft,
      child: Neumorphic(
        padding: EdgeInsets.all(18.0),
        margin: EdgeInsets.fromLTRB(
            0, Style.doublePadding, Style.doublePadding, Style.doublePadding),
        style: NeumorphicStyle(
            depth: NeumorphicTheme.depth(context) * 2 * scaleDepth,
            boxShape: NeumorphicBoxShape.roundRect(Style.mainBorderRadius)),
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
              HeroIcon(category: category),
              Spacer(),
              //detail
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[        
                  HeroTitle(category: category),
                  SizedBox(
                    height: Style.mainPadding,
                  ),
                  HeroProgress(category: category)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryAddCard extends StatelessWidget {
  final double scale;
  final double scaleDepth;
  const CategoryAddCard(this.scale, this.scaleDepth, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      alignment: Alignment.centerLeft,
      child: Neumorphic(
        padding: EdgeInsets.all(18.0),
        margin: EdgeInsets.fromLTRB(
            0, Style.doublePadding, Style.doublePadding, Style.doublePadding),
        style: NeumorphicStyle(
          depth: NeumorphicTheme.depth(context) * 2 * scaleDepth,
          boxShape: NeumorphicBoxShape.roundRect(Style.mainBorderRadius),
        ),
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
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
