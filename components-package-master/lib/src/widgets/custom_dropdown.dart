
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef ItemSelectedFunction = void Function(String item);

//ignore: must_be_immutable
class CustomDropdown extends StatefulWidget {
  String? selectedTimezone;
  final String selectHint;
  final List<String?> allItems;
  final ItemSelectedFunction onItemSelected;

  CustomDropdown(
      {super.key,
      required this.selectHint,
      required this.onItemSelected,
      required this.allItems,
      this.selectedTimezone});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black.withOpacity(0.4),width: 1),borderRadius: BorderRadius.circular(8.0)),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
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
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 345,
              ),
              dropdownStyleData: const DropdownStyleData(
                maxHeight: 200,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  textEditingController.clear();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
