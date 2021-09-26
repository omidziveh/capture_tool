import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:hive/hive.dart';

import 'event_placeholder.dart';

double lastPos = 0;
int timeStep = Hive.box('Calendar').get('timeStep');

class CalendarPage extends StatefulWidget {
  ScrollController time;
  LinkedScrollControllerGroup controllers;
  double initialHeight;
  int index;

  CalendarPage(this.time, this.controllers, this.index,[this.initialHeight = 100]);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late ScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = widget.controllers.addAndGet();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('${widget.index * 3 + 0}'),
              Text('${widget.index * 3 + 1}'),
              Text('${widget.index * 3 + 2}'),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            child: GridView.builder(
              controller: controller,
              itemCount: 3 * 25 * 60 ~/ timeStep,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisExtent: 50),
              itemBuilder: (BuildContext context, int index) {
                return EventPlaceHolder(
                  index: index,
                  pageStartDate: DateTime.now().add(Duration(days: index)),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
