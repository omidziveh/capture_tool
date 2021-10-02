import 'package:capture_tool/pages/Calendar/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class EventPlaceHolder extends StatefulWidget {
  int index;
  DateTime pageStartDate;
  DateTime now = DateTime.now();
  EventPlaceHolder({
    required this.pageStartDate,
    required this.index,
  });

  @override
  _EventPlaceHolderState createState() => _EventPlaceHolderState();
}

class _EventPlaceHolderState extends State<EventPlaceHolder> {
  @override
  Widget build(BuildContext context) {
    if ((this.widget.index >=
        (24 * 3 * 60 ~/ Hive.box('Calendar').get('timeStep')))) {
      return Container(color: Colors.transparent);
    } else {
      return GestureDetector(
        onTap: () {
          DateTime _date =
              widget.pageStartDate.add(Duration(days: 2 - widget.index % 3));
          createShortEvent(context, _date, widget.index,
              Hive.box('Calendar').get('timeStep'));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 0.5)),
        ),
      );
    }
  }
}

void createShortEvent(
    BuildContext context, DateTime date, int index, timeStep) {
  int dateYear = date.year;
  int dateMonth = date.month;
  int dateDay = date.day;

  List<String> _startDuration =
      Duration(minutes: timeStep * (index ~/ 3)).toString().split(':');
  List<int> startTime = [
    int.parse(_startDuration[0]),
    int.parse(_startDuration[1])
  ];

  List<String> _finishDuration =
      Duration(minutes: timeStep * (index ~/ 3) + timeStep)
          .toString()
          .split(':');
  List<int> finishTime = [
    int.parse(_finishDuration[0]),
    int.parse(_finishDuration[1])
  ];

  DateTime eventStartTime =
      DateTime(dateYear, dateMonth, dateDay, startTime[0], startTime[1]);
  DateTime eventFinishTime =
      DateTime(dateYear, dateMonth, dateDay, finishTime[0], finishTime[1]);

  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => AddEvent(
              eventStartTime: eventStartTime,
              eventFinishTime: eventFinishTime)));
}
