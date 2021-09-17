import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'dialogs.dart';

class CaptureTool extends StatelessWidget {
  const CaptureTool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.white,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return captureToolDialog(context);
              });
        },
      ),
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
