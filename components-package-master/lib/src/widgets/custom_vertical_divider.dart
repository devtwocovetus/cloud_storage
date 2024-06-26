import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({
    Key? key,
    this.width = 1,
    this.height = 16,
    this.color = Colors.black,
    this.margin,
    this.padding,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      color: color,
    );
  }
}
