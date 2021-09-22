import 'package:capture_tool/db/models/pre_task/pretask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'pretask_db.dart';
import '../../../style.dart';
import '../../../pages/Capture_Tool/dialogs.dart';

Widget showTile(BuildContext context, var preTask) {
  double tile_height = 70;
  SlidableController _slidableController = SlidableController();
  return StatefulBuilder(builder: (context, setState) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: AnimatedContainer(
        onEnd: () {
          if (tile_height == 0) {
            delete_pretask(preTask.id);
          }
        },
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 2),
          color: Colors.black12,
        ),
        height: tile_height,
        child: Slidable(
          controller: _slidableController,
          movementDuration: Duration(milliseconds: 100),
          actionPane: SlidableBehindActionPane(),
          closeOnScroll: true,
          actions: [
            slideAction(Icons.delete, Colors.red, () {
              setState(() {
                tile_height = 0;
              });
            })
          ],
          secondaryActions: [
            slideAction(Icons.archive_outlined, Colors.blue, () {
              go_to_monthly(preTask.id);
            }),
            slideAction(Icons.pending_actions_rounded, Colors.green, () {
              go_to_weekly(preTask.id);
            })
          ],
          actionExtentRatio: 1 / 6,
          child: GestureDetector(
            onTap: () {
              showPreTaskBottomSheet(context, mode: 2, preTask: preTask);
            },
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
