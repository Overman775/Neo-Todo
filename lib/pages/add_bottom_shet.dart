import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todolist/bloc/todo.dart';
import 'package:todolist/models/todo_models.dart';
import 'package:todolist/widgets/text_field.dart';

import '../style.dart';

class AddItemBottomShet extends StatefulWidget {
  final TodoCategory category;
  AddItemBottomShet({Key key, @required this.category}) : super(key: key);

  @override
  _AddItemBottomShetState createState() => _AddItemBottomShetState();
}

class _AddItemBottomShetState extends State<AddItemBottomShet> {
  String title = '';
  String description = '';
  bool enableDescription = false;

  void itemTitleChanget(String title) {
    setState(() {
      this.title = title;
    });
  }

  void itemDescriptionChanget(String description) {
    setState(() {
      this.description = description;
    });
  }

  void chaneEnableDescription() {
    setState(() {
      enableDescription = !enableDescription;
      description = '';
    });
  }

  bool get _saveEnable {
    if (title.isEmpty) {
      return false;
    }
    if (enableDescription && description.isEmpty) {
      return false;
    }

    return true;
  }

  void saveItem() async {
    if (_saveEnable) {
      await context.read<Todo>().addItem(TodoItem(
          category: widget.category.id,
          title: title,
          description: description));

      //go back
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: enableDescription ? 244 : 190,
      child: Neumorphic(
          padding: EdgeInsets.all(Style.mainPadding),
          style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
              oppositeShadowLightSource: true),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              NeumorphicTextField(
                  hint: 'Новая задача',
                  onChanged: itemTitleChanget,
                  autofocus: true
                  ),
              SizedBox(height: Style.mainPadding),
              if (enableDescription)
                NeumorphicTextField(
                    hint: 'Описание',
                    onChanged: itemDescriptionChanget,
                    ),
              SizedBox(height: Style.mainPadding),
              Row(
                children: <Widget>[
                  NeumorphicButton(
                    padding: EdgeInsets.all(16),
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.circle(),
                    ),
                    child: FaIcon(FontAwesomeIcons.bars,
                        size: 18,
                        color: NeumorphicTheme.defaultTextColor(context)),
                    onPressed: chaneEnableDescription,
                  ),
                  Spacer(),
                  NeumorphicButton(
                    padding: EdgeInsets.all(16),
                    style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                            Style.mainBorderRadius)),
                    child: Text('Сохранить',
                        style: TextStyle(
                            color: _saveEnable
                                ? NeumorphicTheme.accentColor(context)
                                : NeumorphicTheme.defaultTextColor(context))),
                    onPressed: saveItem,
                  ),
                ],
              )
            ],
          )),
    );
  }
}
