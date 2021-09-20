import '../../style.dart';

import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shamsi_date/extensions.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dialogs.dart';

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
  'شنبه',
  'یکشنبه',
  'دوشنبه',
  'سه شنبه',
  'چهارشنبه',
  'پنج شنبه',
  'جمعه'
];

class CalendarPage extends StatefulWidget {
  final DateTime startDate;
  double cellAspectRatio = 1.8;

  CalendarPage({
    required this.startDate,
  });

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int timeStep = Hive.box('Calendar').get('duration');
  int tableItemCount = 25 * 4 * (60 ~/ Hive.box('Calendar').get('duration'));
  bool addMoreMode = false;
  var addState =
      List.filled(25 * 4 * (60 ~/ Hive.box('Calendar').get('duration')), false);

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
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.06),
          child: SizedBox(
            height: 50,
            child: GestureDetector(
              onTap: () {
                print('Tapped on top bar');
              },
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 3) {
                    return Container();
                  }
                  return Container(
                    //color: (this.startDate.add(Duration(days: -index -1)) == DateTime.now())? Colors.black: Colors.blue,
                    padding:
                        EdgeInsets.only(bottom: 4, top: 3, right: 3, left: 3),
                    margin: EdgeInsets.all(3),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: FittedBox(
                            child: Text(
                              weekDays[this
                                      .widget
                                      .startDate
                                      .add(Duration(days: -index - 1))
                                      .toJalali()
                                      .weekDay -
                                  1],
                              style: calendarWeekStyle,
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                              this
                                  .widget
                                  .startDate
                                  .add(Duration(days: -index - 1))
                                  .toJalali()
                                  .day
                                  .toString()
                                  .toPersianDigit(),
                              style: calendarWeekStyle),
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
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, childAspectRatio: widget.cellAspectRatio),
        itemCount: tableItemCount,
        itemBuilder: (BuildContext context, int index) {
          if (index >= tableItemCount - 4 * (60 ~/ timeStep)) {
            return Container(
              color: Colors.transparent,
            );
          } // انتهای جدول برای خالی کردن فضا

          if (index % 4 == 3) {
            return Container(
              alignment: Alignment(0.0, -10.0),
              decoration: BoxDecoration(
                border: (((index - 3) ~/ 4 + 1) % (60 ~/ timeStep) == 0)
                    ? Border(
                        bottom: BorderSide(width: 0.6, color: Colors.black))
                    : null,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: time(index),
              ),
            );
          } // ستون مربوط به زمان ها

          return GestureDetector(
            onTap: () => _addMode(index),
            onLongPress: () {
              print('Long Pressed.');
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.black45,
                width: 0.3,
              )),
            ),
          );
        },
      ),
    );
  }

  monthName() {
    return FittedBox(
      child: Text(
        this.widget.startDate.toJalali().month !=
                this.widget.startDate.add(-Duration(days: 3)).toJalali().month
            ? '${months[this.widget.startDate.toJalali().month - 2]} - ${months[this.widget.startDate.add(Duration(days: 3)).toJalali().month - 1]}'
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

  _addMode(index) {
    eventCreateBottomSheet(context, index, this.widget.startDate);
  }
}

class EventStakeHolder extends StatefulWidget {
  @override
  _EventStakeHolderState createState() => _EventStakeHolderState();
}

class _EventStakeHolderState extends State<EventStakeHolder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.black,
    );
  }
}
