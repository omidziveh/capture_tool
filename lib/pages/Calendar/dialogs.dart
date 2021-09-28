// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:hive/hive.dart';

// import '../../style.dart';
// import '../../validators.dart';
// import '../../models/pretask.dart';

// final _formKey = GlobalKey<FormState>();

// class CaptureToolDialog extends StatefulWidget {
//   final FocusNode myFocusNode;

//   CaptureToolDialog({
//     required this.myFocusNode,
//   });

//   @override
//   _CaptureToolDialogState createState() => _CaptureToolDialogState();
// }

// class _CaptureToolDialogState extends State<CaptureToolDialog> {
//   TextEditingController _nameController = TextEditingController();
//   final _scaffoldKey = new GlobalKey<ScaffoldState>();

//   TextEditingController _descriptionController = TextEditingController();

//   int importance = 0;

//   Widget build(BuildContext context) {
//     this.widget.myFocusNode.requestFocus();
//     return WillPopScope(
//       onWillPop: () async {
//         print('hello');
//         FocusScope.of(context).unfocus();
//         return true;
//       },
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.5,
//         width: MediaQuery.of(context).size.width * 0.7,
//         child: AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(25),
//           ),
//           content: Form(
//             key: _formKey,
//             child: Column(
//               textDirection: TextDirection.rtl,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(bottom: 5),
//                   child: Text(
//                     'اضافه کردن کار',
//                     style: addTaskDialogTitle,
//                   ),
//                 ),
//                 Divider(
//                   color: Colors.black,
//                   thickness: 2,
//                 ),

//                 ///TextField for naming the task
//                 Padding(
//                   padding: EdgeInsets.all(5),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: EdgeInsets.zero,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         keyboardType: TextInputType.name,
//                         autofocus: true,
//                         focusNode: widget.myFocusNode,
//                         controller: _nameController,
//                         validator: taskNameValidator,
//                         style: addTaskDialogTextField,
//                         textDirection: TextDirection.rtl,
//                         textAlign: TextAlign.right,
//                         cursorColor: Colors.black,
//                         decoration: InputDecoration(
//                           errorStyle: addTaskDialogError,
//                           hintText: 'عنوان',
//                           contentPadding: EdgeInsets.only(
//                               left: 10, right: 10, top: 2, bottom: 2),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide:
//                                 BorderSide(width: 0, style: BorderStyle.none),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 ///TextField for add description to task
//                 Padding(
//                   padding: EdgeInsets.all(5),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: EdgeInsets.zero,
//                     child: TextFormField(
//                       // autofocus: true,
//                       controller: _descriptionController,
//                       style: addTaskDialogTextField,
//                       maxLines: 3,
//                       textDirection: TextDirection.rtl,
//                       textAlign: TextAlign.right,
//                       cursorColor: Colors.black,
//                       decoration: InputDecoration(
//                         hintText: 'توضیحات',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide:
//                               BorderSide(width: 0, style: BorderStyle.none),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 /// Rating bar for adding task
//                 Padding(
//                   padding: EdgeInsets.all(6),
//                   child: StatefulBuilder(
//                     builder: (BuildContext context, Function setState) {
//                       return RatingBar.builder(
//                         allowHalfRating: false,
//                         direction: Axis.horizontal,
//                         glow: false,
//                         itemCount: 3,
//                         onRatingUpdate: (double val) {
//                           print(importance);
//                           setState(() {
//                             importance = val.round();
//                           });
//                         },
//                         itemBuilder: (context, _) {
//                           return Icon(
//                             Icons.star_rounded,
//                             color: Colors.black,
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),

