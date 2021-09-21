import 'package:flutter/material.dart';
import 'style.dart';

AppBar defaultAppBar(String title, BuildContext context) {
  return AppBar(
    centerTitle: false,
    elevation: 0,
    backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Text(title, style: AppBarTextStyle),
          ),
          Container(
            height: 5,
            color: Colors.black,
          ),
        ],
      ),
    ),
  );
}
