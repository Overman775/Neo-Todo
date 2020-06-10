import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

import '../utils/string_extensions.dart';

class MainTimer extends StatefulWidget {
  MainTimer({Key key}) : super(key: key);

  @override
  _MainTimerState createState() => _MainTimerState();
}

class _MainTimerState extends State<MainTimer> {
  DateTime now;
  Timer timer;

  //only week name
  DateFormat dayWeekFormat = DateFormat.EEEE();
  //day and month
  DateFormat dayMonth = DateFormat('d MMMM');

  void updateNow(Timer timer) {
    final current_now = DateTime.now();
    if (now.day != current_now.day) {
      setState(() {
        now = current_now;
      });
    }
  }

  @override
  void initState() {
    now = DateTime.now();
    timer = Timer.periodic(Duration(seconds: 1), updateNow);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //only week name
    final dayWeekFormat = DateFormat.EEEE(context.locale.toString());
    //day and month
    final dayMonth = DateFormat('d MMMM', context.locale.toString());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(dayWeekFormat.format(now).capitalize(),
            style: TextStyle(
                color: NeumorphicTheme.defaultTextColor(context),
                fontSize: 32.00)),
        Text(dayMonth.format(now),
            style: TextStyle(
                color:
                    NeumorphicTheme.defaultTextColor(context).withOpacity(0.5),
                fontSize: 32.00))
      ],
    );
  }
}
