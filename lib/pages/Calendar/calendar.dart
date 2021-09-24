import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'calendar_page.dart';
=======
import 'package:shamsi_date/shamsi_date.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

int timeStep = Hive.box('Calendar').get('duration');
>>>>>>> 24e788a2827d4db8f837f9e0713c72de0abec542

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
<<<<<<< HEAD
  late LinkedScrollControllerGroup controllers;
  late ScrollController time;

  @override
  void initState() {
    super.initState();
    controllers = LinkedScrollControllerGroup();
    time = controllers.addAndGet();
  }

  @override
  void dispose() {
    time.dispose();
    super.dispose();
  }

  double height = 100;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: PageView.builder(
              itemBuilder: (BuildContext context, int index) {
                return CalendarPage(time, controllers);
              },
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.2,
          child: ListView.builder(
            itemExtent: 20,
            controller: time,
            itemBuilder: (context, index) {
              return Container(
                height: height,
                color: Colors.red[(index * 100) % 900],
              );
            },
          ),
        ),
      ],
    );
  }
}

/// 1 / 2
/// 100
/// 
///
=======
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
>>>>>>> 24e788a2827d4db8f837f9e0713c72de0abec542
