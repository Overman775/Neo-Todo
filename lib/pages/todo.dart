import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/todo_models.dart';
import '../widgets/text_field.dart';
import '../widgets/glow.dart';
import '../widgets/detail_card.dart';
import '../bloc/todo.dart';
import '../models/pages_arguments.dart';
import '../widgets/empty.dart';
import '../widgets/task_item.dart';
import '../style.dart';
import '../router.dart';

class TodoPage extends StatefulWidget {
  final MainPageArguments args;

  TodoPage(this.args, {Key key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState(args);
}

class _TodoPageState extends State<TodoPage> {
  final MainPageArguments args;
  AnimationPageInjection animationPageInjection;

  _TodoPageState(this.args);

  ///check page transistion end
  bool get _transistionPageEnd =>
      animationPageInjection.animationPage.value == 1;

  @override
  void initState() {
    context.read<Todo>().getItems(args.category.id);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //update animation injection
    animationPageInjection = AnimationPageInjection.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NeumorphicAppBar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Style.primaryColor,
          elevation: 0,
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                gradient: Style.addButtonGradient,
                shape: BoxShape.circle,
                boxShadow: Style.buttonGlow),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/item',
                arguments: ItemPageArguments(category: widget.args.category));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(Style.doublePadding,
                  Style.halfPadding, Style.doublePadding, 0),
              child: Selector<Todo, TodoCategory>(
                selector: (BuildContext context, Todo todo) => todo.categoryes
                    .firstWhere((element) => element.id == args.category.id),
                shouldRebuild: (old_category, new_category) =>
                    old_category != new_category,
                builder: (context, category, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                        tag: 'icon_${category.id}',
                        child: Glow(
                          color: Style.primaryColor,
                          intensity: 0.25,
                          spread: 5.0,
                          child: FaIcon(
                            args.category.icon,
                            color: Style.primaryColor,
                            size: 32,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Style.mainPadding,
                      ),
                      Hero(
                          tag: 'detail_${category.id}',
                          flightShuttleBuilder: flightShuttleBuilderFix,
                          child: DetailCard(category: category)),
                      SizedBox(height: Style.mainPadding)
                    ],
                  );
                },
              ),
            ),
            ListBody(transistionPageEnd: _transistionPageEnd, widget: widget)
          ],
        ));
  }
}

class ListBody extends StatelessWidget {
  const ListBody({
    Key key,
    @required bool transistionPageEnd,
    @required this.widget,
  })  : _transistionPageEnd = transistionPageEnd,
        super(key: key);

  final bool _transistionPageEnd;
  final TodoPage widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedOpacity(
        //show task list when page transistion end
        opacity: _transistionPageEnd ? 1 : 0,
        duration: Duration(milliseconds: 300),
        child: Builder(builder: (context) {
          //if page transistion not endede show empty widget
          //beter for perfomance
          if (!_transistionPageEnd) {
            return SizedBox.shrink();
          }
          //Stack for cover begin and end ListView
          return Stack(
            children: <Widget>[
              Consumer<Todo>(builder: (context, todo, child) {
                if (todo.items.isNotEmpty) {
                  return ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 80),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            Style.doublePadding,
                            Style.halfPadding,
                            Style.doublePadding,
                            Style.mainPadding),
                        child: Column(
                          children: <Widget>[
                            ...todo.items_unCompleted.map((item) =>
                                TodoItemWidget(item, widget.args.category)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Style.halfPadding,
                      ),
                      ExpandablePanel(
                          header: TextFieldLabel(
                            'Выполнено',
                            padding: EdgeInsets.only(left: Style.doublePadding),
                          ),
                          theme: ExpandableThemeData(
                              headerAlignment:
                                  ExpandablePanelHeaderAlignment.center,
                              iconPadding:
                                  EdgeInsets.only(right: Style.doublePadding),
                              expandIcon: FontAwesomeIcons.angleDown,
                              collapseIcon: FontAwesomeIcons.angleDown,
                              useInkWell: false),
                          expanded: Padding(
                            padding: EdgeInsets.fromLTRB(
                                Style.doublePadding,
                                Style.halfPadding,
                                Style.doublePadding,
                                Style.mainPadding),
                            child: Column(
                              children: <Widget>[
                                ...todo.items_completed.map((item) =>
                                    TodoItemWidget(item, widget.args.category)),
                              ],
                            ),
                          ))
                    ],
                  );
                } else {
                  return EmpltyTodo();
                }
              }),
              //top cover gradient
              Container(
                  height: Style.mainPadding,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      NeumorphicTheme.baseColor(context),
                      NeumorphicTheme.baseColor(context).withOpacity(0)
                    ],
                  ))),
              //bottom cover gradient
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: Style.mainPadding,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        NeumorphicTheme.baseColor(context),
                        NeumorphicTheme.baseColor(context).withOpacity(0)
                      ],
                    ))),
              ),
            ],
          );
        }),
      ),
    );
  }
}
