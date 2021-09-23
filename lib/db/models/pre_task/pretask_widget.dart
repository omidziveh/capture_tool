import 'package:capture_tool/db/models/pre_task/pretask.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'pretask_db.dart';
import '../../../style.dart';
import '../../../pages/Capture_Tool/dialogs.dart';

Widget showTile(BuildContext context, var preTask, [Box? startBox]) {
  startBox ??= Hive.box('preTasks');
  return StatefulBuilder(builder: (context, setState) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Dismissible(
        movementDuration: Duration(milliseconds: 500),
        secondaryBackground: Card(),
        onDismissed: (DismissDirection direction) {
          setState(() {
            print(direction.index);
            if (direction.index == 3) {
              delete_pretask(preTask.id);
            } else if (direction.index == 2) {
              done_pretask(preTask.id);
            }
          });
        },
        background: Container(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.red[900]),
                width: 50,
                child: IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    delete_pretask(preTask.id);
                  },
                ),
              ),
            ),
          ),
        ),
        key: ValueKey('dismissible'),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 70,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                preTask.importance > 0
                    ? activeImportanceIcon
                    : deactiveImportanceIcon,
                preTask.importance > 1
                    ? activeImportanceIcon
                    : deactiveImportanceIcon,
                preTask.importance > 2
                    ? activeImportanceIcon
                    : deactiveImportanceIcon,
                Spacer(),
                FittedBox(
                    child: Text(
                  preTask.title,
                  style: captureToolPreTaskTitle,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  });
}

Widget slideAction(icon, color, onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      color: color,
      child: Center(
        child: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    ),
  );
}
