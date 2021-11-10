import 'package:capture_tool/db/models/event/event.dart';
import 'package:capture_tool/pages/Calendar/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../style.dart';

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
      return Container(color: Colors.transparent, height: 100);

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
          child: eventInTime(
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

BorderSide eventBorderSide = BorderSide(color: Colors.black, width: 2);

eventCell(Event event, Border border, EdgeInsets padding,
    [bool showText = true]) {
  return Builder(builder: (context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EventDialog(event: event)));
        },
        child: Container(
          padding: EdgeInsets.only(right: 3),
          height: 10,
          child: showText
              ? Text(
                  event.title.length > 15
                      ? '${event.title.substring(0, 15)}...'
                      : event.title,
                  textDirection: TextDirection.rtl,
                  style: calendarEventTextStyle,
                )
              : null,
          decoration: BoxDecoration(
            color: Colors.white,
            border: border,
          ),
        ),
      ),
    );
  });
}

drawEvent(Event event, mode) {
  /// mode: 0 -> startEnd, 1 -> start, 2 -> mid, 3 -> end
  if (mode == 0)
    return eventCell(
      event,
      Border.all(color: Colors.black, width: 2),
      EdgeInsets.all(5),
    );
  if (mode == 1)
    return eventCell(
      event,
      Border(
          left: eventBorderSide, right: eventBorderSide, top: eventBorderSide),
      EdgeInsets.fromLTRB(5, 5, 5, 0),
    );
  if (mode == 2)
    return eventCell(
      event,
      Border(left: eventBorderSide, right: eventBorderSide),
      EdgeInsets.fromLTRB(5, 0, 5, 0),
      false,
    );
  if (mode == 3)
    return eventCell(
      event,
      Border(
          bottom: eventBorderSide,
          left: eventBorderSide,
          right: eventBorderSide),
      EdgeInsets.fromLTRB(5, 0, 5, 5),
      false,
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

searchInEventBox(List<Event>? events, cellDate, timeStep, mode) {
  List<Widget> cellEvents = [];
  for (int i = 0; i < events!.length; i++) {
    Event event = events[i];
    if (event.startDate.compareTo(cellDate) >= 0 &&
        event.finishDate.compareTo(cellDate.add(Duration(minutes: timeStep))) <=
            0) {
      cellEvents.add(drawEvent(event, mode));
    }
  }
  if (cellEvents.length == 0) {
    return null;
  }
  if (cellEvents.length == 1) {
    return cellEvents[0];
  }
  if (cellEvents.length == 2) {
    return ListView(
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      children: cellEvents,
    );
  }
  return ListView(
    scrollDirection: Axis.horizontal,
    physics: NeverScrollableScrollPhysics(),
    children: [
      cellEvents[0],
    ],
  );
}

eventInTime(index, DateTime date, Map<String, List<Event>> all_events) {
  var timeStep = Hive.box('Calendar').get('timeStep');
  DateTime cellDate = DateTime(date.year, date.month, date.day);
  cellDate = cellDate.add(Duration(minutes: timeStep * (index ~/ 3)));
  for (int i = 0; i < all_events.length; i++) {
    String eventTitle = all_events.keys.toList()[i];
    if (searchInEventBox(all_events[eventTitle], cellDate, timeStep, i) !=
        null) {
      return searchInEventBox(all_events[eventTitle], cellDate, timeStep, i);
    }
  }

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
          builder: (BuildContext context) => EventDialog(
              eventStartTime: eventStartTime,
              eventFinishTime: eventFinishTime)));
}
