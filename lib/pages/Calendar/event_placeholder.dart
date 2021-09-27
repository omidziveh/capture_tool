import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

int timeStep = Hive.box('Calendar').get('timeStep');

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
    if ((this.widget.index >= (24 * 3 * 60 ~/ timeStep))) {
      return Container(color: Colors.transparent);
    } else {
      return GestureDetector(
        onTap: () {
          print(widget.index);
          print(widget.pageStartDate);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 0.5)),
        ),
      );
    }
  }
}