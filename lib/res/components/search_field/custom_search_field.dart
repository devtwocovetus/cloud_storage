import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../colors/app_color.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    this.onSubmit,
    this.onChanged,
    required this.searchController,
    this.searchHint
  });


  final void Function(String)? onSubmit;
  final void Function(String)? onChanged;
  final TextEditingController searchController;
  final String? searchHint;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: App.appSpacer.edgeInsets.x.smm,
      padding: App.appSpacer.edgeInsets.y.xs,
      decoration: BoxDecoration(
        // color: backgroundColor ?? const Color(0xffffffff),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: searchController,
        textInputAction: TextInputAction.search,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r"\s+"), replacementString: " "),
          // NoLeadingSpaceFormatter(),
          FilteringTextInputFormatter.deny(RegExp(r'^[!@#%&*$~^+]'),replacementString: ""),
        ],
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: searchHint ?? 'Search Here',
          hintStyle: const TextStyle(fontSize: 12),
          // contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 18.0),
          enabledBorder: buildOutlineInputBorder(
                Colors.black.withOpacity(0.4), 1,
          ),
          focusedBorder: buildOutlineInputBorder(
            kAppPrimary, 1,
          ),
        ),
        style: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.0)),
        cursorColor: Colors.black,
        onChanged: onChanged,
        onSubmitted: onSubmit,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color color, double width) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }
}
