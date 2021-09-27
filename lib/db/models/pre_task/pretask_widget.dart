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
          actions: [
            GestureDetector(
              onTap: () {
                print('tap');
              },
              child: Container(),
            ),
          ],
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
  return Container(
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.black,
        width: 1,
      ),
    ),
    child: Slidable(
      actionExtentRatio: 1 / 6,
      actionPane: SlidableBehindActionPane(),
      actions: actions,
      secondaryActions: secondActions,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                importance > 0 ? activeImportanceIcon : deactiveImportanceIcon,
                importance > 1 ? activeImportanceIcon : deactiveImportanceIcon,
                importance > 2 ? activeImportanceIcon : deactiveImportanceIcon,
                Spacer(),
                Text(
                  title,
                  style: captureToolPreTaskTitle,
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class PreTaskOption extends StatelessWidget {
  Color color;
  IconData icon;
  Function() onTap;
  PreTaskOption(
    this.color,
    this.icon,
    this.onTap,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: IconSlideAction(
          icon: this.icon,
          color: this.color,
          onTap: this.onTap,
        ),
      ),
    );
  }
}

Widget deleteOption(PreTask preTask, Box startBox) {
  return PreTaskOption(
    Colors.red,
    Icons.delete,
    () {
      print('deleted');
      delete_pretask(preTask.id, startBox);
    },
  );
}

Widget monthOption(PreTask preTask, Box startBox) {
  return PreTaskOption(
    Colors.blue,
    Icons.archive_outlined,
    () {
      print('go to monthly');
      go_to_monthly(preTask.id, startBox);
    },
  );
}

Widget weekOption(PreTask preTask, Box startBox) {
  return PreTaskOption(
    Colors.green,
    Icons.pending_actions_rounded,
    () {
      print('go to weekly');
      go_to_weekly(preTask.id, startBox);
    },
  );
}

Widget captureOption(PreTask preTask, Box startBox) {
  return PreTaskOption(
    Colors.green,
    Icons.toc_rounded,
    () {
      go_to_weekly(preTask.id, startBox);
    },
  );
}
