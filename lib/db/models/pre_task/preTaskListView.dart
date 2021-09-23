import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'pretask_widget.dart';
import '../../../pages/Capture_Tool/dialogs.dart';

class PreTaskListView extends StatefulWidget {
  Box box;
  PreTaskListView(this.box);

  @override
  State<PreTaskListView> createState() => _PreTaskListViewState();
}

class _PreTaskListViewState extends State<PreTaskListView> {
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
          valueListenable: widget.box.listenable(),
          builder: (context, val, _) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: widget.box.length + 1,
              itemBuilder: (BuildContext context, int index) {
                /// Get all pre tasks with 'Capture tool' state:
                if (index == widget.box.length) {
                  return Container(
                    height: 100,
                  );
                }
                var item = widget.box.getAt(index);
                return showTile(context, item, widget.box);
              },
            );
          },
        ),
      ),
    );
  }
}
