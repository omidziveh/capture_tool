import 'dart:developer';

import 'package:flutter/material.dart';
import  'package:persian_number_utility/persian_number_utility.dart';

class CalendarPage extends StatelessWidget {
  final DateTime startDate;

  CalendarPage({required this.startDate});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('شهریور'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
              child: SizedBox(
                height: 30,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 7) {
                      return Container();
                    } return Container(
                      child: Center(
                        child: Text('$startDate')
                      ),
                    );
                  },
                ),
              ),
          ),
        ),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
            itemBuilder: (BuildContext context, int index) {
              if (index % 8 == 7) {
                return Padding(
                  padding: EdgeInsets.all(2.5),
                  child: Container(
                    child: Align(
                      child: Text('hello'),
                    ),
                  ),
                );
              } return Padding(
                padding: EdgeInsets.all(2.5),
                child: Container(
                  child: Center(child: Text('$index')),
                ),
              );
            },
          ),
        ),
    );
  }
}

