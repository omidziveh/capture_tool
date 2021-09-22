import 'package:capture_tool/db/models/pre_task/preTaskListView.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CaptureTool extends StatelessWidget {
  const CaptureTool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreTaskListView(Hive.box('preTasks'));
  }
}
