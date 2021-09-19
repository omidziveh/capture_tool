import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassBottomMenu extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final List<IconData> icons;
  final List<String> titles;
  final Color selectedColor;
  final Color unselectedColor;
  final int startIndex;
  Function(int) onChange;

  GlassBottomMenu({
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.icons,
    required this.selectedColor,
    required this.unselectedColor,
    required this.onChange,
    required this.startIndex,
    required this.titles,
  });

  @override
  State<StatefulWidget> createState() {
    return _GlassBottomMenuState();
  }
}

class _GlassBottomMenuState extends State<GlassBottomMenu> {
  ValueNotifier<int> _index = ValueNotifier<int>(1);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _index,
        builder: (context, val, _) {
          print(_index);
          return GlassmorphicContainer(
            width: widget.width,
            height: widget.height,
            borderRadius: widget.borderRadius,
            linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(200, 200, 200, 0.3),
                  Color.fromRGBO(200, 200, 200, 0.3),
                ],
                stops: [
                  0.1,
                  1,
                ]),
            border: 0,
            blur: 20,
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFffffff).withOpacity(0.5),
                Color((0xFFFFFFFF)).withOpacity(0.5),
              ],
            ),
            child: Center(
              child: Align(
                alignment: Alignment.center,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.icons.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Tooltip(
                      message: widget.titles[index],
                      child: IconButton(
                        splashColor: Colors.transparent,
                        icon: Icon(
                          widget.icons[index],
                          color: index == _index.value
                              ? widget.selectedColor
                              : widget.unselectedColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _index.value = index;
                            widget.onChange(_index.value);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
