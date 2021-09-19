import '../../style.dart';

import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shamsi_date/extensions.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
  'شنبه', 'یکشنبه', 'دوشنبه', 'سه شنبه', 'چهارشنبه', 'پنج شنبه', 'جمعه'];

class CalendarPage extends StatefulWidget {
  final DateTime startDate;
  double cellAspectRatio = 1.5;

  CalendarPage({
    required this.startDate,
  });

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}



class _CalendarPageState extends State<CalendarPage> {
  int timeStep = Hive.box('Calendar').get('duration');

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
              child: GestureDetector(
                onTap: (){
                  print('Tapped on top bar');
                },
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 3) {
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
                                weekDays[this.widget.startDate.add(Duration(days: -index - 1)).toJalali().weekDay - 1],
                                style: calendarWeekStyle,
                            ),
                          ),
                          Text(
                            this.widget.startDate.add(Duration(days: -index - 1)).toJalali().toString(),
                            style: TextStyle(color: Colors.white),
                            //style: calendarWeekStyle
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
        ),
      ),
      body: GestureDetector(
        // onScaleUpdate: (detail) {
        //   setState(() {
        //     if (detail.scale < 1) {
        //       if (widget.cellAspectRatio <= 2.5) {
        //         print("Above");
        //         widget.cellAspectRatio += 0.004;
        //       }
        //     } else if (detail.scale > 1) {
        //       if (widget.cellAspectRatio >= 1) {
        //         print("Below");
        //         widget.cellAspectRatio -= 0.004;
        //         }
        //       }
        //   });
        // },
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: widget.cellAspectRatio),
            itemCount: 24 * 4 * (60 ~/ timeStep),
            itemBuilder: (BuildContext context, int index) {
              if (index % 4 == 3) {
                return Container(
                  alignment: Alignment(0.0, -10.0),
                  decoration: BoxDecoration(
                    border: (((index - 6) ~/ 4   + 1) % (60 ~/ timeStep) == 0)? Border(
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
      ),
      );
  }

  monthName() {
    return FittedBox(
      child: Text(
        this.widget.startDate.toJalali().month != this.widget.startDate.add(-Duration(days: 3)).toJalali().month ?
        '${months[this.widget.startDate.toJalali().month - 2]} - ${months[this.widget.startDate.add(Duration(days: 3)).toJalali().month - 1]}'
            : '${months[this.widget.startDate.toJalali().month - 1]}',
        textDirection: TextDirection.rtl,
        style: calendarMonthStyle,
        textAlign: TextAlign.right,
      ),
    );
  }

  time(index) {
    int division = (index - 2) ~/ 4;
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

