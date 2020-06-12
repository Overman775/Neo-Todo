import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../bloc/todo.dart';
import '../models/pages_arguments.dart';
import '../style.dart';
import '../widgets/text_field.dart';

class AddItem extends StatefulWidget {
  final ItemPageArguments args;
  AddItem(this.args, {Key key}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  String title;
  String description;

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

  Future saveItem() async {
    if (_saveEnable) {
      await context.read<Todo>().editItem(widget.args.item,
          widget.args.item.copyWith(title: title, description: description));

      //go back
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    title = widget.args.item.title;
    description = widget.args.item.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      appBar: NeumorphicAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Style.mainPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              NeumorphicTextField(
                label: 'add_task.title'.tr(),
                text: widget.args.item.title,
                onChanged: itemTitleChanget,
              ),
              SizedBox(height: Style.mainPadding),
              NeumorphicTextField(
                  label: 'add_task.description'.tr(),
                  text: widget.args.item.description,
                  onChanged: itemDescriptionChanget),
              SizedBox(height: Style.mainPadding),
              Center(
                  child: NeumorphicButton(
                padding: const EdgeInsets.all(16),
                style: NeumorphicStyle(
                    boxShape:
                        NeumorphicBoxShape.roundRect(Style.mainBorderRadius)),
                child: Text('save',
                        style: TextStyle(
                            color: _saveEnable
                                ? NeumorphicTheme.accentColor(context)
                                : NeumorphicTheme.defaultTextColor(context)))
                    .tr(),
                onPressed: saveItem,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
