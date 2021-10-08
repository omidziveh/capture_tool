import 'package:capture_tool/pages/Calendar/event_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'calendar_page.dart';
import 'package:hive/hive.dart';

import 'LinkedScrollController.dart';
import 'time_column.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late LinkedScrollControllerGroup _controllers;
  late ScrollController time;
  DateTime startDate = DateTime.now();
  PageController cellsController = PageController(initialPage: 1000);
  PageController daysController = PageController(initialPage: 1000);

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    time = _controllers.addAndGet();
  }

  @override
  void dispose() {
    time.dispose();
    super.dispose();
  }

  double height = 100;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.85,
          child: PageView.builder(
            itemCount: 2000,
            reverse: true,
            controller: this.cellsController,
            itemBuilder: (BuildContext context, int index) {
              return CalendarPage(time, _controllers, index);
            },
          ),
        ),
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2 - 12,
              width: MediaQuery.of(context).size.width * 0.15,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.15,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 25 * 60 ~/ Hive.box('Calendar').get('timeStep'),
                controller: time,
                itemBuilder: (context, index) {
                  return TimeCell(
                    index: index,
                    controllers: _controllers,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
