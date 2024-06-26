import 'package:flutter/material.dart';

import 'custom_text_form_field.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({
    Key? key,
    required this.searchTextFieldController,
    required this.hint,
    required this.hintStyle,
    required this.style,
    this.autofocus = false,
    this.enabled,
    this.height,
    this.width,
    this.contentPadding,
    this.boxShadow,
    this.suffixIcon,
    this.prefixIcon,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.backgroundColor,
    this.onSubmit,
    this.cursorColor,
    this.borderRadius,
    this.border,
    this.onChanged,
    this.textFieldBorder = InputBorder.none,
  }) : super(key: key);

  final bool autofocus;
  final bool? enabled;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? contentPadding;
  final List<BoxShadow>? boxShadow;
  final TextEditingController searchTextFieldController;
  final String hint;
  final TextStyle hintStyle;
  final TextStyle style;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final Color? backgroundColor;
  final Color? cursorColor;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final void Function(String)? onSubmit;
  final void Function(String)? onChanged;
  final InputBorder? textFieldBorder;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      autofocus: autofocus,
      enabled: enabled,
      backgroundColor: backgroundColor,
      height: height ?? 50,
      width: width ?? 380,
      controller: searchTextFieldController,
      hint: hint,
      hintStyle: hintStyle,
      style: style,
      contentPadding: contentPadding,
      boxShadow: boxShadow,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.text,
      cursorColor: cursorColor,
      textFieldBorder: textFieldBorder,
      border: border,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      borderRadius: borderRadius,
      onSubmit: onSubmit,
      onChanged: onChanged,
    );
  }
}
