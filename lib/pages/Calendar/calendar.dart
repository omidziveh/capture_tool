import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

int timeStep = Hive.box('Calendar').get('duration');

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 2000,
      controller: controller,
      itemBuilder: (BuildContext context, int index) {
        DateTime startDate =
            DateTime.now().subtract(Duration(days: (1000 - index)));
        return CalendarPage(startDate: startDate);
      },
    );
  }

  PageController controller = PageController(
    initialPage: 1000,
  );
}

/// Calendar Page: Each page has 3 days in it.
class CalendarPage extends StatefulWidget {
  final DateTime startDate;

  const CalendarPage({
    required this.startDate,
  });

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late LinkedScrollControllerGroup _controllerGroup;
  late ScrollController _timeController;
  late ScrollController _tableController;

  @override
  void initState() {
    super.initState();
    _controllerGroup = LinkedScrollControllerGroup();
    _timeController = _controllerGroup.addAndGet();
    _tableController = _controllerGroup.addAndGet();
  }

  @override
  void dispose() {
    _timeController.dispose();
    _tableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: ListView.builder(
              controller: _timeController,
              itemCount: 24 * 60 ~/ timeStep,
              itemBuilder: (BuildContext context, int index) {
                return Text(index.toString());
              }),
        ),
        GridView.builder(
          controller: _tableController,
          itemCount: 2 * 24 * 60 ~/ timeStep,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
                width: 10, height: 30, child: Text(index.toString()));
          },
        )
      ],
    );
  }
}
