import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../colors/app_color.dart';

class MyCustomDropDown<T> extends StatelessWidget {
  const MyCustomDropDown({super.key,
    required this.itemList,
    required this.hintText,
    this.validator,
    this.validateOnChange = false,
    required this.onChange,
    this.initialValue,
    this.listItemBuilder,
    this.headerBuilder,
    this.enabled = true,
  });

  final List<T> itemList;
  final String hintText;
  final bool enabled;
  final String? Function(T?)? validator;
  final Function(T?)? onChange;
  final bool validateOnChange;
  final T? initialValue;
  final Widget Function(BuildContext, T, bool, void Function())? listItemBuilder;
  final Widget Function(BuildContext, T, bool)? headerBuilder;

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<T>(
      enabled: enabled,
      closedHeaderPadding: App.appSpacer.edgeInsets.symmetric(x: 's',y: 's'),
      expandedHeaderPadding: App.appSpacer.edgeInsets.symmetric(x: 's',y: 's'),
      items: itemList,
      headerBuilder: headerBuilder,
      hintText: hintText,
      decoration: CustomDropdownDecoration(
        errorStyle: const TextStyle(
          color: kAppError,
        ),
        closedBorder: Border.all(color: kAppBlack.withOpacity(0.4),),
        closedErrorBorder: Border.all(color: kAppError),
        expandedBorder: Border.all(color: kAppPrimary),
        hintStyle: GoogleFonts.poppins(textStyle: TextStyle(color: kAppBlack.withOpacity(0.4),fontWeight: FontWeight.w400,fontSize: 14.0)),
        closedSuffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,color: kAppBlack,),
        expandedSuffixIcon: const Icon(Icons.keyboard_arrow_up_rounded,color: kAppBlack,),
      ),
      disabledDecoration: CustomDropdownDisabledDecoration(
        suffixIcon: null,
        prefixIcon: null,
        fillColor: Colors.grey.withOpacity(0.2),
        border: Border.all(
      width: 1,
      color: Colors.grey,
    ),
        
        hintStyle: GoogleFonts.poppins(textStyle: TextStyle(color: kAppBlack.withOpacity(0.4),fontWeight: FontWeight.w400,fontSize: 14.0)),
        
      ),
      hintBuilder: (context, hint, enabled) {
        return Text(hint, style: const TextStyle(color: kAppBlackC,fontWeight: FontWeight.w400,fontSize: 14.0),);
      },
      listItemBuilder: listItemBuilder,
      initialItem: initialValue,
      validateOnChange: validateOnChange,
      validator: validator,
      onChanged: onChange,
    );
  }
}
