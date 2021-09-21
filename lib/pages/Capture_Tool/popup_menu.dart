import 'package:flutter/material.dart';

class PopupMenu extends StatefulWidget {
  List<Widget> children;
  double height;

  PopupMenu({
    required this.children,
    required this.height,
  });

  @override
  _PopupMenuState createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: widget.height,
      duration: Duration(milliseconds: 200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.children,
      ),
    );
  }
}
