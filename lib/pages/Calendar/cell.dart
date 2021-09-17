import 'package:flutter/material.dart';

class Cell extends StatelessWidget {

  final int index;

  Cell({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(this.index.toString()),
    );
  }
}

