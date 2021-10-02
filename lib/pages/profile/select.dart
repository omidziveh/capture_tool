import 'package:flutter/material.dart';

import '../../style.dart';

class SelectWidget extends StatefulWidget {
  final List<String> names;
  final Function onChanged;
  var value;

  SelectWidget({
    required this.names,
    required this.onChanged,
    this.value = 0,
  });

  @override
  _SelectWidgetState createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.names.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            if (index != widget.value) {
              setState(() {
                widget.value = index;
              });
              widget.onChanged(index);
            }
          },
          child: Container(
            height: 60,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(left: 10)),
                widget.value == index
                    ? Icon(
                        Icons.check_box,
                        color: Colors.black,
                      )
                    : Icon(
                        Icons.check_box_outline_blank_rounded,
                        color: Colors.black,
                      ),
                Spacer(),
                Text(
                  widget.names[index],
                  style: selectTextStyle,
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
              ],
            ),
          ),
        );
      },
    );
  }
}
