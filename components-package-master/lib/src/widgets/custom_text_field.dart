import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    this.fontColor,
    this.textAlign,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? fontColor;
  final TextAlign? textAlign;


  @override
  Widget build(BuildContext context) {
    return Text(text,
    textAlign:textAlign ?? TextAlign.right,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: fontColor ?? Colors.black.withOpacity(0.4),
                fontWeight: fontWeight,
                fontSize: fontSize)));
  }
}
