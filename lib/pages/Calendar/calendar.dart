import 'package:flutter/material.dart';
import 'calendar_page.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:preload_page_view/preload_page_view.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      allowImplicitScrolling: true,
      controller: controller,
      itemBuilder: (BuildContext context, int index) {
        int todayWeekDay = Jalali.fromDateTime(DateTime.now()).weekDay;
        print(todayWeekDay);
        DateTime startDate = DateTime.now().subtract(Duration(days: todayWeekDay % 7 - 1));
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: CalendarPage(
            startDate: startDate.add(-Duration(days: 7 * (index-8))),
          ),
        );
      },
    );
  }
  final PageController controller = PageController(
    initialPage: 16,
  );

}

