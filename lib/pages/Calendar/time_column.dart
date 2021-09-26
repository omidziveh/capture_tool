import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

int timeStep = Hive.box('Calendar').get('timeStep');


class TimeCell extends StatefulWidget {
  int index;
  TimeCell({required this.index});

  @override
  _TimeCellState createState() => _TimeCellState();
}

class _TimeCellState extends State<TimeCell> {


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 50,
        child: (this.widget.index > (24 * 60 / timeStep))?Container(color: Colors.transparent):Container(
          //color: Colors.black38,
          margin: EdgeInsets.only(left: 5),
          child: Text(time(this.widget.index)),
        ),
      ),
    );
  }

  time(int index){
    List<String> duration = Duration(minutes: timeStep * index).toString().split(':');
    String hour = duration[0];
    String minute = duration[1];

    return("${hour.toPersianDigit()}:${minute.toPersianDigit()}");
  }
}
