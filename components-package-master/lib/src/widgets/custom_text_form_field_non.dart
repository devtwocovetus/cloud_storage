import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormFieldNon extends StatelessWidget {
  const CustomTextFormFieldNon({
    super.key,
    required this.hint,
    required this.controller,
    required this.textCapitalization,
    required this.keyboardType,
    this.autofocus = false,
    this.enabled,
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
    required this.height,
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
    this.focusedErrorBorder = InputBorder.none,
  });

  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final bool? enabled;
  final FocusNode? focusNode;
  final String hint;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final bool? obscure;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Center(
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          autofocus: autofocus,
          enabled: enabled,
          controller: controller,
          focusNode: focusNode,
          inputFormatters: inputFormatters ?? [],
          validator: validating,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            isDense: false,
            border: textFieldBorder,
            suffixIcon: suffixIcon,
            suffixIconColor: suffixIconColor,
            prefixIcon: prefixIcon,
            prefixIconColor: prefixIconColor,
            hintText: hint,
            hintStyle: hintStyle,
                  enabledBorder: enabledBorder ??
                buildOutlineInputBorder(
                  enabledBorderColor ?? Color(0xffD0D5DD),
                  enabledBorderWidth ?? 1,
                ),
            focusedBorder: focusedBorder ??
                buildOutlineInputBorder(
                  focusedBorderColor ?? const Color(0xffD0D5DD),
                  focusedBorderWidth ?? 1,
                ),
            errorBorder: errorBorder ??
                buildOutlineInputBorder(
                  errorBorderColor ?? Color(0xffD0D5DD),
                  errorBorderWidth ?? 1,
                ),
            focusedErrorBorder: buildOutlineInputBorder(
                  focusedBorderColor ?? const Color(0xffD0D5DD),
                  focusedBorderWidth ?? 1,
                ),
          ),
          style: style ?? GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.0)),
          cursorColor: cursorColor ?? Colors.black,
          obscureText: obscure ?? false,
          keyboardType: keyboardType ?? TextInputType.text,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          onChanged: onChanged,
          minLines:null,
          maxLines: null,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
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
      );
  }
}
