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
    this.line = 1,
    this.isMultyline = false,
    this.required = false,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? fontColor;
  final TextAlign? textAlign;
  final bool required;
  final int line;
  final bool isMultyline;

  @override
  Widget build(BuildContext context) {
    return required
        ? RichText(
          maxLines: line,
            textAlign: textAlign ?? TextAlign.right,
      overflow: TextOverflow.ellipsis,
            text: TextSpan(
                text: text,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: fontColor ?? Colors.black.withOpacity(0.4),
                    fontWeight: fontWeight,
                    fontSize: fontSize,
                )),
                children: [
                  TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: fontWeight,
                        fontSize: fontSize,
                      ))
                ]),
          )
        : RichText(
          maxLines: line,
            textAlign: textAlign ?? TextAlign.right,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: text,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: fontColor ?? Colors.black.withOpacity(0.4),
                fontWeight: fontWeight,
                fontSize: fontSize,
              )),
              children: [
                  TextSpan(
                      text: ' ',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: fontWeight,
                        fontSize: fontSize,
                      )
                  )
                ]
            ),
          );
  }
}
