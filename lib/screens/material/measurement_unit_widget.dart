import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/material/creatematerial_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/material/unit_widget_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MeasurementUnitWidget extends StatefulWidget {
 MeasurementUnitWidget({super.key,
   required this.unitTypeValue,
   required this.unitMouValue,
   required this.textEditingController,
   this.padding,
   this.borderColor,
   required this.unitType,
   required this.unitMou
 });

  RxString unitTypeValue;
  RxString unitMouValue;
  Rx<TextEditingController> textEditingController;
  EdgeInsetsGeometry? padding;
  Color? borderColor;
  List<String> unitType;
  List<String> unitMou;

  @override
  _MeasurementUnitWidgetState createState() => _MeasurementUnitWidgetState();
}

class _MeasurementUnitWidgetState extends State<MeasurementUnitWidget> {
   final unitWidgetViewModel = Get.put(UnitWidgetViewModel());
 
  

  @override
  Widget build(BuildContext context) {
       var unitTypeDropDown = Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      height: 45.0,
      margin: const EdgeInsets.fromLTRB(3, 3, 10, 3),
      //width: 300.0,
      child: Obx(() {
        return
        DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: widget.unitTypeValue.value,
              items: unitWidgetViewModel.unitTypeList.map((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.0)),
                    ));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  widget.unitTypeValue.value = value!;
                });
              },
              style: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.0)),
            ),
          ),
        );
  })
    );
    var unitMouDropDown = Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      height: 45.0,
      margin: const EdgeInsets.fromLTRB(3, 3, 10, 3),
      //width: 300.0,
      child: Obx(()=>
        DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: widget.unitMouValue.value,
              items: widget.unitMou.map((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.0)),
                    ));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  widget.unitMouValue.value = value!;
                  final creatematerialViewModel = Get.put(CreatematerialViewModel());
                  creatematerialViewModel.getMouList(widget.unitMouValue.value);
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
      color: Colors.white,
      child: Obx(()=>
        TextFormField(
          controller: widget.textEditingController.value,
          inputFormatters: [LengthLimitingTextInputFormatter(10),],
          style: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 14.0)),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter phone number';
            }
            return null;
          },
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(12, 5,12,0),
            border:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Color(0xFFE0E0E0), width: 0.1)),
            fillColor: Colors.white,
            filled: true,
            errorStyle: const TextStyle(
              color: kAppError,
            ),
            suffixIcon: Wrap(
              children: [
                unitTypeDropDown,
                //unitMouDropDown,
              ],
            ),
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