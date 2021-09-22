import 'package:capture_tool/default_appbar.dart';
import 'package:capture_tool/glass/glass_button.dart';
import 'package:capture_tool/db/models/pre_task/preTaskListView.dart';
import 'package:capture_tool/pages/week_return.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MonthReturn extends StatelessWidget {
  final bool isFromMonthly;

  MonthReturn([this.isFromMonthly = false]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar('بازگشت ماهانه', context),
      body: PreTaskListView(
        Hive.box('monthlyReturn'),
        3,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GlassButton(
              width: 70,
              height: 70,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                ),
                splashColor: Colors.transparent,
              ),
              borderRadius: 15),
          Padding(padding: EdgeInsets.only(left: 10)),
          GlassButton(
            width: 70,
            height: 70,
            child: IconButton(
              onPressed: () {
                if (!this.isFromMonthly) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WeekReturn(true)));
                } else {
                  Navigator.pop(context);
                }
              },
              icon: Icon(Icons.pending_actions_rounded),
              color: Colors.black,
              splashColor: Colors.transparent,
            ),
            borderRadius: 15,
          ),
        ],
      ),
    );
  }
}
