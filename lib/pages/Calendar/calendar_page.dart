import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:hive/hive.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shamsi_date/extensions.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'event_placeholder.dart';

double lastPos = 0;
int timeStep = Hive.box('Calendar').get('timeStep');

class CalendarPage extends StatefulWidget {
  ScrollController time;
  LinkedScrollControllerGroup controllers;
  double initialHeight;
  int index;

  CalendarPage(this.time, this.controllers, this.index,
      [this.initialHeight = 100]);

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
          height: MediaQuery.of(context).size.height * 0.2 * 0.6,
          width: MediaQuery.of(context).size.width,
          child: Align(
            child: Text(month()),
            alignment: Alignment.bottomRight,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2 * 0.4,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 70,
                child: Column(
                  children: [
                    Text('${weekDays[JDate(2).weekDay]}', textAlign: TextAlign.center),
                    Text('${day(JDate(2))}', textAlign: TextAlign.center),
                  ],
                )
              ),
              Container(
                width: 70,
                child: Column(
                  children: [
                    Text('${weekDays[JDate(1).weekDay]}', textAlign: TextAlign.center),
                    Text('${day(JDate(1))}', textAlign: TextAlign.center),
                  ],
                ),
              ),
              Container(
                width: 70,
                color: (JDate(0) == Jalali.now())?Colors.red:Colors.transparent,
                child: Column(
                  children: [
                    Text('${weekDays[JDate(0).weekDay]}', textAlign: TextAlign.center),
                    Text('${day(JDate(0))}', textAlign: TextAlign.center),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
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
                  pageStartDate: DateTime.now().add(Duration(days: widget.index - 1000)),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  String day(Jalali jDate) {
    return jDate.day.toString().toPersianDigit();
  }

  Jalali JDate(int i) {
    return DateTime.now()
        .add(Duration(days: (widget.index - 1000) * 3 + i))
        .toJalali();
  }

  String month() {
    Jalali first = JDate(0);
    Jalali last = JDate(2);

    if (first.month == last.month) {
      return '${months[first.month]} ${first.year.toString().toPersianDigit()}';
    }
    if (first.year == last.year) {
      return '${months[first.month]}-${months[last.month]} ${first.year.toString().toPersianDigit()}';
    }
    return '${months[first.month]} ${first.year.toString().toPersianDigit()}-${months[last.month]} ${last.year.toString().toPersianDigit()}';
  }
}

List<String> months = [
  '',
  'فروردین',
  'اردیبهشت',
  'خرداد',
  'تیر',
  'مرداد',
  'شهریور',
  'مهر',
  'آبان',
  'آذر',
  'دی',
  'بهمن',
  'اسفند',
];

List<String> weekDays = [
  '',
  'شنبه',
  'یکشنبه',
  'دوشنبه',
  'سه‌شنبه',
  'چهارشنبه',
  'پنج‌شنبه',
  'جمعه',
];