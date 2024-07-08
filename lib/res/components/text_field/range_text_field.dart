// import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class RangeTextFormField extends StatelessWidget {
  const RangeTextFormField({
    super.key,
    required this.hint,
    required this.controller,
    required this.textCapitalization,
    required this.keyboardType,
    required this.buttonText,
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
    required this.width,
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
  final String buttonText;
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

  // RxInt borderTypeCode = 1.obs;

  @override
  Widget build(BuildContext context) {
    /// UnFocused = 1
    /// Focused = 2
    /// UnFocusedError = 3
    /// FocusedError = 4

    return Container(
        height: height,
        width: width,
        margin: App.appSpacer.edgeInsets.bottom.xs,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.black.withOpacity(0.4),
            // color: borderTypeCode.value == 1 ? Colors.black.withOpacity(0.4)
            //     : borderTypeCode.value == 2 ? kAppPrimary
            //     : borderTypeCode.value == 3 ? kAppError
            //     : kAppError,
            style: BorderStyle.solid
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            App.appSpacer.vWxs,
            Expanded(
              child: TextFormField(
                autofocus: autofocus,
                enabled: enabled,
                controller: controller,
                focusNode: focusNode,
                inputFormatters: inputFormatters ?? [MaskTextInputFormatter(mask: "##:##")],
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
                  errorStyle: const TextStyle(
                      color: Colors.transparent,
                      fontSize: 0,
                      height: 0
                  ),
                  contentPadding: contentPadding,
                  enabledBorder: enabledBorder ??
                      InputBorder.none,
                      // buildOutlineInputBorder(Colors.black.withOpacity(0.4),1),
                  focusedBorder: focusedBorder ??
                      InputBorder.none,
                      // buildOutlineInputBorder(kAppPrimary,1),
                  errorBorder: errorBorder ??
                      InputBorder.none,
                      // buildOutlineInputBorder(kAppError,1),
                  focusedErrorBorder: focusedErrorBorder ??
                      InputBorder.none,
                      // buildOutlineInputBorder(kAppPrimary,1),
                ),
                style: style ?? GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.0)),
                cursorColor: cursorColor ?? Colors.black,
                obscureText: obscure ?? false,
                keyboardType: keyboardType,
                textCapitalization: textCapitalization,
                onChanged: onChanged,
                minLines: minLines ?? 1,
                maxLines: maxLines ?? 1,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
            ),
            const VerticalDivider(
              width: 0,
            ),
            Padding(
              padding: App.appSpacer.edgeInsets.x.xs,
              child: Text(buttonText,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12.0)
                ),
              ),
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
      // borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(10)),
    );
  }
}
