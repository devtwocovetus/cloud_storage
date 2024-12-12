import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../colors/app_color.dart';

class SearchDropdownTextField<T> extends StatelessWidget {
   const SearchDropdownTextField({super.key,
     required this.padding,
     required this.controller,
     this.containerBackgroundColor,
     required this.dropdownMenuEntries,
     this.borderRadius,
     this.border,
     this.width,
     this.isRequired = true,
     this.labelFontColor,
     required this.labelText,
     required this.hint,
     this.readOnly = false,
     this.enabledBorderColor,
     this.enabledBorderWidth,
     this.enabledBorder,
     this.errorBorderWidth,
     this.focusedBorderWidth,
     this.focusedBorder,
     this.focusedBorderColor,
     this.errorBorder,
     this.errorBorderColor,
     this.focusedErrorBorder,
     this.backgroundColor,
     this.textFieldBorder,
     this.suffixIconColor,
     this.hintStyle,
     this.style,
     this.prefixIconColor,
     this.contentPadding,
     this.focusNode,
     this.onSelected,
     this.onSearchCallback,
  });

  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final double padding;
  final Color? containerBackgroundColor;
  final TextEditingController controller;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final double? width;
  final bool readOnly;
  final bool isRequired;
  final Color? labelFontColor;
  final Color? suffixIconColor;
  final String labelText;
  final String hint;
  final InputBorder? enabledBorder;
  final Color? enabledBorderColor;
  final double? errorBorderWidth;
  final double? enabledBorderWidth;
  final InputBorder? focusedBorder;
  final Color? focusedBorderColor;
  final double? focusedBorderWidth;
  final InputBorder? errorBorder;
  final Color? errorBorderColor;
  final InputBorder? focusedErrorBorder;
  final InputBorder? textFieldBorder;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Color? prefixIconColor;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final ValueChanged<T?>? onSelected;
  final SearchCallback<T>? onSearchCallback;

 // final List listhe = ["Item 1", 'Item 2', 'Item 3', 'Item 4'];
   // FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    double screenHeight=MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
      width: width,
      decoration: BoxDecoration(
        color: containerBackgroundColor ?? const Color(0xffffffff),
        borderRadius: borderRadius ?? BorderRadius.circular(10.0),
        border: border,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            required: isRequired,
            textAlign: TextAlign.left,
            text: labelText,
            fontSize: 14.0.sp,
            fontWeight: FontWeight.w500,
            fontColor: labelFontColor,
          ),
          SizedBox(height: screenWidth * 0.02,),
          DropdownMenu<T>(
            // searchCallback: (entries, query) {
            //   if (query.isEmpty) {
            //     return null;
            //   }
            //   return null;
            // },
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r"\s+"), replacementString: " "),
              // NoLeadingSpaceFormatter(),
              FilteringTextInputFormatter.deny(RegExp(r'^[!@#%&*$~^+]'),replacementString: ""),
            ],
            searchCallback: onSearchCallback,
            onSelected: onSelected,
            menuHeight: screenHeight * 0.4,
            expandedInsets: EdgeInsets.zero,
            enabled: !readOnly,
            width: screenWidth - (padding * 2),
            controller: controller,
            enableFilter: true,
            hintText: hint,
            textStyle: style ?? GoogleFonts.poppins(textStyle: TextStyle(color: readOnly ? kAppGreyA : Colors.black,fontWeight: FontWeight.w400,fontSize: 14.0.sp)),
            requestFocusOnTap: false,
            focusNode: focusNode,
            trailingIcon: const SizedBox.shrink(),
            selectedTrailingIcon: const SizedBox.shrink(),
            menuStyle: MenuStyle(
              backgroundColor: WidgetStateProperty.all<Color>(const Color(0xffffffff)),
            ),
            inputDecorationTheme: InputDecorationTheme(
              isDense: true,
              border: textFieldBorder,
              constraints: BoxConstraints.tightFor(height: screenHeight * 0.06),
              // suffixIcon: suffixIcon,
              suffixIconColor: suffixIconColor,
              // prefixIcon: prefixIcon,
              // prefixIconConstraints: prefixConstraints,
              prefixIconColor: prefixIconColor,
              // hintText: hint,
              hintStyle: hintStyle ?? Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(fontSize: 14.sp),
              errorMaxLines: 2,
              // suffixIconConstraints: BoxConstraints(
              //     minHeight: 33.h,
              //     minWidth: 24.h
              // ),
              contentPadding: contentPadding,
              fillColor: backgroundColor ?? const Color(0xffffffff),
              filled: true,
              errorStyle: TextStyle(
                color: kAppError,
                fontSize: 12.h,
                // fontWeight: FontWeight.w700
                // height: 0
              ),
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
            ),
            dropdownMenuEntries: dropdownMenuEntries,
          ),
        ],
      ),
    );
  }

   OutlineInputBorder buildOutlineInputBorder(Color color, double width) {
     return OutlineInputBorder(
       borderSide: BorderSide(
         color: color,
         width: width.h,
       ),
       borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(10)),
     );
   }
}
