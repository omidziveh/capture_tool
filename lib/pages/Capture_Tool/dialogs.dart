import 'package:capture_tool/pages/Capture_Tool/textfield.dart';
import 'package:capture_tool/style.dart';
import 'package:capture_tool/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';

import '../../glass/glass_button.dart';
import '../../db/models/pre_task/pretask.dart';
import '../../db/models/pre_task/pretask_db.dart';

double button_size = 40;
ValueNotifier isValid = ValueNotifier(1);

void showPreTaskBottomSheet(BuildContext context, {var preTask, int mode = 1}) {
  TextEditingController _nameController =
      TextEditingController(text: (preTask != null) ? preTask.title : null);
  TextEditingController _descriptionController = TextEditingController(
      text: (preTask != null) ? preTask.description : null);

  FocusNode _nameFocusNode = FocusNode();
  FocusNode _descriptionFocusNode = FocusNode();
  double importance = 0;

  /// 0 : deleting,
  /// 1: adding,
  /// 2: viewing,
  /// 3: updating,
  /// 4: week return view,
  /// 5: month return view

  if (preTask != null) {
    switch (preTask.state) {
      case 0:
        {
          mode = 2;

          /// from Deleted, Open Viewing mode
        }
        break;
      case 1:
        {
          mode = 2;

          /// from Cpture tool, Open Viewing mode
        }
        break;
      case 2:
        {
          mode = 4;

          /// from Weekly return, open Week return menu
        }
        break;
      case 3:
        {
          mode = 5;

          /// from Monthly return, open Month return menu
        }
        break;
    }
  }

  /// Activate keyboard only if Adding mode is active:
  (mode == 1) ? _nameFocusNode.requestFocus() : null;

  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: FittedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5, bottom: 10),
                              child: Text(
                                (preTask == null) ? 'اضافه کردن کار' : 'کار',
                                style: addTaskDialogTitle,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ValueListenableBuilder(
                                valueListenable: isValid,
                                builder: (context, val, _) {
                                  return DefaultTextFormField(
                                    error: isValid.value == 0
                                        ? 'لطفا عنوان را وارد کنید'
                                        : null,
                                    hintText: 'عنوان',
                                    maxLength: 35,
                                    enabled: (mode == 0) ? false : true,
                                    controller: _nameController,
                                    textDeirection: TextDirection.rtl,
                                    focusNode: _nameFocusNode,
                                    onChanged: (String val) {
                                      setState(() {
                                        if (preTask != null) {
                                          if (val != preTask.title) {
                                            mode = 3;

                                            /// Switch to updating state
                                          }
                                          if (val == preTask.title) {
                                            mode = 2;

                                            /// Switch to viewing state
                                          }
                                        }
                                      });
                                    },
                                  );
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DefaultTextFormField(
                            enabled: (mode == 0) ? false : true,
                            focusNode: _descriptionFocusNode,
                            controller: _descriptionController,
                            maxLines: 5,
                            onChanged: (String val) {
                              setState(() {
                                if (preTask != null) {
                                  if (val != preTask.description) {
                                    mode = 3;
                                  }
                                  if (val == preTask.description) {
                                    mode = 2;
                                  }
                                }
                              });
                            },
                            hintText: 'توضیحات',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RatingBar(
                            allowHalfRating: false,
                            direction: Axis.horizontal,
                            glow: false,
                            initialRating:
                                (preTask == null) ? 0.0 : preTask.importance,
                            itemCount: 3,
                            ratingWidget: RatingWidget(
                              empty: Icon(Icons.star_rounded,
                                  color: Colors.black38),
                              full:
                                  Icon(Icons.star_rounded, color: Colors.black),
                              half: Container(),
                            ),
                            onRatingUpdate: (double val) {
                              if (preTask != null) {
                                if (preTask.importance != val) {
                                  mode = 3;
                                }
                                if (preTask.importance == val) {
                                  mode = 2;
                                }
                              }
                              setState(() {
                                importance = val;
                              });
                            },
                          ),
                        ),
                        bottomHandler(
                          context,
                          mode,
                          preTask: preTask,
                          title: _nameController.text,
                          importance: importance,
                          description: _descriptionController.text,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

/// 0 : deleting,  /// NOT IN USE
/// 1: adding,
/// 2: viewing,
/// 3: updating,
/// 4: week return view,
/// 5: month return view

Widget bottomHandler(
  BuildContext context,
  int mode, {
  var preTask,
  var title,
  var description,
  var importance,
}) {
  /// Adding mode  /// Case 1
  if (preTask == null) {
    return addBottom(context, title, description, importance);
  } else {
    switch (mode) {
      case 2:
        {
          return viewBottom(context, preTask);
        }
      case 3:
        {
          return updateBottom(context, preTask,
              title: title, description: description, importance: importance);
        }
      default:
        {
          return Container(
            color: Colors.black,
            height: 100,
          );
        }
    }
  }
}

Widget addBottom(
    BuildContext context, String title, String description, double importance) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      GlassButton(
          width: button_size,
          height: button_size,
          child: IconButton(
            splashColor: Colors.transparent,
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          borderRadius: 15),
      GlassButton(
          width: button_size,
          height: button_size,
          child: IconButton(
            splashColor: Colors.transparent,
            icon: Icon(Icons.send_rounded),
            onPressed: () {
              if (title == '') {
                isValid.value = 0;
              } else {
                isValid.value = 1;
                add_pretask(title, importance, description: description);
                Navigator.pop(context);
              }
            },
          ),
          borderRadius: 15),
    ],
  );
}

Widget viewBottom(
  BuildContext context,
  PreTask preTask,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      GlassButton(
        width: button_size,
        height: button_size,
        child: IconButton(
          splashColor: Colors.transparent,
          icon: Icon(Icons.delete),
          onPressed: () {
            delete_pretask(preTask.id);
            Navigator.pop(context);
          },
        ),
        borderRadius: 15,
      ),
      GlassButton(
          width: button_size,
          height: button_size,
          child: IconButton(
            splashColor: Colors.transparent,
            icon: Icon(Icons.pending_actions_outlined),
            onPressed: () {
              go_to_weekly(preTask.id);
              Navigator.pop(context);
            },
          ),
          borderRadius: 15),
      GlassButton(
          width: button_size,
          height: button_size,
          child: IconButton(
            splashColor: Colors.transparent,
            icon: Icon(Icons.archive_outlined),
            onPressed: () {
              go_to_monthly(preTask.id);
              Navigator.pop(context);
            },
          ),
          borderRadius: 15),
      GlassButton(
          width: button_size,
          height: button_size,
          child: IconButton(
            splashColor: Colors.transparent,
            icon: Icon(Icons.assistant_photo),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          borderRadius: 15),
    ],
  );
}

Widget updateBottom(BuildContext context, PreTask preTask,
    {title, description, importance}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      GlassButton(
        width: button_size,
        height: button_size,
        child: IconButton(
          splashColor: Colors.transparent,
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        borderRadius: 15,
      ),
      GlassButton(
          width: button_size,
          height: button_size,
          child: IconButton(
            splashColor: Colors.transparent,
            icon: Icon(Icons.done),
            onPressed: () {
              print("Update");
              if (preTask.title == '' || title == '') {
                isValid.value = 0;
              } else {
                isValid.value = 1;
                update_pretask(preTask.id,
                    title: title,
                    description: description,
                    importance: importance);
                Navigator.pop(context);
              }
            },
          ),
          borderRadius: 15),
    ],
  );
}
