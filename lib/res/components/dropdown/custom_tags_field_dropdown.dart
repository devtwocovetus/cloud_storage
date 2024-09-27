import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class CustomTagsFieldDropdown<T extends Object> extends StatefulWidget {
  const CustomTagsFieldDropdown({super.key,
    required this.itemList,
    required this.hintText,
    required this.enabled,
    this.validator,
    required this.onSelectionChange,
    required this.controller,
    required this.onOtherTileTap,
    required this.focusNode,
  });

  final Rx<MultiSelectController<T>> controller;
  final RxList<DropdownItem<T>> itemList;
  final String hintText;
  final RxBool enabled;
  final String? Function(T?)? validator;
  final void Function() onOtherTileTap;
  final Function(List<T>)? onSelectionChange;
  final FocusNode focusNode;

  @override
  State<CustomTagsFieldDropdown<T>> createState() => _CustomTagsFieldDropdownState<T>();
}

class _CustomTagsFieldDropdownState<T extends Object> extends State<CustomTagsFieldDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
        MultiDropdown<T>(
          focusNode: widget.focusNode,
          controller: widget.controller.value,
          enabled: widget.enabled.value,
          chipDecoration: const ChipDecoration(
            backgroundColor: kAppGreyC,
            wrap: true,
            runSpacing: 2,
            spacing: 10,
          ),
          fieldDecoration: FieldDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,),
            showClearIcon: false,
            border: buildOutlineInputBorder(Colors.black.withOpacity(0.4),1),
            focusedBorder: buildOutlineInputBorder(kAppPrimary,1),
            errorBorder: buildOutlineInputBorder(kAppPrimary,1),
            suffixIcon: widget.controller.value.isOpen
                ? const Icon(Icons.keyboard_arrow_up_rounded,color: kAppBlack,)
                : const Icon(Icons.keyboard_arrow_down_rounded,color: kAppBlack,),
          ),
          dropdownDecoration: const DropdownDecoration(
            marginTop: 2,
            maxHeight: 200,
            elevation: 3,
          ),
          dropdownItemDecoration: DropdownItemDecoration(
            selectedIcon:
            const Icon(Icons.check_box, color: Colors.green),
            disabledIcon:
            Icon(Icons.more_horiz, color: Colors.grey.shade300),
          ),
          onSelectionChange: widget.onSelectionChange,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          itemBuilder: (item, index, onTap) {
            return ListTile(
              onTap: item.disabled ? widget.onOtherTileTap : onTap,
              dense: true,
              title: Text(item.label.toString()),
              trailing: item.disabled
                  ? Icon(Icons.more_horiz, color: Colors.grey.shade300)
                  : item.selected ? Image.asset(
                'assets/images/ic_checkbox_active.png',
                // width: 18,
                // height: 18,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                'assets/images/ic_checkbox_inactive.png',
                // width: 18,
                // height: 18,
                fit: BoxFit.cover,
              ),
            );
          },
          items: widget.itemList,
        ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color color, double width) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
      borderRadius: /*borderRadius ?? */const BorderRadius.all(Radius.circular(10)),
    );
  }
}
