import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../colors/app_color.dart';

class MyCustomDropDown<T> extends StatelessWidget {
  const MyCustomDropDown({super.key,
    required this.itemList,
    required this.hintText,
    this.hintFontSize = 14.0,
    this.validator,
    this.validateOnChange = false,
    required this.onChange,
    this.initialValue,
    this.listItemBuilder,
    this.headerBuilder,
    this.enabled = true,
    this.padding,
    this.selectController,
    this.enableBorder = true,
  });

  final List<T> itemList;
  final String hintText;
  final double hintFontSize;
  final bool enabled;
  final String? Function(T?)? validator;
  final Function(T?)? onChange;
  final bool validateOnChange;
  final T? initialValue;
  final Widget Function(BuildContext, T, bool, void Function())? listItemBuilder;
  final Widget Function(BuildContext, T, bool)? headerBuilder;
  final EdgeInsets? padding;
  final SingleSelectController<T>? selectController;
  final bool enableBorder;

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<T>(
      controller: selectController,
      enabled: enabled,
      closedHeaderPadding: padding ?? App.appSpacer.edgeInsets.symmetric(x: 's',y: 's'),
      expandedHeaderPadding: App.appSpacer.edgeInsets.symmetric(x: 's',y: 's'),
      items: itemList,
      headerBuilder: headerBuilder,
      hintText: hintText,
      decoration: CustomDropdownDecoration(
        closedFillColor: enabled ? Colors.transparent : Colors.grey.withOpacity(0.2),
        errorStyle: TextStyle(
          color: kAppError,
          fontSize: 12.h,
        ),
        closedBorder: enableBorder ? Border.all(color:enabled ? kAppBlack.withOpacity(0.4) : Colors.grey.withOpacity(0.8),) : null,
        closedErrorBorder: enableBorder ? Border.all(color: kAppError) : null,
        expandedBorder: enableBorder ? Border.all(color: kAppPrimary) : null,
        hintStyle: GoogleFonts.poppins(textStyle: TextStyle(color: kAppBlack.withOpacity(0.4),fontWeight: FontWeight.w400,fontSize: hintFontSize)),
        closedSuffixIcon:  Icon(Icons.keyboard_arrow_down_rounded,color: enabled ? kAppBlack : Colors.grey.withOpacity(0.8),size: 24.h,),
        expandedSuffixIcon: Icon(Icons.keyboard_arrow_up_rounded,color: kAppBlack,size: 24.h,),
      ),
      disabledDecoration: CustomDropdownDisabledDecoration(
        suffixIcon: null,
        prefixIcon: null,
        fillColor: Colors.grey.withOpacity(0.2),
        border: Border.all(
      width: 1,
      color: kBinCardBackground,
    ),
        
        hintStyle: GoogleFonts.poppins(textStyle: TextStyle(color: kAppBlack.withOpacity(0.4),fontWeight: FontWeight.w400,fontSize: hintFontSize)),
        
      ),
      hintBuilder: (context, hint, enabled) {
        return Text(hint,maxLines: 1,overflow: TextOverflow.ellipsis, style: TextStyle(color: kAppBlackC,fontWeight: FontWeight.w400,fontSize: hintFontSize),);
      },
      listItemBuilder: listItemBuilder,
      initialItem: initialValue,
      validateOnChange: validateOnChange,
      validator: enabled ? validator : null,
      onChanged: onChange,
    );
  }
}
