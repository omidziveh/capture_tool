import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../db/models/pre_task/pretask_widget.dart';
import 'dialogs.dart';

class CaptureTool extends StatefulWidget {
  @override
  State<CaptureTool> createState() => _CaptureToolState();
}

class _CaptureToolState extends State<CaptureTool> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode myFocusNode = FocusNode();

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: Hive.box('preTasks').listenable(),
          builder: (context, val, _) {
            print('Number of Pretasks: ${Hive.box('preTasks').length}');
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: Hive.box('preTasks').length,
              itemBuilder: (BuildContext context, int index) {

                /// Get all pre tasks with 'Capture tool' state:
                var item = Hive.box('preTasks').getAt(index);
                if (item.state == 1){
                  return showTile(context, item);
                } else {return Container();}
              },
            );
          },
        ),
      ),
    );
  }
}
