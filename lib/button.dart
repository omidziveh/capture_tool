import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  final Color color;
  final double radius;
  final double size;
  final Icon icon;
  final Function() onTap;

  ColoredButton({
    required this.icon,
    required this.onTap,
    this.color = const Color.fromRGBO(200, 200, 200, 0.9),
    this.radius = 15,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        height: this.size,
        width: this.size,
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.circular(this.radius),
        ),
        child: this.icon,
      ),
    );
  }
}
