import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneWidget extends StatefulWidget {
 PhoneWidget({super.key, required this.countryCode, required this.textEditingController});

  RxString countryCode;
  Rx<TextEditingController> textEditingController;

  @override
  _PhoneWidgetState createState() => _PhoneWidgetState();
}

class _PhoneWidgetState extends State<PhoneWidget> {
  // late String _selectedCountryCode = '+91';
  final List<String> _countryCodes = ['+1','+675','+91', '+23'];
  @override
  void initState() {
    widget.countryCode.value = _countryCodes[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var countryDropDown = Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      height: 35.0,
      margin: const EdgeInsets.fromLTRB(3, 3, 10, 3),
      //width: 300.0,
      child: Obx(()=>
        DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: widget.countryCode.value,
              items: _countryCodes.map((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.0)),
                    ));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  widget.countryCode.value = value!;
                });
              },
              style: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.0)),
            ),
          ),
        ),
      ),
    );
    return Container(
      padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.04, 0, Utils.deviceWidth(context) * 0.04, 0),
      width: double.infinity,
      color: Colors.white,
      child: Obx(()=>
        TextFormField(
          controller: widget.textEditingController.value,
          style: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.0)),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(12, 5,12,5),
              border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xFFE0E0E0), width: 0.1)),
              fillColor: Colors.white,
              prefixIcon: countryDropDown,
              hintText: 'Phone Number',
              enabledBorder: buildOutlineInputBorder( Colors.black.withOpacity(0.2),1),
                focusedBorder:buildOutlineInputBorder( kAppPrimary,1),
                errorBorder: buildOutlineInputBorder( kAppError,1),
                focusedErrorBorder: buildOutlineInputBorder(kAppPrimary,1),),
        ),
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