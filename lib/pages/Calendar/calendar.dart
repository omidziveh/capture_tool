import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'calendar_page.dart';
import 'package:hive/hive.dart';

import 'time_column.dart';

int timeStep = Hive.box('Calendar').get('timeStep');

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late LinkedScrollControllerGroup controllers;
  late ScrollController time;
  DateTime startDate = DateTime.now();
  PageController cellsController = PageController(initialPage: 1000);
  PageController daysController = PageController(initialPage: 1000);


  @override
  void initState() {
    super.initState();
    controllers = LinkedScrollControllerGroup();
    time = controllers.addAndGet();
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
            width: MediaQuery.of(context).size.width * 0.88,
            child: PageView.builder(
              itemCount: 2000,
              reverse: true,
              controller: this.cellsController,
              itemBuilder: (BuildContext context, int index) {
                return CalendarPage(time, controllers, index);
              },
            ),
          ),
        Column(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.2 - 8,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.12,
              child: ListView.builder(
                itemCount: 25 * 60 ~/ timeStep,
                controller: time,
                itemBuilder: (context, index) {
                  return TimeCell(index: index);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
