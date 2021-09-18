import '../../style.dart';

import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shamsi_date/extensions.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

List<String> months = [
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
  'ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج',
];

class CalendarPage extends StatelessWidget {
  final DateTime startDate;
  int timeStep = Hive.box('Calendar').get('duration');

  CalendarPage({
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    // print(this.startDate.toJalali());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          child: monthName(),
          alignment: Alignment.centerRight,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.06),
            child: SizedBox(
              height: 50,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 7) {
                    return Container();
                  } return Container(
                    //color: (this.startDate.add(Duration(days: -index -1)) == DateTime.now())? Colors.black: Colors.blue,
                    padding: EdgeInsets.only(bottom: 4, top: 3, right: 3, left: 3),
                      margin: EdgeInsets.all(3),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                              weekDays[this.startDate.add(Duration(days: -index - 1)).toJalali().weekDay - 1],
                              style: calendarWeekStyle,
                          ),
                        ),
                        Text(
                          this.startDate.add(Duration(days: -index - 1)).toJalali().day.toString().toPersianDigit(),
                          style: calendarWeekStyle
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
          itemCount: 24 * 8 * (60 ~/ timeStep),
          itemBuilder: (BuildContext context, int index) {
            if (index % 8 == 7) {
              return Container(
                alignment: Alignment(0.0, -10.0),
                decoration: BoxDecoration(
                  border: (((index - 6) ~/ 8 + 1) % (60 ~/ timeStep) == 0)? Border(
                    bottom: BorderSide(width: 0.6, color: Colors.black)
                  ): null,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: time(index),
                ),
              );
            } return Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black45,
                    width: 0.3,
                  )
              ),
            );
          },
        ),
      );
  }

  monthName() {
    return FittedBox(
      child: Text(
        this.startDate.toJalali().month != this.startDate.add(-Duration(days: 7)).toJalali().month ?
        '${months[this.startDate.toJalali().month]} - ${months[this.startDate.add(Duration(days: 7)).toJalali().month + 1]}'
            : '${months[this.startDate.toJalali().month + 1]}',
        textDirection: TextDirection.rtl,
        style: calendarMonthStyle,
        textAlign: TextAlign.right,
      ),
    );
  }

  time(index) {
    int division = (index - 6) ~/ 8;
    int minutes = timeStep * (division + 1);
    var duration = Duration(minutes: minutes).toString().split(':');
    return FittedBox(
      child: Text(
        '${duration[0].padLeft(2, '0').toPersianDigit()}:'
          '${duration[1].padLeft(2, '0').toPersianDigit()}',
        style: calendarTimeStyle,
      ),
    );
  }

}

