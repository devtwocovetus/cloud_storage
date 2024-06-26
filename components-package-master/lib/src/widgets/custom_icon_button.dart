import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.iconColor,
    required this.iconSize,
    this.height,
    this.width,
    this.borderRadius,
    this.splashColor,
    this.elevation,
    this.boxShadow,
    this.backgroundColor,
    this.shape = BoxShape.rectangle,
    this.padding,
    this.margin,
  }) : super(key: key);

  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final BoxShape shape;
  final List<BoxShadow>? boxShadow;
  final Color? splashColor;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: elevation ?? 0,
      child: Container(
        height: height ?? 40,
        width: width ?? 40,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: shape == BoxShape.circle ? null : borderRadius,
          boxShadow: boxShadow,
          shape: shape,
        ),
        child: InkWell(
          splashColor: splashColor,
          onTap: onTap,
          child: Center(
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
