import 'package:cold_storage_flutter/models/material/measurement_units_type.dart';
import 'package:cold_storage_flutter/view_models/controller/material/update/update_material_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../../models/material/material_categorie_model.dart';
import '../../../models/material/measurement_unit_mou.dart';
import '../../../res/components/dropdown/my_custom_drop_down.dart';
import '../../../res/components/image_view/network_image_view.dart';
import '../../../utils/utils.dart';
import '../../../view_models/services/app_services.dart';
import '../../category/category_add.dart';
import '../../category/category_add_on_update.dart';

class UpdateMaterialScreen extends StatefulWidget {
  const UpdateMaterialScreen({super.key});

  @override
  State<UpdateMaterialScreen> createState() => _UpdateMaterialScreenState();
}

class _UpdateMaterialScreenState extends State<UpdateMaterialScreen> {
  final updateMaterialViewModel = Get.put(UpdateMaterialViewModel());

  final _updateMaterialFormKey = GlobalKey<FormState>();

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
              if (_updateMaterialFormKey.currentState!.validate())
                {
                  updateMaterialViewModel.updateMaterial()
                }
            },
            text: 'Update Material',
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
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    padding: EdgeInsets.zero,
                    icon: Image.asset(
                      height: 15,
                      width: 10,
                      'assets/images/ic_back_btn.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const CustomTextField(
                    textAlign: TextAlign.center,
                    text: 'Update Material',
                    fontSize: 18.0,
                    fontColor: Color(0xFF000000),
                    fontWeight: FontWeight.w500),
                  const Spacer(),
                  Padding(
                    padding: App.appSpacer.edgeInsets.top.none,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // _sliderDrawerKey.currentState!.toggle();
                      },
                      icon: Image.asset(
                        height: 20,
                        width: 20,
                        'assets/images/ic_notification_bell.png',
                        fit: BoxFit.cover,
                      )),
                  ),
                  Obx(()=>
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // _sliderDrawerKey.currentState!.toggle();
                      },
                      icon: AppCachedImage(
                        roundShape: true,
                        height: 25,
                        width: 25,
                        url: updateMaterialViewModel.logoUrl.value)
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            return Form(
              key: _updateMaterialFormKey,
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
                      controller: updateMaterialViewModel.nameController.value,
                      focusNode: updateMaterialViewModel.nameFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter material name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text
                  ),
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
                      updateMaterialViewModel.descriptionController.value,
                      focusNode:
                      updateMaterialViewModel.descriptionFocusNode.value,
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
              )
            );
          },),
        )
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
      child: /*Obx(() =>*/
          IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: _unitTypeDropDownWidget),
            const VerticalDivider(),
            Expanded(child: _unitMouDropDownWidget),
          ],
        ),
      )
      // ),
    );
  }

  Widget get _unitTypeDropDownWidget {
    print('<><><><> ${updateMaterialViewModel.unitType.toString()}');
    return Container(
        height: 45.0,
        margin: const EdgeInsets.fromLTRB(3, 3, 10, 3),
        //width: 300.0,
        child: Obx(() {
          return DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: IgnorePointer(
                ignoring: updateMaterialViewModel.isLoading.value,
                child: DropdownButton<UnitType>(
                  hint: const Text('Select'),
                  value: updateMaterialViewModel.unitType,
                  items: updateMaterialViewModel.unitTypeList.value.map((UnitType value) {
                    return DropdownMenuItem<UnitType>(
                        value: value,
                        child: Text(
                          Utils.textCapitalizationString(value.unitType!),
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0)),
                        ));
                  }).toList(),
                  onChanged: (value) {
                    if (value != updateMaterialViewModel.unitType) {
                      updateMaterialViewModel.unitType = value!;
                      updateMaterialViewModel
                          .getMouList(updateMaterialViewModel.unitType!.unitType!);
                    }
                  },
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0)),
                ),
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
            child: IgnorePointer(
              ignoring: updateMaterialViewModel.isLoading.value,
              child: DropdownButton<MouList>(
                hint: const Text('Select'),
                value: updateMaterialViewModel.mou,
                items: updateMaterialViewModel.mouList.map((MouList value) {
                  return DropdownMenuItem<MouList>(
                      value: value,
                      child: Text(
                        Utils.textCapitalizationString(value.unitName!),
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0)),
                      ));
                }).toList(),
                onChanged: (value) {
                  updateMaterialViewModel.mou = value!;
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
                    const CategoryAddOnUpdate(),
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
          Obx(() => MyCustomDropDown<MaterialCategorie>(
            initialValue: updateMaterialViewModel.materialCategory,
              itemList: updateMaterialViewModel.categoryList.toList(),
              headerBuilder: (context, selectedItem, enabled) {
                return Text(Utils.textCapitalizationString(selectedItem.name!));
              },
              listItemBuilder: (context, item, isSelected, onItemSelect) {
                return Text(Utils.textCapitalizationString(item.name!));
              },
              hintText: 'Select Category',
              validator: (value) {
                if (value == null) {
                  return "   Select material category";
                }
                return null;
              },
              onChange: (item) {
                // log('changing value to: $item');
                updateMaterialViewModel.materialCategory = item;
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