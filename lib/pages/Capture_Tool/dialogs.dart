import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';

import '../../style.dart';
import '../../validators.dart';
import '../../models/pretask.dart';

Widget captureToolDialog(context) {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  int importance = 0;
  final _formKey = GlobalKey<FormState>();
  return Container(
    height: MediaQuery.of(context).size.height * 0.6,
    width: MediaQuery.of(context).size.width * 0.7,
    child: AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          textDirection: TextDirection.rtl,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                'اضافه کردن کار',
                style: addTaskDialogTitle,
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),

            ///TextField for naming the task
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nameController,
                    validator: taskNameValidator,
                    style: addTaskDialogTextField,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    autofocus: true,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      errorStyle: addTaskDialogError,
                      hintText: 'عنوان',
                      contentPadding: EdgeInsets.only(
                          left: 10, right: 10, top: 2, bottom: 2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            ///TextField for add description to task
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.zero,
                child: TextFormField(
                  controller: _descriptionController,
                  style: addTaskDialogTextField,
                  maxLines: 3,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  autofocus: true,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'توضیحات',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 0, style: BorderStyle.none),
                    ),
                  ),
                ),
              ),
            ),

            /// Rating bar for adding task
            Padding(
              padding: EdgeInsets.all(6),
              child: StatefulBuilder(
                builder: (BuildContext context, Function setState) {
                  return RatingBar.builder(
                    allowHalfRating: false,
                    direction: Axis.horizontal,
                    glow: false,
                    itemCount: 3,
                    onRatingUpdate: (double val) {
                      print(importance);
                      setState(() {
                        importance = val.round();
                      });
                    },
                    itemBuilder: (context, _) {
                      return Icon(
                        Icons.star_rounded,
                        color: Colors.black,
                      );
                    },
                  );
                },
              ),
            ),

            /// submit button for adding task
            Padding(
              padding: EdgeInsets.all(7),
              child: Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    print(Hive.box('ID').get('id'));
                    if (_formKey.currentState!.validate()) {
                      Hive.box('preTasks').put(
                        Hive.box('ID').get('id'),
                        PreTask(
                          name: _nameController.text,
                          description: _descriptionController.text,
                          importance: importance,
                        ),
                      );
                      Hive.box('ID').put(
                        'id',
                        Hive.box('ID').get('id') + 1,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'اضافه کن',
                    style: addTaskDialogButton,
                  ),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget editTaskDialog(context) {
  return captureToolDialog(context).createElement().widget;
}
