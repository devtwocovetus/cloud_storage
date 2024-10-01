import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../colors/app_color.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    this.onSubmit,
    this.onChanged,
    required this.searchController,
    this.searchHint,
    this.margin,
    this.padding,
    this.prefixIconVisible = false,
    this.searchTileColor = kSearchTile,
    this.filled = false,
    this.enable = true,
  });

  final void Function(String)? onSubmit;
  final void Function(String)? onChanged;
  final TextEditingController searchController;
  final String? searchHint;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool prefixIconVisible;
  final bool filled;
  final Color searchTileColor;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? App.appSpacer.edgeInsets.x.smm,
      padding: padding ?? App.appSpacer.edgeInsets.y.none,
      decoration: BoxDecoration(
        // color: backgroundColor ?? const Color(0xffffffff),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        enabled: enable,
        controller: searchController,
        textInputAction: TextInputAction.search,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r"\s+"), replacementString: " "),
          // NoLeadingSpaceFormatter(),
          FilteringTextInputFormatter.deny(RegExp(r'^[!@#%&*$~^+]'),replacementString: ""),
        ],
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: prefixIconVisible ? Image.asset(
              'assets/images/ic_search_field.png') : null,
          // suffix: searchController.text.isNotEmpty ? Material(
          //   color: Colors.transparent,
          //   child: InkWell(
          //     onTap: () {
          //       searchController.clear();
          //     },
          //     child: const Icon(Icons.clear,size: 18,)
          //   ),
          // ) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: searchHint ?? 'Search Here...',
          hintStyle: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.0
            )
          ),
          filled: filled,
          fillColor: kSearchTile,
          // contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 18.0),
          enabledBorder: buildOutlineInputBorder(
            filled ? kSearchTile : Colors.black.withOpacity(0.4), 1,
          ),
          focusedBorder: buildOutlineInputBorder(
            filled ? kSearchTile : kAppPrimary, 1,
          ),
          disabledBorder: buildOutlineInputBorder(
            filled ? kSearchTile : Colors.black.withOpacity(0.2), 1,
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
