import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:reusable_components/src/colors/app_color.dart';


class TextFormFieldLabel extends StatelessWidget {
  const TextFormFieldLabel({
    super.key,
    required this.hint,
    required this.controller,
    this.textCapitalization,
    required this.keyboardType,
    required this.lebelText,
    required this.lebelFontColor,
    this.autofocus = false,
    this.errorTextPresent = false,
    this.enabled,
    this.readOnly = false,
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
    this.focusedErrorBorder = InputBorder.none, InputDecoration? decoration,
  });

  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final bool? enabled;
  final bool readOnly;
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
  final Color? lebelFontColor;
  final EdgeInsetsGeometry? contentPadding;
  final List<BoxShadow>? boxShadow;
  final InputBorder? textFieldBorder;
  final InputBorder? focusedErrorBorder;
  final int? minLines;
  final int? maxLines;
  final bool errorTextPresent;
  final double padding;
  final String lebelText;

  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xffffffff),
        borderRadius: borderRadius ?? BorderRadius.circular(10.0),
        border: border,
      ),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
                      required: true,
                        textAlign: TextAlign.left,
                        text: lebelText,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        fontColor: lebelFontColor,),
                        SizedBox(height: screenWidth * 0.02,),
          TextFormField(
            autofocus: autofocus,
            enabled: enabled,
            readOnly: readOnly,
            controller: controller,
            focusNode: focusNode,
            inputFormatters: inputFormatters ?? [],
            validator: validating,
            decoration: InputDecoration(
              isDense: true,
              border: textFieldBorder,
              suffixIcon: suffixIcon,
              suffixIconColor: suffixIconColor,
              prefixIcon: prefixIcon,
              prefixIconColor: prefixIconColor,
              hintText: hint,
              hintStyle: hintStyle,
              suffixIconConstraints: const BoxConstraints(
                          minHeight: 33,
                          minWidth: 24
                        ),
              contentPadding: contentPadding,
              enabledBorder: enabledBorder ??
                  buildOutlineInputBorder(
                    readOnly ? Colors.black.withOpacity(0.2) : enabledBorderColor ?? Colors.black.withOpacity(0.4),
                    enabledBorderWidth ?? 1,
                  ),
              focusedBorder: focusedBorder ??
                  buildOutlineInputBorder(
                    readOnly ? Colors.black.withOpacity(0.2) : focusedBorderColor ?? kAppPrimary,
                    focusedBorderWidth ?? 1,
                  ),
              errorBorder: errorBorder ??
                  buildOutlineInputBorder(
                    readOnly ? Colors.black.withOpacity(0.2) : errorBorderColor ?? kAppError,
                    errorBorderWidth ?? 1,
                  ),
              focusedErrorBorder: buildOutlineInputBorder(
                  readOnly ? Colors.black.withOpacity(0.2) : focusedBorderColor ?? kAppPrimary,
                    focusedBorderWidth ?? 1,
                  ),
            ).copyWith(errorText: errorTextPresent ? '' : null),
            style: style ?? GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.0)),
            cursorColor: cursorColor ?? Colors.black,
            obscureText: obscure ?? false,
            keyboardType: keyboardType,
            onChanged: onChanged,
            minLines: minLines ?? 1,
            maxLines: maxLines ?? 1,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ],
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
