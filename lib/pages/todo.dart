import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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
        appBar: AppBar(),
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
        body: Padding(
          padding: EdgeInsets.fromLTRB(Style.doublePadding, Style.halfPadding,
              Style.doublePadding, Style.mainPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: 'icon_${args.category.id}',
                child: FaIcon(
                  args.category.icon,
                  color: Style.primaryColor,
                  size: 32,
                ),
              ),
              SizedBox(
                height: Style.mainPadding,
              ),
              Hero(
                  tag: 'detail_${args.category.id}',
                  flightShuttleBuilder: flightShuttleBuilderFix,
                  child: DetailCard(category: args.category)),
              SizedBox(
                height: Style.mainPadding,
              ),
              Expanded(
                child: AnimatedOpacity(
                  opacity: _transistionPageEnd ? 1 : 0,
                  duration: Duration(milliseconds: 300),
                  child: Builder(builder: (context) {
                    if (!_transistionPageEnd) {
                      return SizedBox.shrink();
                    }
                    return Container(
                      child: Consumer<Todo>(builder: (context, todo, child) {
                        List<Widget> getTasks() {
                          return todo.items
                              .map((item) =>
                                  TodoItemWidget(item, widget.args.category))
                              .toList();
                        }

                        if (todo.items.isNotEmpty) {
                          return ListView(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 80),
                            children: getTasks(),
                          );
                        } else {
                          return EmpltyTodo();
                        }
                      }),
                    );
                  }),
                ),
              ),
            ],
          ),
        ));
  }
}
