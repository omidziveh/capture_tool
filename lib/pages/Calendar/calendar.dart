import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'calendar_page.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late LinkedScrollControllerGroup controllers;
  late ScrollController time;

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
          width: MediaQuery.of(context).size.width * 0.8,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: PageView.builder(
              itemBuilder: (BuildContext context, int index) {
                return CalendarPage(time, controllers);
              },
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.2,
          child: ListView.builder(
            itemExtent: 20,
            controller: time,
            itemBuilder: (context, index) {
              return Container(
                height: height,
                color: Colors.red[(index * 100) % 900],
              );
            },
          ),
        ),
      ],
    );
  }
}

/// 1 / 2
/// 100
/// 
///
