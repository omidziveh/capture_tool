import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

double lastPos = 0;

class CalendarPage extends StatefulWidget {
  ScrollController time;
  LinkedScrollControllerGroup controllers;
  double initialHeight;

  CalendarPage(this.time, this.controllers, [this.initialHeight = 100]);

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
    return GridView.builder(
      controller: controller,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1 / 2),
      itemBuilder: (BuildContext context, int index) {
        return Card();
      },
    );
  }
}
