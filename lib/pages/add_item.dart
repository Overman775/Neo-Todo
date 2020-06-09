import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:todolist/widgets/text_field.dart';
import '../bloc/todo.dart';
import '../models/pages_arguments.dart';
import '../models/todo_models.dart';
import '../style.dart';

class AddItem extends StatefulWidget {
  final ItemPageArguments args;
  AddItem(this.args, {Key key}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  String title = '';
  String description = '';

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

  bool get _saveEnable {
    if (title.isEmpty) {
      return false;
    }
    return true;
  }

  void saveItem() async {
    if (_saveEnable) {
      await context.read<Todo>().addItem(TodoItem(
          category: widget.args.category.id,
          title: title,
          description: description));

      //go back
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Style.mainPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              NeumorphicTextField(
                label: 'Название',
                text: widget.args.item.title,
                onChanged: itemTitleChanget,
              ),
              SizedBox(height: Style.mainPadding),
              NeumorphicTextField(
                  label: 'Описание',
                  text: widget.args.item.description,
                  onChanged: itemDescriptionChanget),
              SizedBox(height: Style.mainPadding),
              Center(
                  child: NeumorphicButton(
                padding: EdgeInsets.all(16),
                style: NeumorphicStyle(
                    boxShape:
                        NeumorphicBoxShape.roundRect(Style.mainBorderRadius)),
                child: Text('Сохранить',
                    style: TextStyle(
                        color: _saveEnable
                            ? NeumorphicTheme.accentColor(context)
                            : NeumorphicTheme.defaultTextColor(context))),
                onPressed: saveItem,
              ))
            ],
          ),
        ),
      ),
    );
  }
}