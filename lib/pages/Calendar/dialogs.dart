import 'package:capture_tool/button.dart';
import 'package:capture_tool/db/models/event/event_db.dart';
import 'package:capture_tool/db/models/pre_task/pretask.dart';
import 'package:capture_tool/db/models/pre_task/pretask_db.dart';
import 'package:capture_tool/default_appbar.dart';
import 'package:capture_tool/pages/Capture_Tool/textfield.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  ValueNotifier<int> isValid = ValueNotifier(1);

  Widget build(BuildContext context) {
    setDefaultPreTask();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: defaultAppBar('اضافه کردن رویداد', context),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
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
                    ColoredButton(
                      icon: Icon(Icons.remove),
                      onTap: () {
                        setState(() {
                          widget.eventStartTime = widget.eventStartTime
                              .subtract(Duration(
                                  minutes:
                                      Hive.box('Calendar').get('timeStep')));
                        });
                      },
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
                    ColoredButton(
                      icon: Icon(Icons.add),
                      onTap: () {
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
                    ColoredButton(
                      icon: Icon(Icons.remove),
                      onTap: () {
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
                    ColoredButton(
                      icon: Icon(Icons.add),
                      onTap: () {
                        setState(() {
                          widget.eventFinishTime = widget.eventFinishTime.add(
                              Duration(
                                  minutes:
                                      Hive.box('Calendar').get('timeStep')));
                        });
                      },
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
                      borderRadius: BorderRadius.circular(15),
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
              Divider(color: Colors.black, thickness: 2),
              Padding(padding: EdgeInsets.only(top: 5)),
              ValueListenableBuilder(
                  valueListenable: isValid,
                  builder: (context, val, _) {
                    return DefaultTextFormField(
                      error:
                          isValid.value == 0 ? 'لطفا عنوان را وارد کنید' : null,
                      hintText: 'عنوان',
                      controller: titleController,
                      maxLength: 35,
                    );
                  }),
              Padding(padding: EdgeInsets.only(top: 5)),
              DefaultTextFormField(
                hintText: 'توضیحات',
                maxLines: 3,
                controller: descriptionController,
              ),
              Padding(padding: EdgeInsets.only(top: 25)),
              DefaultTextFormField(
                hintText: 'اهداف',
                maxLines: 3,
                controller: goalController,
              ),
              Container(
                height: 100,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: ColoredButton(
              icon: Icon(Icons.close_rounded),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: ColoredButton(
              icon: Icon(Icons.send_rounded),
              onTap: () {
                print(titleController.text);
                if (titleController.text == '') {
                  isValid.value = 0;
                } else {
                  isValid.value = 1;
                  addEvent(
                    titleController.text,
                    widget.eventStartTime,
                    widget.eventFinishTime,
                    descriptionController.text,
                    goalController.text,
                  );
                  print('LENGTH OF EVENTS BOX IS ${Hive.box('events').length}');
                  Navigator.pop(context);
                }
              },
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
