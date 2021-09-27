import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:capture_tool/db/models/pre_task/preTaskListView.dart';

class CaptureTool extends StatelessWidget {
  Widget build(BuildContext context) {
    return PreTaskListView(Hive.box('preTasks'));
  }
}
