import 'package:flutter/material.dart';
import 'calendar_page.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(initialPage: 10),
      itemBuilder: (BuildContext context, int index) {
        return CalendarPage(
          startDate: DateTime.now().add(-Duration(days: 7 * (index-8))),
        );
      },
    );
  }
}

