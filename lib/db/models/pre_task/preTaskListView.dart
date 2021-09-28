import 'package:capture_tool/db/models/pre_task/pretask_widget.dart';
import 'package:capture_tool/style.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PreTaskListView extends StatelessWidget {
  Box box;
  PreTaskListView(
    this.box,
  );
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: this.box.listenable(),
        builder: (context, val, _) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                if (index == this.box.length) {
                  return Container(
                    height: 100,
                  );
                }
                return ShowTile(
                  this.box.getAt(index),
                  this.box,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.black,
                  thickness: 1,
                );
              },
              itemCount: this.box.length + 1,
            ),
          );
        });
  }
}
