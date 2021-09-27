import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'LinkedScrollController.dart';
import 'package:capture_tool/style.dart';

int timeStep = Hive.box('Calendar').get('timeStep');

class TimeCell extends StatefulWidget {
  int index;
  LinkedScrollControllerGroup controllers;
  DateTime now = DateTime.now();
  TimeCell({required this.index, required this.controllers});

  @override
  _TimeCellState createState() => _TimeCellState();
}

class _TimeCellState extends State<TimeCell> with TickerProviderStateMixin{
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        widget.now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 50,
        child: (this.widget.index > (24 * 60 / timeStep))
            ? Container(color: Colors.transparent)
            : Container(
                //color: Colors.black38,
                margin: EdgeInsets.only(left: 5, right: 10),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Column(
                        children: [
                          Container(
                            height: (widget.now.minute % timeStep).toDouble() * (50 / timeStep) + 7,
                            color: Colors.transparent,
                          ),
                          Container(
                            color: widget.index == timeIndex() ? Colors.redAccent : Colors.transparent,
                            height: 3,
                          ),
                        ],
                      ),
                    ),
                    FittedBox(child: Text(time(this.widget.index),style: calendarTimeStyle,)),
                  ],
                ),
              ),
      ),
    );
  }

  time(int index) {
    List<String> duration =
        Duration(minutes: timeStep * index).toString().split(':');
    String hour = duration[0];
    String minute = duration[1];

    return ("${hour.toPersianDigit()}:${minute.toPersianDigit()}");
  }

  timeIndex() {
    return (widget.now.hour * 60 + widget.now.minute) ~/ timeStep;
  }
}