//                 /// Submit and Close button
//                 Row(
//                   children: [
//                     TextButton(
//                       child: Text('اضافه کن', style: addTaskDialogButton),
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           Hive.box('preTasks').put(
//                             Hive.box('ID').get('id'),
//                             PreTask(
//                               name: _nameController.text,
//                               description: _descriptionController.text,
//                               importance: importance,
//                             ),
//                           );
//                           Hive.box('ID').put(
//                             'id',
//                             Hive.box('ID').get('id') + 1,
//                           );
//                           Navigator.pop(context);
//                         }
//                       },
//                     ),
//                     Spacer(),
//                     TextButton(
//                       child: Text('بستن', style: addTaskDialogButton),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// //
// // Widget editTaskDialog(context, myFocusNode) {
// //   return captureToolDialog(context, myFocusNode).createElement().widget;
// // }

// class EditTaskDialog extends StatefulWidget {
//   const EditTaskDialog({Key? key}) : super(key: key);

//   @override
//   _EditTaskDialogState createState() => _EditTaskDialogState();
// }

// class _EditTaskDialogState extends State<EditTaskDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       content: Column(
//         children: [],
//       ),
//     );
//   }
// }

// class MyBottomSheet extends StatefulWidget {
//   final String name;
//   final String description;
//   final int importance;

//   MyBottomSheet({
//     required this.name,
//     required this.description,
//     required this.importance,
//   });

//   @override
//   _MyBottomSheetState createState() => _MyBottomSheetState();
// }

// class _MyBottomSheetState extends State<MyBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(children: []),
//     );
//   }
// }

import 'package:capture_tool/db/models/pre_task/pretask.dart';
import 'package:capture_tool/db/models/pre_task/pretask_db.dart';
import 'package:capture_tool/pages/Calendar/calendar.dart';
import 'package:capture_tool/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shamsi_date/extensions.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../glass/glass_button.dart';

final formKey = GlobalKey<FormState>();

String boxListMenuValue = 'لیست کارها';
late PreTask preTaskValue;

void eventCreateBottomSheet(
  BuildContext context,
  DateTime eventStartTime,
  DateTime eventFinishTime,
) {
  String eventTitle;
  String eventDescription;
  //List<String> eventGoals = [];


  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  showModalBottomSheet(
    isScrollControlled: true,
    enableDrag: true,
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 1,
        expand: false,
        builder: (context, controller) {
          return StatefulBuilder(builder: (context, setState) {
            return ListView(children: [
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      eventStartTime.toPersianDateStr(),
                      textDirection: TextDirection.rtl,
                    ),
                    Text('روز'),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GlassButton(
                      width: 60,
                      height: 60,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            eventStartTime = eventStartTime
                                .subtract(Duration(minutes: timeStep));
                          });
                        },
                        icon: Icon(Icons.remove),
                        splashColor: Colors.transparent,
                      ),
                      borderRadius: 15,
                    ),
                    Row(
                      children: [
                        Text(eventStartTime.hour.toString().toPersianDigit()),
                        Text(":"),
                        Text(eventStartTime.minute.toString().toPersianDigit())
                      ],
                    ),
                    GlassButton(
                      width: 60,
                      height: 60,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            DateTime newStartTime =
                                eventStartTime.add(Duration(minutes: timeStep));
                            if (newStartTime.isBefore(eventFinishTime)) {
                              eventStartTime = newStartTime;
                            }
                          });
                        },
                        icon: Icon(Icons.add),
                        splashColor: Colors.transparent,
                      ),
                      borderRadius: 15,
                    ),
                    Text('زمان شروع'),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GlassButton(
                      width: 60,
                      height: 60,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            DateTime newFinishTime = eventFinishTime
                                .subtract(Duration(minutes: timeStep));
                            if (newFinishTime.isAfter(eventStartTime)) {
                              eventFinishTime = newFinishTime;
                            }
                          });
                        },
                        icon: Icon(Icons.remove),
                        splashColor: Colors.transparent,
                      ),
                      borderRadius: 15,
                    ),
                    Row(
                      children: [
                        Text(eventFinishTime.hour.toString().toPersianDigit()),
                        Text(":"),
                        Text(eventFinishTime.minute.toString().toPersianDigit())
                      ],
                    ),
                    GlassButton(
                      width: 60,
                      height: 60,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            eventFinishTime = eventFinishTime
                                .add(Duration(minutes: timeStep));
                          });
                        },
                        icon: Icon(Icons.add),
                        splashColor: Colors.transparent,
                      ),
                      borderRadius: 15,
                    ),
                    Text('زمان پایان'),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DropdownButton<PreTask>(
                      //value: preTaskValue,
                      // iconSize: 24,
                      onChanged: (PreTask? newValue) {
                        setState(() {
                          preTaskValue = newValue!;
                          if (newValue != null) {
                            titleController.text = newValue.title;
                            descriptionController.text = newValue.description;
                          }
                        });
                      },
                      items: preTaskListMenu(),
                    ),
                    DropdownButton<String>(
                      value: boxListMenuValue,
                      // iconSize: 24,
                      onChanged: (String? newValue) {
                        setState(() {
                          boxListMenuValue = newValue!;

                        });
                      },
                      items: boxListMenu(),
                    ),
                    Text(
                      'انتخاب از لیست ها: ',
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: TextField(
                  controller: titleController,
                  textDirection: TextDirection.rtl,
                  maxLength: 50,
                  maxLines: 1,
                ),
              ),
              SizedBox(
                height: 200,
                child: TextField(
                  controller: descriptionController,
                  textDirection: TextDirection.rtl,
                  maxLines: 5,
                ),
              )
            ]);
          });
        },
      );
    },
  );
}

List<DropdownMenuItem<PreTask>> preTaskListMenu() {
  if(boxListMenuValue == 'لیست کارها'){
    List<dynamic> preTasks = all_pre_tasks();
    return preTasks.map((e) => DropdownMenuItem<PreTask>(
      value: e,
      child: Text(
        e.title.toString(),
        textDirection: TextDirection.rtl,
      ),
    )).toList();
  }
  if(boxListMenuValue == 'بازگشت هفتگی'){
    List<dynamic> preTasks = all_pre_tasks(box: Hive.box('weeklyReturn'));
    return preTasks.map((e) => DropdownMenuItem<PreTask>(
      value: e,
      child: Text(
        e.title.toString(),
        textDirection: TextDirection.rtl,
      ),
    )).toList();
  }
  else{
    List<dynamic> preTasks = all_pre_tasks(box: Hive.box('monthlyReturn'));
    return preTasks.map((e) => DropdownMenuItem<PreTask>(
      value: e,
      child: Text(
        e.title.toString(),
        textDirection: TextDirection.rtl,
      ),
    )).toList();
  }
}

List<DropdownMenuItem<String>> boxListMenu() {
  List<String> choices = ['لیست کارها', 'بازگشت هفتگی', 'بازگشت ماهانه'];
  return choices
      .map((e) => DropdownMenuItem<String>(
          value: e.toString(),
          child: Center(
            child: Text(
              e.toString(),
              textDirection: TextDirection.rtl,
            ),
          )))
      .toList();
}
