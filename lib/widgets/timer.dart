import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../style.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(dayWeekFormat.format(now), style: Style.mainDateTextStyle),
        Text(dayMonth.format(now), style: Style.mainDateSubTextStyle)
      ],
    );
  }
}
