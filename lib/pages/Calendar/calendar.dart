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
  ListenerScrollController _controller = ListenerScrollController();
  DateTime startDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    controller.animateToPage(5,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  });
                },
                child: Icon(
                  Icons.today,
                  size: 20,
                ),
              )),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black,
        ),
      ),
      body: PageView.builder(
        onPageChanged: (int index) {
          print(index);
        },
        allowImplicitScrolling: true,
        reverse: true,
        controller: controller,
        itemBuilder: (BuildContext context, int index) {
          return (index == 5)
              ? CalendarPage(
                  controller: _controller,
                  startDate: startDate.add(Duration(days: 3 * (index - 4))),
                  today: true)
              : CalendarPage(
                  controller: _controller,
                  startDate: startDate.add(Duration(days: 3 * (index - 4))),
                  today: false);
        },
      ),
    );
  }

  final PageController controller = PageController(
    initialPage: 5,
  );

}


class ListenerScrollController extends ScrollController {

  void set offset (double new_offset) {
    offset = new_offset;
  }
}