import '../../style.dart';

import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shamsi_date/extensions.dart';

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

class CalendarPage extends StatelessWidget {
  final DateTime startDate;

  CalendarPage({
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    print(this.startDate.toJalali());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
              this.startDate.toJalali().month != this.startDate.add(-Duration(days: 7)).toJalali().month ?
                  '${months[this.startDate.toJalali().month + 1]} - ${months[this.startDate.add(Duration(days: 7)).toJalali().month]}'
                  : '${months[this.startDate.toJalali().month + 1]}',
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
              child: SizedBox(
                height: 30,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 7) {
                      return Container();
                    } return Container(
                      child: Center(
                        child: Text(this.startDate.add(Duration(days: -index - 1)).toJalali().day.toString(), style: TextStyle(color: Colors.white),)
                      ),
                    );
                  },
                ),
              ),
          ),
        ),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
            itemBuilder: (BuildContext context, int index) {
              if (index % 8 == 7) {
                return Padding(
                  padding: EdgeInsets.all(2.5),
                  child: Container(
                    child: Align(
                      child: Text('hello'),
                    ),
                  ),
                );
              } return Padding(
                padding: EdgeInsets.all(2.5),
                child: Container(
                  child: Center(child: Text('$index')),
                ),
              );
            },
          ),
        ),
    );
  }
}

