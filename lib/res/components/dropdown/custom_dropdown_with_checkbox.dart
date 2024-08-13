import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class CustomDropdownWithCheckbox extends StatefulWidget {
  const CustomDropdownWithCheckbox({super.key});

  @override
  State<CustomDropdownWithCheckbox> createState() => _CustomDropdownWithCheckboxState();
}

class _CustomDropdownWithCheckboxState extends State<CustomDropdownWithCheckbox> {
  @override
  Widget build(BuildContext context) {
    return MultiDropdown(
        items: [
          DropdownItem(label: 'Nepal', value: 1),
          DropdownItem(label: 'China', value: 2),
          DropdownItem(label: 'Australia', value: 3),
          DropdownItem(label: 'India', value: 4),
          DropdownItem(label: 'USA', value: 5),
          DropdownItem(label: 'UK', value: 6),
          DropdownItem(label: 'Germany', value: 7),
        ]
    );
  }
}
