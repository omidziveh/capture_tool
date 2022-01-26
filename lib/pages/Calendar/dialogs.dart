import 'package:capture_tool/button.dart';
import 'package:capture_tool/db/models/event/event.dart';
import 'package:capture_tool/db/models/event/event_db.dart';
import 'package:capture_tool/db/models/pre_task/pretask.dart';
import 'package:capture_tool/db/models/pre_task/pretask_db.dart';
import 'package:capture_tool/default_appbar.dart';
import 'package:capture_tool/icon.dart';
import 'package:capture_tool/pages/Capture_Tool/textfield.dart';
import 'package:capture_tool/style.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../glass/glass_button.dart';

final formKey = GlobalKey<FormState>();

String boxListMenuValue = 'لیست کارها';
late PreTask? preTaskValue;

class EventDialog extends StatefulWidget {
  late DateTime _eventStartTime;
  late DateTime _eventFinishTime;
  late String _eventTitle;
  late String _eventDescription;
  late String _eventGoals;
  late bool _canDelete;
  late var event;

  EventDialog(
      {DateTime? eventStartTime, DateTime? eventFinishTime, Event? event}) {
    this.event = event;
    this._canDelete = event == null ? false : true;
    this._eventStartTime = (event == null
        ? eventStartTime
        : Hive.box('events').get(event.id).startDate)!;
    this._eventFinishTime = (event == null
        ? eventFinishTime
        : Hive.box('events').get(event.id).finishDate)!;
    this._eventTitle = event == null ? '' : event.title;
    this._eventDescription = event == null ? '' : event.description;
    this._eventGoals = event == null ? '' : event.goals;
  }

  @override
  _EventDialogState createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController goalController = TextEditingController();
  ValueNotifier<int> isValid = ValueNotifier(1);
  String title = 'اضافه کردن رویداد';

  @override
  void initState() {
    super.initState();
    titleController.text = widget._eventTitle;
    descriptionController.text = widget._eventDescription;
    goalController.text = widget._eventGoals;
    if (titleController.text != '') {
      title = titleController.text;
    }
  }

  Widget build(BuildContext context) {
    setDefaultPreTask();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: defaultAppBar(title, context),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
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
                      widget._eventStartTime.toPersianDateStr(),
                      textDirection: TextDirection.rtl,
                      style: eventDialogDefaultStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ColoredButton(
                      icon: removeIcon,
                      onTap: () {
                        setState(() {
                          widget._eventStartTime = widget._eventStartTime
                              .subtract(Duration(
                                  minutes:
                                      Hive.box('Calendar').get('timeStep')));
                        });
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          widget._eventStartTime.hour
                              .toString()
                              .toPersianDigit(),
                          style: eventDialogDefaultStyle,
                        ),
                        Text(":", style: eventDialogDefaultStyle),
                        Text(
                          widget._eventStartTime.minute
                              .toString()
                              .toPersianDigit(),
                          style: eventDialogDefaultStyle,
                        )
                      ],
                    ),
                    ColoredButton(
                      icon: addIcon,
                      onTap: () {
                        setState(() {
                          DateTime newStartTime = widget._eventStartTime.add(
                              Duration(
                                  minutes:
                                      Hive.box('Calendar').get('timeStep')));
                          if (newStartTime.isBefore(widget._eventFinishTime)) {
                            widget._eventStartTime = newStartTime;
                          }
                        });
                      },
                    ),
                    SizedBox(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Center(
                        child: FittedBox(
                          child:
                              Text('زمان شروع', style: eventDialogDefaultStyle),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ColoredButton(
                      icon: removeIcon,
                      onTap: () {
                        setState(() {
                          DateTime newFinishTime = widget._eventFinishTime
                              .subtract(Duration(
                                  minutes:
                                      Hive.box('Calendar').get('timeStep')));
                          if (newFinishTime.isAfter(widget._eventStartTime)) {
                            widget._eventFinishTime = newFinishTime;
                          }
                        });
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          widget._eventFinishTime.hour
                              .toString()
                              .toPersianDigit(),
                          style: eventDialogDefaultStyle,
                        ),
                        Text(":", style: eventDialogDefaultStyle),
                        Text(
                          widget._eventFinishTime.minute
                              .toString()
                              .toPersianDigit(),
                          style: eventDialogDefaultStyle,
                        )
                      ],
                    ),
                    ColoredButton(
                      icon: addIcon,
                      onTap: () {
                        setState(() {
                          widget._eventFinishTime = widget._eventFinishTime.add(
                              Duration(
                                  minutes:
                                      Hive.box('Calendar').get('timeStep')));
                        });
                      },
                    ),
                    SizedBox(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Center(
                        child: FittedBox(
                          child: Text('زمان پایان',
                              style: eventDialogDefaultStyle),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              widget.event != null
                  ? Container()
                  : SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: DropdownButtonFormField<PreTask>(
                              alignment: Alignment.centerRight,
                              // decoration: InputDecoration(
                              //   enabledBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(5),
                              //     borderSide:
                              //         BorderSide(width: 2, color: Colors.black),
                              //   ),
                              // ),
                              menuMaxHeight: 200,
                              style: eventDialogDefaultStyle,
                              value: preTaskValue,
                              onChanged: (PreTask? newValue) {
                                setState(() {
                                  preTaskValue = newValue;
                                  if (newValue != null) {
                                    titleController.text = newValue.title;
                                    descriptionController.text =
                                        newValue.description;
                                  }
                                });
                              },
                              items: preTaskListMenu(),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: DropdownButtonFormField<String>(
                              // decoration: InputDecoration(
                              //   enabledBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(5),
                              //     borderSide:
                              //         BorderSide(width: 2, color: Colors.black),
                              //   ),
                              // ),
                              style: eventDialogDefaultStyle,
                              value: boxListMenuValue,
                              onChanged: (String? newValue) {
                                setDefaultPreTask();
                                setState(() {
                                  boxListMenuValue = newValue!;
                                });
                              },
                              items: boxListMenu(),
                            ),
                          ),
                          Text(
                            'انتخاب از لیست ها: ',
                            textDirection: TextDirection.rtl,
                            style: eventDialogDefaultStyle,
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
              Padding(padding: EdgeInsets.only(top: 10)),
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
              icon: closeIcon,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          widget._canDelete
              ? Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ColoredButton(
                    icon: deleteIcon,
                    onTap: () {
                      deleteEvent(widget.event.id);
                      Navigator.pop(context);
                    },
                  ),
                )
              : Padding(padding: EdgeInsets.zero),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: ColoredButton(
              icon: sendIcon,
              onTap: () {
                if (titleController.text == '') {
                  isValid.value = 0;
                } else {
                  isValid.value = 1;
                  if (widget.event == null) {
                    addEvent(
                      titleController.text,
                      widget._eventStartTime,
                      widget._eventFinishTime,
                      descriptionController.text,
                      goalController.text,
                      0,
                    );
                    Navigator.pop(context);
                  } else if (widget.event != null) {
                    updateEvent(
                      widget.event,
                      id: widget.event.id,
                      description: descriptionController.text,
                      title: titleController.text,
                      goals: goalController.text,
                      startDate: widget._eventStartTime,
                      finishDate: widget._eventFinishTime,
                    );
                    Navigator.pop(context);
                  }
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
