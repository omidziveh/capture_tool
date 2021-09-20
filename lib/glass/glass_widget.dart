import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class Glass extends StatefulWidget {
  final double height;
  final double width;
  final Widget child;

  Glass({
    required this.height,
    required this.width,
    required this.child,
  });

  @override
  _GlassState createState() => _GlassState();
}

class _GlassState extends State<Glass> {
  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: widget.width,
      height: widget.height,
      borderRadius: 15,
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
        child: widget.child,
      ),
    );
  }
}
