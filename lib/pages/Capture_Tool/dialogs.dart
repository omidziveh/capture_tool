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

import '../../glass/glass_button.dart';

void showMyBottomSheet(
  BuildContext context,
  String initialName,
  String initialDescription,
  int initialImportance,
) {
  TextEditingController _nameController =
      TextEditingController(text: initialName);
  TextEditingController _descriptionController =
      TextEditingController(text: initialDescription);
  final _formKey = GlobalKey<FormState>();
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _descriptionFocusNode = FocusNode();
  _nameFocusNode.requestFocus();
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Form(
            key: _formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: Text(
                          'اضافه کردن کار',
                          style: addTaskDialogTitle,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onFieldSubmitted: (_) {
                          _nameFocusNode.unfocus();
                          _descriptionFocusNode.requestFocus();
                        },
                        focusNode: _nameFocusNode,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        controller: _nameController,
                        cursorColor: Colors.black,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'لطفا عنوانی انتخاب کنید';
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        focusNode: _descriptionFocusNode,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        controller: _descriptionController,
                        cursorColor: Colors.black,
                        maxLines: 5,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBar(
                          allowHalfRating: false,
                          direction: Axis.horizontal,
                          glow: false,
                          itemCount: 3,
                          ratingWidget: RatingWidget(
                            empty:
                                Icon(Icons.star_rounded, color: Colors.black38),
                            full: Icon(Icons.star_rounded, color: Colors.black),
                            half: Container(),
                          ),
                          onRatingUpdate: (double val) {
                            print(val);
                          },
                        ),
                        GlassButton(
                          width: 70,
                          height: 70,
                          child: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context);
                              }
                            },
                            splashColor: Colors.transparent,
                          ),
                          borderRadius: 15,
                        ),
                      ],
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
}
