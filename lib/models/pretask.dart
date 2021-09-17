import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../style.dart';
import '../pages/Capture_Tool/dialogs.dart';

part 'pretask.g.dart';

@HiveType(typeId: 0)
class PreTask {
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  int importance;

  PreTask({
    required this.name,
    required this.description,
    required this.importance,
  });

  Widget showTile(BuildContext buildContext) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Slidable(
          actions: [
            IconSlideAction(
              caption: 'حذف',
              color: Colors.red,
              icon: Icons.remove,
            ),
          ],
          secondaryActions: [
            IconSlideAction(
              caption: 'هفتگی',
              color: Colors.green,
              icon: Icons.pending_actions_sharp,
            ),
            IconSlideAction(
              caption: 'ماهانه',
              color: Colors.blue,
              icon: Icons.calendar_today,
            ),
          ],
          actionPane: SlidableBehindActionPane(),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: buildContext,
                builder: (BuildContext context) {
                  return editTaskDialog(context);
                },
              );
            },
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  this.importance > 0
                      ? activeImportanceIcon
                      : deactiveImportanceIcon,
                  this.importance > 1
                      ? activeImportanceIcon
                      : deactiveImportanceIcon,
                  this.importance > 2
                      ? activeImportanceIcon
                      : deactiveImportanceIcon,
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      this.name,
                      style: captureToolPreTaskTitle,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
