import 'package:capture_tool/pages/Capture_Tool/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassButton extends StatefulWidget {
  final double width;
  final double height;
  final Widget child;
  final double borderRadius;

  GlassButton({
    required this.width,
    required this.height,
    required this.child,
    required this.borderRadius,
  });

  @override
  _GlassButtonState createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  @override
  Widget build(BuildContext context) {
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
        child: widget.child,
      ),
    );
  }
}
