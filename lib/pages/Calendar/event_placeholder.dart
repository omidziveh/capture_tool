import 'package:capture_tool/db/models/event/event.dart';
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
    double height = 12 * (60 / Hive.box('Calendar').get('timeStep'));
    if ((this.widget.index >=
        (24 * 3 * 60 ~/ Hive.box('Calendar').get('timeStep')))) {
      return Container(color: Colors.transparent);

      /// end container
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
            border: Border.all(color: Colors.black12, width: 0.5),
            color: isEvent(
              widget.index,
              widget.pageStartDate.add(Duration(days: 2 - widget.index % 3)),
              events(),
            )
                ? Colors.red
                : Colors.blue,
          ),
        ),
      );
    }
  }
}

events() {
  Box box = Hive.box('events');
  int timeStep = Hive.box('Calendar').get('timeStep');
  List answer = [];
  for (int i = 0; i < box.length; i++) {
    Event event = box.getAt(i);
    answer.add(event);
  }
  return answer;
}

isEvent(index, DateTime date, List all_events) {
  var timeStep = Hive.box('Calendar').get('timeStep');
  for (Event event in all_events) {
    if ((timeStep * (index ~/ 3)) % 60 == event.startDate.minute) {
      // print('MINUTE');
      if ((timeStep * (index ~/ 3)) ~/ 60 == event.startDate.hour) {
        print('HOUR');
        print('${date.day} and ${event.startDate.day}');
        if (date.weekday == event.startDate.weekday) {
          print('DAY');
          if (date.month == event.startDate.month) {
            print('INDEX IS $index');
            return true;
          }
        }
      }
    }
  }
  // for (Event event in events()) {
  // }
  // List<int> startTime = [
  //   int.parse(_startDuration[0]),
  //   int.parse(_startDuration[1]),
  // ];
  // for (Event event in events()) {
  //   if (int.parse(event.startDate.toString().split(':')[0]) == startTime[0] &&
  //       int.parse(event.startDate.toString().split(':')[1]) == startTime[1]) {
  //     return true;
  //   }
  // }
  return false;
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
