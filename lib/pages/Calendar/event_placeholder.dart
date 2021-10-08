import 'package:capture_tool/db/models/event/event.dart';
import 'package:capture_tool/pages/Calendar/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class EventPlaceHolder extends StatefulWidget {
  int index;
  DateTime pageStartDate;
  Map<String, List<Event>> events;
  DateTime now = DateTime.now();
  EventPlaceHolder({
    required this.pageStartDate,
    required this.index,
    required this.events,
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
          child: isEvent(
            widget.index,
            widget.pageStartDate.add(Duration(days: 2 - widget.index % 3)),
            widget.events,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 0.5),
            color: Colors.white,
          ),
        ),
      );
    }
  }
}

eventTile(Event event) {
  return Container(
    child: Text(event.title),
  );
}

allEvents() {
  Box box = Hive.box('events');
  int timeStep = Hive.box('Calendar').get('timeStep');
  Map<String, List<Event>> events = {
    'startEndEvents': [],
    'startEvents': [],
    'midEvents': [],
    'endEvents': [],
  };
  for (int i = 0; i < box.length; i++) {
    Event event = box.getAt(i);
    int diff = event.finishDate
        .difference(event.startDate)
        .compareTo(Duration(minutes: timeStep));
    if (diff <= 0) {
      events['startEndEvents']!.add(Event(
        title: event.title,
        description: event.description,
        goals: event.goals,
        id: event.id,
        startDate: event.startDate,
        finishDate: event.startDate.add(Duration(minutes: timeStep)),
      ));
    }
    if (diff > 0) {
      events['startEvents']!.add(
        Event(
            title: event.title,
            description: event.description,
            goals: event.goals,
            id: event.id,
            startDate: event.startDate,
            finishDate: event.startDate.add(Duration(minutes: timeStep))),
      );
      events['endEvents']!.add(
        Event(
            title: event.title,
            description: event.description,
            goals: event.goals,
            id: event.id,
            startDate: event.finishDate.subtract(Duration(minutes: timeStep)),
            finishDate: event.finishDate),
      );
      for (int j = 0;
          j <
              (event.finishDate
                          .subtract(Duration(minutes: timeStep * 2))
                          .difference(event.startDate)
                          .inMinutes ~/
                      timeStep) +
                  1;
          j++) {
        events['midEvents']!.add(Event(
          title: event.title,
          description: event.description,
          goals: event.goals,
          id: event.id,
          startDate: event.startDate.add(Duration(minutes: timeStep * j)),
          finishDate:
              event.startDate.add(Duration(minutes: timeStep * (j + 1))),
        ));
      }
    }
  }
  return events;
}

isEvent(index, DateTime date, Map<String, List<Event>> all_events) {
  var timeStep = Hive.box('Calendar').get('timeStep');
  DateTime cellDate = DateTime(date.year, date.month, date.day);
  cellDate = cellDate.add(Duration(minutes: timeStep * (index ~/ 3)));
  for (int i = 0; i < all_events['startEndEvents']!.length; i++) {
    Event event = all_events['startEndEvents']![i];
    if (event.startDate.compareTo(cellDate) == 0) {
      return Container(
        child: Text(event.title),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
      );
    }
  }
  for (int i = 0; i < all_events['startEvents']!.length; i++) {
    Event event = all_events['startEvents']![i];
    if (event.startDate.compareTo(cellDate) == 0) {
      return Container(
        child: Text(event.title),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
      );
    }
  }
  for (int i = 0; i < all_events['endEvents']!.length; i++) {
    Event event = all_events['endEvents']![i];
    if (event.startDate.compareTo(cellDate) == 0) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
      );
    }
  }
  for (int i = 0; i < all_events['midEvents']!.length; i++) {
    Event event = all_events['midEvents']![i];
    if (event.startDate.compareTo(cellDate) == 0) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      );
    }
  }
  // for (Event event in all_events['startEndEvents']) {}
  // for (Event event in all_events) {
  //   if ((timeStep * (index ~/ 3)) % 60 == event.startDate.minute) {
  //     if ((timeStep * (index ~/ 3)) ~/ 60 == event.startDate.hour) {
  //       if (date.weekday == event.startDate.weekday) {
  //         if (date.month == event.startDate.month) {
  //           return eventTile(event);
  //         }
  //       }
  //     }
  //   }
  // }
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
  return null;
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
