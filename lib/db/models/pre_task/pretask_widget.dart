import 'package:capture_tool/db/models/pre_task/pretask.dart';
import 'package:capture_tool/db/models/pre_task/pretask_db.dart';
import 'package:capture_tool/pages/Capture_Tool/dialogs.dart';
import 'package:capture_tool/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';

class ShowTile extends StatelessWidget {
  PreTask preTask;
  Box box;
  ShowTile(this.preTask, this.box);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPreTaskBottomSheet(context,
            mode: this.preTask.state, preTask: this.preTask);
      },
      child: Container(
        color: Colors.white,
        child: tile(
          title: this.preTask.title,
          importance: this.preTask.importance,
          actions: [deleteOption(preTask, box)],
          secondActions: [weekOption(preTask, box)],
        ),
      ),
    );
  }
}

Widget tile({
  title,
  importance,
  List<Widget>? actions,
  List<Widget>? secondActions,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
    child: Slidable(
      actionExtentRatio: 1 / 6,
      actionPane: SlidableBehindActionPane(),
      actions: actions,
      secondaryActions: secondActions,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(title, style: captureToolPreTaskTitle),
          Spacer(),
          importance > 0 ? activeImportanceIcon : deactiveImportanceIcon,
          importance > 1 ? activeImportanceIcon : deactiveImportanceIcon,
          importance > 2 ? activeImportanceIcon : deactiveImportanceIcon,
        ],
      ),
    ),
  );
}

class PreTaskOption extends StatelessWidget {
  PreTask preTask;
  Color color;
  Icon icon;
  Function() onTap;
  PreTaskOption(
    this.preTask,
    this.color,
    this.icon,
    this.onTap,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: this.color,
        ),
        child: Center(
          child: IconButton(
            icon: this.icon,
            splashColor: Colors.transparent,
            onPressed: this.onTap(),
          ),
        ),
      ),
    );
  }
}

Widget deleteOption(PreTask preTask, Box startBox) {
  return PreTaskOption(
    preTask,
    Colors.red,
    Icon(Icons.delete),
    () {
      delete_pretask(preTask.id, startBox);
    },
  );
}

Widget monthOption(PreTask preTask, Box startBox) {
  return PreTaskOption(
    preTask,
    Colors.blue,
    Icon(Icons.archive_outlined),
    () {
      go_to_monthly(preTask.id, startBox);
    },
  );
}

Widget weekOption(PreTask preTask, Box startBox) {
  return PreTaskOption(
    preTask,
    Colors.green,
    Icon(Icons.pending_actions_rounded),
    () {
      go_to_weekly(preTask.id, startBox);
    },
  );
}

Widget captureOption(PreTask preTask, Box startBox) {
  return PreTaskOption(
    preTask,
    Colors.green,
    Icon(Icons.toc_rounded),
    () {
      go_to_weekly(preTask.id, startBox);
    },
  );
}
