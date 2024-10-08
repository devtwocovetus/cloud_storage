import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MyCustomButton extends StatelessWidget {
  const MyCustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.padding,
    this.fontWeight,
    this.height,
    this.width,
    this.borderRadius,
    this.splashColor,
    this.gradient,
    this.boxShadow,
    this.elevation,
    this.backgroundColor,
    this.textColor,
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
  final Color? textColor;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: elevation ?? 0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(padding ?? 0, 0,padding ?? 0, 0),
        child: InkWell(
          splashColor: splashColor,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: backgroundColor ?? const Color(0xff005AFF),
              borderRadius: borderRadius,
              boxShadow: boxShadow,
              gradient: gradient,
              border: border,
            ),
            child: Center(
              child: AutoSizeText(
                text,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                minFontSize: 8,
                style: GoogleFonts.poppins(
                    textStyle:  TextStyle(
                        color:textColor ?? Colors.white,
                        fontWeight: fontWeight ?? FontWeight.w400,
                        fontSize: fontSize ?? 16.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
