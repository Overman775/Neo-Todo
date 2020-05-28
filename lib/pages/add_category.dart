import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todolist/bloc/todo.dart';
import 'package:todolist/models/pages_arguments.dart';
import 'package:todolist/models/todo_models.dart';
import 'package:todolist/utils/icons.dart';
import 'package:todolist/widgets/text_field.dart';

import '../style.dart';

class AddCategory extends StatefulWidget {
  final MainPageArguments args;

  AddCategory(this.args, {Key key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState(args);
}

class _AddCategoryState extends State<AddCategory> {
  final MainPageArguments args;

  _AddCategoryState(this.args);

  String title;
  IconData icon = icons_list.entries.first.value;

  bool get _argsHaveCategory => args?.category != null;

  bool get _canSave {
    if (title != null && icon != null) {
      return title.isNotEmpty;
    } else {
      return false;
    }
  }

  void categoryTitleChanget(String title) {
    setState(() {
      this.title = title;
    });
  }

  void iconChanget(IconData icon) {
    setState(() {
      if (icon != null) {
        this.icon = icon;
      }
    });
  }

  void saveCategory() {
    if (_argsHaveCategory) {
      context
          .read<Todo>()
          .editCategory(args.category, TodoCategory(title: title, icon: icon));
    } else {
      context.read<Todo>().addCategory(TodoCategory(title: title, icon: icon));
    }
    //go back
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    title = args?.category?.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _argsHaveCategory
              ? Text(args.category.title)
              : Text('Новая категория'),
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 16),
            child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                runSpacing: Style.doublePadding,
                children: <Widget>[
                  NeumorphicTextField(
                      hint: null,
                      label: 'Название',
                      onChanged: categoryTitleChanget),
                  TextFieldLabel('Иконка'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      runSpacing: 16,
                      spacing: 16,
                      children: icons_list.entries
                          .map((item) => NeumorphicRadio(
                                groupValue: icon,
                                padding: EdgeInsets.all(16),
                                boxShape: NeumorphicBoxShape.circle(),
                                value: item.value,
                                child: FaIcon(item.value,
                                    size: 18,
                                    color: item.value == icon
                                        ? NeumorphicTheme.accentColor(context)
                                        : NeumorphicTheme.defaultTextColor(
                                            context)),
                                onChanged: iconChanget,
                              ))
                          .toList(),
                    ),
                  ),
                  Center(
                    child: NeumorphicButton(
                      isEnabled: _canSave,
                      child: Text('Сохранить'),
                      onPressed: saveCategory,
                    ),
                  )
                ])));
  }
}
