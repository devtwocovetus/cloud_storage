import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneWidget extends StatefulWidget {
 PhoneWidget({super.key,
   required this.countryCode,
   required this.textEditingController,
   this.padding,
   this.borderColor,
   this.bgColor
 });

  RxString countryCode;
  Rx<TextEditingController> textEditingController;
  EdgeInsetsGeometry? padding;
  Color? borderColor;
  Color? bgColor;

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
      decoration:  const BoxDecoration(
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
      padding: widget.padding ?? EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.04, 0, Utils.deviceWidth(context) * 0.04, 0),
      width: double.infinity,
     color: widget.bgColor ?? Colors.white,
      child: Obx(()=>
        TextFormField(
          controller: widget.textEditingController.value,
          inputFormatters: [LengthLimitingTextInputFormatter(10),],
          style: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.0)),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter phone number';
            }
            return null;
          },
          keyboardType: TextInputType.phone,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(12, 5,12,5),
            border:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Color(0xFFE0E0E0), width: 0.1)),
            fillColor:  Colors.white,
            filled: true,
            errorStyle: const TextStyle(
              color: kAppError,
            ),
            prefixIcon: countryDropDown,
            hintText: 'Phone Number',
            enabledBorder: buildOutlineInputBorder(Colors.black.withOpacity(0.4),1),
            focusedBorder:buildOutlineInputBorder( kAppPrimary,1),
            errorBorder: buildOutlineInputBorder( kAppError,1),
            focusedErrorBorder: buildOutlineInputBorder(kAppPrimary,1),
          ),
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