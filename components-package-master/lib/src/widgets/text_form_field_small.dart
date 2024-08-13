import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/src/colors/app_color.dart';

class TextFormFieldSmall extends StatelessWidget {
  const TextFormFieldSmall({
    super.key,
    required this.hint,
    required this.controller,
    this.textCapitalization,
    required this.keyboardType,
    required this.buttonText,
    this.autofocus = false,
    this.errorTextPresent = false,
    this.enabled,
    this.readOnly = false,
    this.isRequired = true,
    this.backgroundColor,
    this.suffixIcon,
    this.focusNode,
    this.hintStyle,
    this.obscure,
    this.validating,
    this.onSubmit,
    this.onEditingComplete,
    this.onChanged,
    this.prefixIcon,
    this.height,
    this.width,
    this.contentPadding,
    this.boxShadow,
    this.suffixIconColor,
    this.prefixIconColor,
    this.border,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.errorBorderColor,
    this.style,
    this.cursorColor,
    this.focusedBorderWidth,
    this.enabledBorderWidth,
    this.errorBorderWidth,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.borderRadius,
    this.textFieldBorder,
    this.minLines,
    this.maxLines,
    this.inputFormatters,
    this.padding = 0.0,
    this.focusedErrorBorder = InputBorder.none,
    InputDecoration? decoration,
  });

  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final bool? enabled;
  final bool readOnly;
  final FocusNode? focusNode;
  final String hint;
  final String buttonText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final bool? obscure;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final TextEditingController controller;
  final TextCapitalization? textCapitalization;
  final String? Function(String?)? validating;
  final TextInputType keyboardType;
  final void Function(String)? onSubmit;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final BoxBorder? border;
  final InputBorder? focusedBorder;
  final Color? focusedBorderColor;
  final double? focusedBorderWidth;
  final InputBorder? enabledBorder;
  final Color? enabledBorderColor;
  final double? enabledBorderWidth;
  final InputBorder? errorBorder;
  final Color? errorBorderColor;
  final double? errorBorderWidth;
  final Color? cursorColor;
  final EdgeInsetsGeometry? contentPadding;
  final List<BoxShadow>? boxShadow;
  final InputBorder? textFieldBorder;
  final InputBorder? focusedErrorBorder;
  final int? minLines;
  final int? maxLines;
  final bool errorTextPresent;
  final double padding;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      color: Colors.white,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        focusNode: focusNode,
        style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14.0)),
        validator: validating,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          NoLeadingDecimalFormatter(),
          FilteringTextInputFormatter.allow(RegExp("[0-9.-]")),
          NoExtraDecimalFormatter(),
        ],
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(12, 5, 12, 0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color(0xFFE0E0E0), width: 0.1)),
          fillColor: Colors.white,
          filled: true,
          errorStyle: const TextStyle(
            color: kAppError,
          ),
          suffixIcon: Container(
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(width: 0.5, color: Colors.grey),
              ),
            ),
            child: Wrap(
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              direction: Axis.horizontal,
              children: [
                Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0)),
                )
              ],
            ),
          ),
          hintText: hint,
          enabledBorder:
              buildOutlineInputBorder(Colors.black.withOpacity(0.4), 1),
          focusedBorder: buildOutlineInputBorder(kAppPrimary, 1),
          errorBorder: buildOutlineInputBorder(kAppError, 1),
          focusedErrorBorder: buildOutlineInputBorder(kAppPrimary, 1),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color color, double width) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
      borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(10)),
    );
  }
}

class NoLeadingDecimalFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.startsWith('.') || newValue.text.startsWith('..')
        || newValue.text.startsWith('...') || newValue.text.startsWith('....')) {
      final String trimmedText;

      if(newValue.text.startsWith('..')){
        trimmedText = newValue.text.substring(2);
      }else if(newValue.text.startsWith('...')){
        trimmedText = newValue.text.substring(3);
      }else if(newValue.text.startsWith('....')){
        trimmedText = newValue.text.substring(4);
      } else{
        trimmedText = newValue.text.substring(1);
      }

      return TextEditingValue(
        text: trimmedText,
        selection: TextSelection(
          baseOffset: trimmedText.length,
          extentOffset: trimmedText.length,
        ),
      );
    }
    return newValue;
  }
}

class NoExtraDecimalFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.contains('..') || newValue.text.contains('...') || newValue.text.contains('....')) {
      final String newText;

      if(newValue.text.contains('...')){
        newText = newValue.text.replaceAll('...', '.');
      }else if(newValue.text.contains('....')){
        newText = newValue.text.replaceAll('....', '.');
      }else{
        newText = newValue.text.replaceAll('..', '.');
      }
      return TextEditingValue(
        text: newText,
        selection: TextSelection(
          baseOffset: newText.length,
          extentOffset: newText.length,
        ),
      );
    }
    return newValue;
  }
}
