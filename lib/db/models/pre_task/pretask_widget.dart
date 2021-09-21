import 'package:capture_tool/db/models/pre_task/pretask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'pretask_db.dart';
import '../../../style.dart';
import '../../../pages/Capture_Tool/dialogs.dart';

Widget showTile(BuildContext buildContext, var preTask) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Slidable(
        actionExtentRatio: 1 / 6,
        actions: [
          IconSlideAction(
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              delete_pretask(preTask.id);
            },
          ),
        ],
        secondaryActions: [
          IconSlideAction(
            color: Colors.green,
            icon: Icons.pending_actions_sharp,
            onTap: () {
              go_to_weekly(preTask.id);
            },
          ),
          IconSlideAction(
            color: Colors.blue,
            icon: Icons.archive_outlined,
            onTap: () {
              go_to_monthly(preTask.id);
            },
          ),
        ],
        actionPane: SlidableBehindActionPane(),
        closeOnScroll: true,
        showAllActionsThreshold: 0.6,
        child: GestureDetector(
          onTap: () {
            showPreTaskBottomSheet(
              buildContext,
              preTask : preTask
            );
          },
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                preTask?.importance > 0
                    ? activeImportanceIcon
                    : deactiveImportanceIcon,
                preTask?.importance > 1
                    ? activeImportanceIcon
                    : deactiveImportanceIcon,
                preTask?.importance > 2
                    ? activeImportanceIcon
                    : deactiveImportanceIcon,
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    preTask?.title,
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


allpreTasks(BuildContext context){
  var pre_tasks = all_pre_tasks();
  for (int i = 0; i< pre_tasks.length; i ++){

  }
}