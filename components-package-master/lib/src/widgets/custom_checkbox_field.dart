import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCheckBoxField extends StatelessWidget {
  const CustomCheckBoxField({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    this.onChange,
    this.fontColor,
    this.checkedColor,
    this.isChecked,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? fontColor;
  final Color? checkedColor;
  final bool? isChecked;
  final bool Function(bool?)? onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Checkbox(
            checkColor: checkedColor ?? const Color(0xff000C14),
            value: isChecked ?? false,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onChanged: onChange,
          ),
          Text(text,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: fontColor ?? Colors.black.withOpacity(0.4),
                      fontWeight: fontWeight,
                      fontSize: fontSize))),
        ],
      ),
    );
  }
}
