import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/screens/category/category_add.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/material/creatematerial_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';

class MaterialCreate extends StatefulWidget {
  const MaterialCreate({super.key});

  @override
  State<MaterialCreate> createState() => _MaterialCreateState();
}

class _MaterialCreateState extends State<MaterialCreate> {
  final creatematerialViewModel = Get.put(CreatematerialViewModel());

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(

      floatingActionButton: Visibility(
        visible: !showFab,
        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: MyCustomButton(
                        width: App.appQuery.responsiveWidth(70) /*312.0*/,
                        height: 45,
                        borderRadius: BorderRadius.circular(10.0),
                        onPressed: () async => {
                          Utils.isCheck = true,
                          if (_formkey.currentState!.validate())
                            {creatematerialViewModel.createMaterial()}
                        },
                        text: 'Create Material',
                      ),
                    ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(3, 0, 20, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      padding: EdgeInsets.zero,
                      icon: Image.asset(
                        height: 20,
                        width: 10,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Create Material ',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Image.asset(
                      height: 20,
                      width: 20,
                      'assets/images/ic_notification_bell.png',
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 25.0,
                        height: 25.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage(
                                  'assets/images/ic_user_defualt.png')),
                        ))
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            return Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.03,
                  ),
                  TextFormFieldLabel(
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: 'Material Name',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'ex. Apple',
                      controller: creatematerialViewModel.nameController.value,
                      focusNode: creatematerialViewModel.nameFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter material name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  _managerNameWidget,
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: 'Description',
                      lebelFontColor: const Color(0xff1A1A1A),
                      minLines: 2,
                      maxLines: 4,
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'Description',
                      controller:
                          creatematerialViewModel.descriptionController.value,
                      focusNode:
                          creatematerialViewModel.descriptionFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter description';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Utils.deviceWidth(context) * 0.04,
                        0,
                        Utils.deviceWidth(context) * 0.04,
                        0),
                    child: const CustomTextField(
                      required: true,
                      textAlign: TextAlign.left,
                      text: 'Measurement of Unit',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      fontColor: Color(0xff1A1A1A),
                    ),
                  ),
                  SizedBox(
                    height: Utils.deviceWidth(context) * 0.02,
                  ),
                  _measurementUnitsWidget,
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.10,
                  ),
                  
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget get _measurementUnitsWidget {
    return Container(
      margin: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.04, 0, Utils.deviceWidth(context) * 0.04, 0),
      padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.04, 0,
          Utils.deviceWidth(context) * 0.04, 0),
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.grey),
      ),

      width: double.infinity,
      child: Obx(() => IntrinsicHeight(
        child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: _unitTypeDropDownWidget),
                VerticalDivider(),
                Expanded(child: _unitMouDropDownWidget),
              ],
            ),
      )),
    );
  }

  Widget get _unitTypeDropDownWidget {
    print('<><><><> ${creatematerialViewModel.unitType.toString()}');
    return Container(
        height: 45.0,
        margin: const EdgeInsets.fromLTRB(3, 3, 10, 3),
        //width: 300.0,
        child: Obx(() {
          return DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                value: Utils.textCapitalizationString(creatematerialViewModel.unitType.value),
                items: creatematerialViewModel.unitTypeList.map((String value) {
                  return DropdownMenuItem<String>(
                      value: Utils.textCapitalizationString(value),
                      child: Text(
                        Utils.textCapitalizationString(value),
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0)),
                      ));
                }).toList(),
                onChanged: (value) {
                  if (value != creatematerialViewModel.unitType.value) {
                    creatematerialViewModel.unitType.value = value!;
                    creatematerialViewModel
                        .getMouList(creatematerialViewModel.unitType.value);
                  }
                },
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0)),
              ),
            ),
          );
        }));
  }

  Widget get _unitMouDropDownWidget {
    return Container(
     
      height: 45.0,
      margin: const EdgeInsets.fromLTRB(3, 3, 5, 3),
      //width: 300.0,
      child: Obx(
        () => DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: creatematerialViewModel.unitMou.value,
              items: creatematerialViewModel.mouList.map((String value) {
                return DropdownMenuItem<String>(
                    value: Utils.textCapitalizationString(value),
                    child: Text(
                      Utils.textCapitalizationString(value),
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0)),
                    ));
              }).toList(),
              onChanged: (value) {
                creatematerialViewModel.unitMou.value = value!;
              },
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0)),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _managerNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CustomTextField(
                  required: true,
                  textAlign: TextAlign.left,
                  text: 'Category',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  fontColor: Color(0xff1A1A1A)),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.dialog(
                    const CategoryAdd(),
                  );
                },
                child: Container(
                    width: 25.0,
                    height: 25.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: AssetImage('assets/images/ic_add_blue.png')),
                    )),
              )
            ],
          ),
          App.appSpacer.vHxs,
          Obx(
            () => MyCustomDropDown<String>(
              itemList: creatematerialViewModel.categoryList.toList(),
              headerBuilder: (context, selectedItem, enabled) {
                return Text(Utils.textCapitalizationString(selectedItem));
              },
              listItemBuilder: (context, item, isSelected, onItemSelect) {
                return Text(Utils.textCapitalizationString(item));
              },
              hintText: 'Select Category',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "   Select material category";
                }
                return null;
              },
              onChange: (item) {
                // log('changing value to: $item');
                creatematerialViewModel.materialCategory.value = item ?? '';
              },
              validateOnChange: true,
            ),
          ),
        ],
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
