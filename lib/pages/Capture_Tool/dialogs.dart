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

import 'package:capture_tool/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';

import '../../glass/glass_button.dart';
import '../../db/models/pre_task/pretask.dart';
import '../../db/models/pre_task/pretask_db.dart';

final formKey = GlobalKey<FormState>();

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
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
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
                          child: TextFormField(
                            maxLength: 35,
                            enabled: (mode == 0) ? false : true,

                            /// disabled on deleted pretasks
                            onFieldSubmitted: (_) {
                              _nameFocusNode.unfocus();
                              _descriptionFocusNode.requestFocus();
                            },
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
                            focusNode: _nameFocusNode,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            controller: _nameController,
                            cursorColor: Colors.black,
                            validator: (var value) {
                              if (value == '') {
                                return 'لطفا عنوان را وارد کنید.';
                              }
                            },
                            style: addTaskDialogTextField,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusColor: Colors.black,
                              hintStyle: hintStyle,
                              hintText: 'عنوان',
                              errorStyle: addTaskDialogError,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          enabled: (mode == 0) ? false : true,

                          /// disabled on deleted pretasks

                          focusNode: _descriptionFocusNode,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          controller: _descriptionController,
                          cursorColor: Colors.black,
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
                          style: addTaskDialogTextField,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusColor: Colors.black,
                            hintStyle: hintStyle,
                            hintText: 'توضیحات',
                          ),
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
                            empty:
                                Icon(Icons.star_rounded, color: Colors.black38),
                            full: Icon(Icons.star_rounded, color: Colors.black),
                            half: Container(),
                          ),
                          onRatingUpdate: (double val) {
                            if (preTask != null){
                              if (preTask.importance != val){
                                mode = 3;
                              }
                              if (preTask.importance == val){
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
    children: [
      GlassButton(
          width: 40,
          height: 40,
          child: IconButton(
            splashColor: Colors.transparent,
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          borderRadius: 15),
      Spacer(),
      GlassButton(
          width: 40,
          height: 40,
          child: IconButton(
            splashColor: Colors.transparent,
            icon: Icon(Icons.send_rounded),
            onPressed: () {
              if (formKey.currentState!.validate()){
                print('Added');
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
    children: [
      GlassButton(
          width: 40,
          height: 40,
          child: IconButton(
            splashColor: Colors.transparent,
            icon: Icon(Icons.delete),
            onPressed: () {
              delete_pretask(preTask.id);
              Navigator.pop(context);
            },
          ),
          borderRadius: 15),
      Spacer(),
      GlassButton(
          width: 40,
          height: 40,
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
          width: 40,
          height: 40,
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
          width: 40,
          height: 40,
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
    children: [
      GlassButton(
          width: 40,
          height: 40,
          child: IconButton(
            splashColor: Colors.transparent,
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          borderRadius: 15),
      Spacer(),
      GlassButton(
          width: 40,
          height: 40,
          child: IconButton(
            splashColor: Colors.transparent,
            icon: Icon(Icons.done),
            onPressed: () {
              print("Update");
              update_pretask(preTask.id,
                  title: title,
                  description: description,
                  importance: importance);
              Navigator.pop(context);
            },
          ),
          borderRadius: 15),
    ],
  );
}
