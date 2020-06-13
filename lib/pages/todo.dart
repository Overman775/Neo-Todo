import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../bloc/todo.dart';
import '../models/pages_arguments.dart';
import '../models/todo_models.dart';
import '../router.dart';
import '../style.dart';
import '../widgets/cover_line.dart';
import '../widgets/detail_card.dart';
import '../widgets/empty.dart';
import '../widgets/neo_pop_up.dart';
import '../widgets/task_item.dart';
import '../widgets/text_field.dart';
import 'add_bottom_shet.dart';

class TodoPage extends StatefulWidget {
  final MainPageArguments args;

  TodoPage(this.args, {Key key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  AnimationPageInjection animationPageInjection;

  _TodoPageState();

  ///check page transistion end
  bool get _transistionPageEnd =>
      animationPageInjection.animationPage.value == 1;

  @override
  void initState() {
    context.read<Todo>().getItems(widget.args.category.id);

    /*
    context.read<Todo>().addListener(() {
      setState(() {
       var _category =  context.read<Todo>().categoryes
                    .firstWhere((element) => element.id == args.category.id,
                        orElse: () => null);
          print(_category);
      });
    });
*/
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
        appBar: CategoryAppBar(args: widget.args),
        floatingActionButton: CategoryFAB(args: widget.args),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: NeumorphicTheme.baseColor(context),
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(Style.mainPadding, Style.halfPadding,
                  Style.mainPadding, Style.mainPadding),
              child: Selector<Todo, TodoCategory>(
                selector: (BuildContext context, Todo todo) => todo.categoryes
                    .firstWhere(
                        (element) => element.id == widget.args.category.id,
                        orElse: () => null),
                shouldRebuild: (old_category, new_category) =>
                    old_category != new_category,
                builder: (context, category, _) {
                  if (category == null) {
                    //return empty container when category deletet
                    return const SizedBox.shrink();
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      HeroIcon(category: category),
                      const SizedBox(width: Style.mainPadding),
                      Expanded(child: HeroProgress(category: category)),
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

class CategoryFAB extends StatelessWidget {
  const CategoryFAB({
    Key key,
    @required this.args,
  }) : super(key: key);

  final MainPageArguments args;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
        modalBottomSheet(context, args.category);
      },
    );
  }
}

class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CategoryAppBar({
    Key key,
    @required this.args,
  }) : super(key: key);

  final MainPageArguments args;

  Future onSelected(String selected, BuildContext context) async {
    final block = context.read<Todo>();
    switch (selected) {
      case 'edit':
        //fix double editing
        final category = block.categoryes
            .firstWhere((element) => element.id == args.category.id);
        await Navigator.pushNamed(context, '/category/edit',
            arguments:
                MainPageArguments(category: category, cardPosition: null));
        break;
      case 'delete':
        await block.deleteCategory(args.category);
        Navigator.of(context).pop();
        await block.getCategoryes();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicAppBar(
      title: Selector<Todo, TodoCategory>(
          selector: (BuildContext context, Todo todo) => todo.categoryes
              .firstWhere((element) => element.id == args.category.id,
                  orElse: () => null),
          shouldRebuild: (old_category, new_category) =>
              old_category != new_category,
          builder: (context, category, _) {
            if (category == null) {
              //return empty container when category deletet
              return const SizedBox.shrink();
            }
            return HeroTitle(category: category);
          }),
      actions: <Widget>[
        NeumorphicPopupMenuButton(
          icon: Icon(FontAwesomeIcons.ellipsisV),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onSelected: (String selected) => onSelected(selected, context),
          itemBuilder: (_) => <PopupMenuItem<String>>[
            PopupMenuItem<String>(
                child: Row(
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.edit),
                    SizedBox(width: Style.halfPadding),
                    const Text('Edit'),
                  ],
                ),
                value: 'edit'),
            PopupMenuItem<String>(
                child: Row(
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.trashAlt),
                    SizedBox(width: Style.halfPadding),
                    const Text('Delete'),
                  ],
                ),
                value: 'delete'),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 16 * 2);
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
        duration: const Duration(milliseconds: 300),
        child: Builder(builder: (context) {
          //if page transistion not endede show empty widget
          //beter for perfomance
          if (!_transistionPageEnd) {
            return const SizedBox.shrink();
          }
          //Stack for cover begin and end ListView
          return Stack(
            children: <Widget>[
              Consumer<Todo>(builder: (context, todo, child) {
                if (todo.items.isNotEmpty) {
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 80),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            Style.mainPadding,
                            Style.halfPadding,
                            Style.mainPadding,
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
                            'completed'.tr(),
                            padding: EdgeInsets.only(left: Style.doublePadding),
                          ),
                          theme: ExpandableThemeData(
                              headerAlignment:
                                  ExpandablePanelHeaderAlignment.center,
                              iconPadding:
                                  EdgeInsets.only(right: Style.doublePadding),
                              iconColor:
                                  NeumorphicTheme.defaultTextColor(context),
                              expandIcon: FontAwesomeIcons.angleDown,
                              collapseIcon: FontAwesomeIcons.angleDown,
                              useInkWell: false),
                          expanded: Padding(
                            padding: EdgeInsets.fromLTRB(
                                Style.mainPadding,
                                Style.halfPadding,
                                Style.mainPadding,
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
                  return const EmptyTodo();
                }
              }),
              //top cover gradient
              const CoverLine(),
              CoverLine(
                alignment: Alignment.bottomCenter,
              ),
              /*Container(
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
              ),*/
            ],
          );
        }),
      ),
    );
  }
}
