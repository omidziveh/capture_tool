// import 'package:capture_tool/pages/Capture_Tool/capture_tool.dart';
// import 'package:flutter/material.dart';
// import 'package:shamsi_date/shamsi_date.dart';
// import 'package:shamsi_date/extensions.dart';
// import 'table.dart';
//
// class Calendar extends StatefulWidget {
//   Calendar({Key? key}) : super(key: key);
//
//   @override
//   State<Calendar> createState() => _CalendarState();
// }
//
// class _CalendarState extends State<Calendar> {
//   double height = 20;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(child: MultiplicationTable())
//       // PageView(
//       //   children: [
//       //     MultiplicationTable(),
//       //     InteractiveViewer(
//       //       child: ListView.builder(
//       //           controller: controller,
//       //           itemBuilder: (BuildContext context, int index) {
//       //             return Container(color: Colors.blue[index % 10 * 100] ,height: height,);
//       //           }),
//       //       minScale: 0.5,
//       //       maxScale: 2.5,
//       //       onInteractionStart: (ScaleStartDetails scaleStartDetails) {
//       //         print('started');
//       //       },
//       //       onInteractionEnd: (ScaleEndDetails scaleEndDetails) {
//       //         print('Ended');
//       //       },
//       //       onInteractionUpdate: (ScaleUpdateDetails scaleUpdateDetails) {
//       //         setState(() {
//       //           height = 20 * scaleUpdateDetails.scale;
//       //         });
//       //         print(scaleUpdateDetails.scale);
//       //       },
//       //
//       //     )
//       //],
//       //),
//     );
//   }
//
//   final ScrollController controller = ScrollController();
// }

import 'package:flutter/material.dart';
import 'calendar_page.dart';

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return CalendarPage(startDate: DateTime.now());
      },
    );
  }
}

