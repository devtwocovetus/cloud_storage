
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef ItemSelectedFunction = void Function(String item);

//ignore: must_be_immutable
class CustomDropdown extends StatefulWidget {
  String? selectedTimezone;
  final String selectHint;
  final List<String?> allItems;
  final double? height;
  final double? width;
  final String? Function(String?)? validating;
  final ItemSelectedFunction onItemSelected;

  CustomDropdown(
      {super.key,
      required this.selectHint,
      required this.onItemSelected,
      required this.allItems,
      required this.validating,
        this.height,
      this.selectedTimezone, this.width});

  @override
  CustomDropdownState createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
 

  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: widget.height!+20,
        width: widget.width,
        child: DropdownButtonFormField(
          isDense: true,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          elevation: 0,
          dropdownColor: Colors.blue.shade50,
        decoration:  InputDecoration(
          border: buildOutlineInputBorder(Colors.black.withOpacity(0.4),1),
          focusedErrorBorder:buildOutlineInputBorder(Colors.red,1),
          errorBorder: buildOutlineInputBorder(Colors.red,1),
          focusedBorder:buildOutlineInputBorder(Colors.black.withOpacity(0.4),1),
          disabledBorder: buildOutlineInputBorder(Colors.black.withOpacity(0.4),1),
        enabledBorder: buildOutlineInputBorder(Colors.black.withOpacity(0.4),1),),
          isExpanded: true,
          validator: widget.validating,
          hint: Text(
            textAlign: TextAlign.center,
            widget.selectHint,
            style: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.0)),
          ),
          items: widget.allItems
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item!,
                      style: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.0)),
                    ),
                  ))
              .toList(),
          value: widget.selectedTimezone,
          onChanged: (value) {
            widget.onItemSelected(value!);
            setState(() {
              widget.selectedTimezone = value;
            });
          },
          
        ),
      ),
    );
  }


}
