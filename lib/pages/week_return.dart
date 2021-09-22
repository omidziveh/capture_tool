import 'package:capture_tool/default_appbar.dart';
import 'package:capture_tool/glass/glass_bottom_menu.dart';
import 'package:capture_tool/glass/glass_button.dart';
import 'package:capture_tool/db/models/pre_task/preTaskListView.dart';
import 'package:capture_tool/pages/month_return.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class WeekReturn extends StatelessWidget {
  final bool isFromMonthly;

  WeekReturn([this.isFromMonthly = false]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar('بازگشت هفتگی', context),
      body: PreTaskListView(
        Hive.box('weeklyReturn'),
        2,
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
                          builder: (context) => MonthReturn(true)));
                } else {
                  Navigator.pop(context);
                }
              },
              icon: Icon(Icons.archive_outlined),
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
