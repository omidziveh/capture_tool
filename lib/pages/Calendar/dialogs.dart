import 'package:capture_tool/db/models/pre_task/pretask.dart';
import 'package:capture_tool/db/models/pre_task/pretask_db.dart';
import 'package:capture_tool/default_appbar.dart';
import 'package:capture_tool/glass/glass_widget.dart';
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
late PreTask? preTaskValue;

class AddEvent extends StatefulWidget {
  DateTime eventStartTime;
  DateTime eventFinishTime;

  AddEvent({
    required this.eventStartTime,
    required this.eventFinishTime,
  });

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();
  late String eventTitle;
  late String eventDescription;
  //List<String> eventGoals = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController goalController = TextEditingController();

  Widget build(BuildContext context) {
    setDefaultPreTask();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: defaultAppBar('اضافه کردن رویداد', context),
      body: Container(
        color: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.eventStartTime.toPersianDateStr(),
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
                          widget.eventStartTime = widget.eventStartTime
                              .subtract(Duration(
                                  minutes:
                                      Hive.box('Calendar').get('timeStep')));
                        });
                      },
                      icon: Icon(Icons.remove),
                      splashColor: Colors.transparent,
                    ),
                    borderRadius: 15,
                  ),
                  Row(
                    children: [
                      Text(widget.eventStartTime.hour
                          .toString()
                          .toPersianDigit()),
                      Text(":"),
                      Text(widget.eventStartTime.minute
                          .toString()
                          .toPersianDigit())
                    ],
                  ),
                  GlassButton(
                    width: 60,
                    height: 60,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          DateTime newStartTime = widget.eventStartTime.add(
                              Duration(
                                  minutes:
                                      Hive.box('Calendar').get('timeStep')));
                          if (newStartTime.isBefore(widget.eventFinishTime)) {
                            widget.eventStartTime = newStartTime;
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
                          DateTime newFinishTime = widget.eventFinishTime
                              .subtract(Duration(
                                  minutes:
                                      Hive.box('Calendar').get('timeStep')));
                          if (newFinishTime.isAfter(widget.eventStartTime)) {
                            widget.eventFinishTime = newFinishTime;
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
                      Text(widget.eventFinishTime.hour
                          .toString()
                          .toPersianDigit()),
                      Text(":"),
                      Text(widget.eventFinishTime.minute
                          .toString()
                          .toPersianDigit())
                    ],
                  ),
                  GlassButton(
                    width: 60,
                    height: 60,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.eventFinishTime = widget.eventFinishTime.add(
                              Duration(
                                  minutes:
                                      Hive.box('Calendar').get('timeStep')));
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
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton<PreTask>(
                    value: preTaskValue,
                    // iconSize: 24,
                    onChanged: (PreTask? newValue) {
                      setState(() {
                        preTaskValue = newValue;
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
                      setDefaultPreTask();
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
            Form(
              key: _formKey,
              child: Table(
                columnWidths: {0: FractionColumnWidth(.7)},
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'لطفا عنوان را وارد کنید';
                              }
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                ),
                              ),
                            ),
                            controller: titleController,
                            textDirection: TextDirection.rtl,
                            maxLength: 35,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'عنوان:   ',
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            maxLines: 3,
                            controller: descriptionController,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'توضیحات: ',
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            maxLines: 3,
                            controller: goalController,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'اهداف: ',
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: GlassButton(
              borderRadius: 15,
              child: IconButton(
                splashColor: Colors.transparent,
                icon: Icon(Icons.close_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              height: 60,
              width: 60,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: GlassButton(
              borderRadius: 15,
              child: IconButton(
                splashColor: Colors.transparent,
                icon: Icon(Icons.send_rounded),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
              ),
              height: 60,
              width: 60,
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<PreTask>> preTaskListMenu() {
    if (boxListMenuValue == 'لیست کارها') {
      List<dynamic> preTasks = all_pre_tasks();
      return preTasks
          .map((e) => DropdownMenuItem<PreTask>(
                value: e,
                child: Text(
                  e.title.toString(),
                  textDirection: TextDirection.rtl,
                ),
              ))
          .toList();
    }
    if (boxListMenuValue == 'بازگشت هفتگی') {
      List<dynamic> preTasks = all_pre_tasks(box: Hive.box('weeklyReturn'));
      return preTasks
          .map((e) => DropdownMenuItem<PreTask>(
                value: e,
                child: Text(
                  e.title.toString(),
                  textDirection: TextDirection.rtl,
                ),
              ))
          .toList();
    } else {
      List<dynamic> preTasks = all_pre_tasks(box: Hive.box('monthlyReturn'));
      return preTasks
          .map((e) => DropdownMenuItem<PreTask>(
                value: e,
                child: Text(
                  e.title.toString(),
                  textDirection: TextDirection.rtl,
                ),
              ))
          .toList();
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

  void setDefaultPreTask() {
    if (boxListMenuValue == 'لیست کارها') {
      if (Hive.box('preTasks').length > 0) {
        preTaskValue = Hive.box('preTasks').getAt(0);
      } else {
        preTaskValue = null;
      }
    } else if (boxListMenuValue == 'بازگشت هفتگی') {
      if (Hive.box('weeklyReturn').length > 0) {
        preTaskValue = Hive.box('weeklyReturn').getAt(0);
      } else {
        preTaskValue = null;
      }
    } else {
      if (Hive.box('monthlyReturn').length > 0) {
        preTaskValue = Hive.box('monthlyReturn').getAt(0);
      } else {
        preTaskValue = null;
      }
    }
  }
}
