import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../i10n/strings.g.dart';
import '../../colors/app_color.dart';

class CustomSearchField extends StatefulWidget {
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
    required this.onCrossTapped,
  });

  final void Function(String)? onSubmit;
  final void Function(String)? onChanged;
  final void Function()? onCrossTapped;
  final TextEditingController searchController;
  final String? searchHint;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool prefixIconVisible;
  final bool filled;
  final Color searchTileColor;
  final bool enable;

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? App.appSpacer.edgeInsets.x.smm,
      padding: widget.padding ?? App.appSpacer.edgeInsets.y.none,
      decoration: BoxDecoration(
        // color: backgroundColor ?? const Color(0xffffffff),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        enabled: widget.enable,
        controller: widget.searchController,
        textInputAction: TextInputAction.search,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r"\s+"), replacementString: " "),
          // NoLeadingSpaceFormatter(),
          FilteringTextInputFormatter.deny(RegExp(r'^[!@#%&*$~^+]'),replacementString: ""),
        ],
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: widget.prefixIconVisible ? Image.asset(
              'assets/images/ic_search_field.png',height: 20.h,width: 20.h,) : null,
          // suffix: widget.searchController.text.isNotEmpty ? Material(
          //   color: Colors.transparent,
          //   child: InkWell(
          //     onTap: widget.onCrossTapped,
          //     child: const Icon(Icons.clear,size: 18,)
          //   ),
          // ) : null,
          suffixIcon: widget.searchController.text.isNotEmpty ? Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: widget.onCrossTapped,
                child: Icon(Icons.clear,size: 18.h,)
            ),
          ) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: widget.searchHint ?? t.search_here,
          hintStyle: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.0.sp,
            ),
          ),
          filled: widget.filled,
          fillColor: kSearchTile,
          // contentPadding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 18.0),
          enabledBorder: buildOutlineInputBorder(
            widget.filled ? kSearchTile : Colors.black.withOpacity(0.4), 1,
          ),
          focusedBorder: buildOutlineInputBorder(
            widget.filled ? kSearchTile : kAppPrimary, 1,
          ),
          disabledBorder: buildOutlineInputBorder(
            widget.filled ? kSearchTile : Colors.black.withOpacity(0.2), 1,
          ),
        ),
        style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.0.sp)),
        cursorColor: Colors.black,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmit,
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
