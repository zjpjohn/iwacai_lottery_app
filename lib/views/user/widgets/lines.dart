import 'package:flutter/material.dart';

class VLine extends StatelessWidget {
  const VLine({
    Key? key,
    this.width = 1.0,
    this.height = 5.0,
    this.color = Colors.black,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final double height;
  final double width;
  final Color color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(color: color),
        ),
      ),
    );
  }
}
