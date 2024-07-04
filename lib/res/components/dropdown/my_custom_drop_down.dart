import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../colors/app_color.dart';

class MyCustomDropDown extends StatelessWidget {
  const MyCustomDropDown({super.key,
    required this.itemList,
    required this.hintText,
    required this.validator,
    this.validateOnChange = false,
    required this.onChange,
  });

  final List<String> itemList;
  final String hintText;
  final String? Function(String?)? validator;
  final Function(String?)? onChange;
  final bool validateOnChange;

  @override
  Widget build(BuildContext context) {
    return CustomDropdown(
      closedHeaderPadding: App.appSpacer.edgeInsets.symmetric(x: 's',y: 's'),
      expandedHeaderPadding: App.appSpacer.edgeInsets.symmetric(x: 's',y: 's'),
      items: itemList,
      hintText: hintText,
      decoration: CustomDropdownDecoration(
        errorStyle: const TextStyle(
          color: kAppError,
          // fontSize: 12,
          // fontWeight: FontWeight.w700
          // height: 0
        ),
        closedBorder: Border.all(color: kAppBlack.withOpacity(0.4),),
        closedErrorBorder: Border.all(color: kAppError),
        expandedBorder: Border.all(color: kAppPrimary),
        hintStyle: GoogleFonts.poppins(textStyle: TextStyle(color: kAppBlack.withOpacity(0.4),fontWeight: FontWeight.w400,fontSize: 14.0)),
        closedSuffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,color: kAppBlack,),
        expandedSuffixIcon: const Icon(Icons.keyboard_arrow_up_rounded,color: kAppBlack,),
      ),
      hintBuilder: (context, hint, enabled) {
        return Text(hint, style: const TextStyle(color: kAppBlackC,fontWeight: FontWeight.w400,fontSize: 14.0),);
      },
      validateOnChange: validateOnChange,
      validator: validator,
      onChanged: onChange,
    );
  }
}
