import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCustomButton extends StatelessWidget {
  const MyCustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.fontWeight,
    this.height,
    this.width,
    this.borderRadius,
    this.splashColor,
    this.gradient,
    this.boxShadow,
    this.elevation,
    this.backgroundColor,
    this.border,

    this.fontSize
  });

  final VoidCallback onPressed;
  final String text;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final double? elevation;
  final Color? splashColor;
  final Color? backgroundColor;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final FontWeight? fontWeight;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: elevation ?? 0,
      child: InkWell(
        splashColor: splashColor,
        borderRadius: borderRadius,
        onTap: onPressed,
        child: Container(
          height: height ?? 50,
          width: width ?? 150,
          decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0xff005AFF),
            borderRadius: borderRadius,
            boxShadow: boxShadow,
            gradient: gradient,
            border: border,
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  textStyle:  TextStyle(
                      color: Colors.white,
                      fontWeight: fontWeight ?? FontWeight.w400,
                      fontSize: fontSize ?? 16.0)),
            ),
          ),
        ),
      ),
    );
  }
}
