import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
            return ListView.builder(
              itemCount: Hive.box('ID').get('id'),
              itemBuilder: (BuildContext context, int index) {
                return Hive.box('preTasks').getAt(index).showTile(context);
              },
            );
          },
        ),
      ),
    );
  }
}
