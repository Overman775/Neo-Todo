import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicTextField extends StatefulWidget {
  final String label;
  final String hint;

  final ValueChanged<String> onChanged;

  NeumorphicTextField(
      {@required this.label, @required this.hint, this.onChanged});

  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<NeumorphicTextField> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.hint);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFieldLabel(widget.label),
        Neumorphic(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          boxShape: NeumorphicBoxShape.stadium(),
          style: NeumorphicStyle(depth: NeumorphicTheme.embossDepth(context)),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 14),
          child: TextField(
            onChanged: widget.onChanged,
            controller: _controller,
            decoration: InputDecoration.collapsed(hintText: widget.hint),
          ),
        )
      ],
    );
  }
}

class TextFieldLabel extends StatelessWidget {
  final String label;
  final EdgeInsetsGeometry padding;

  const TextFieldLabel(
    this.label, {
    Key key,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: NeumorphicTheme.defaultTextColor(context),
        ),
      ),
    );
  }
}
