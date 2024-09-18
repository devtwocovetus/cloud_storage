import 'dart:convert';
import 'dart:io';

import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/material_in/quantity_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:reusable_components/reusable_components.dart';

class QuantityCreationForm extends StatefulWidget {
  QuantityCreationForm({super.key, this.creationCode = 0});
  int creationCode;

  @override
  State<QuantityCreationForm> createState() => _QuantityCreationFormState();
}

class _QuantityCreationFormState extends State<QuantityCreationForm> {
  DateTime selectedDate = DateTime.now();

  late final QuantityViewModel quantityViewModel;

  @override
  void initState() {
    quantityViewModel = Get.put(QuantityViewModel(creationCode: widget.creationCode));
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  final ImagePicker picker = ImagePicker();

  XFile? image;

  Future<void> imageBase64Convert() async {
    print('<><><><> ${quantityViewModel.categoryList.length}');
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
    } else {
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = "data:image/png;base64,${base64Encode(bytes)}";
      Map<String, dynamic> imageData = {
        "imgPath": image!.path.toString(),
        "imgName": image!.name.toString(),
        "imgBase": base64Image.toString()
      };
      quantityViewModel.addImageToList(imageData);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          Visibility(visible: !showFab, child: _addButtonWidget(context)),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Container(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Add Quantity',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        Get.back();
                      },
                      child: Image.asset(
                        height: 20,
                        width: 20,
                        'assets/images/ic_close_dialog.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Obx(
            () => Column(
              children: [
                App.appSpacer.vHxs,
                _categoryWidget,
                App.appSpacer.vHs,
                _materialNameWidget,
                // App.appSpacer.vHs,
                // _unitWidget,
                App.appSpacer.vHs,
                _binWidget,
                App.appSpacer.vHs,
                _expirationDateWidget(context),
                App.appSpacer.vHs,
                _quantityWidget,
                App.appSpacer.vHs,
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      Utils.deviceWidth(context) * 0.05,
                      0,
                      Utils.deviceWidth(context) * 0.05,
                      0),
                  child: Row(
                    children: [
                      const CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Any Damage',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          quantityViewModel.isBreakage.value =
                              !quantityViewModel.isBreakage.value;
                        },
                        child: quantityViewModel.isBreakage.value
                            ? Image.asset(
                                'assets/images/ic_switch_on.png',
                                width: 34,
                                height: 20,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/ic_switch_off.png',
                                width: 34,
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ],
                  ),
                ),
                quantityViewModel.isBreakage.value
                    ? _breakageWidget
                    : Container(),
                App.appSpacer.vHs,
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      Utils.deviceWidth(context) * 0.05,
                      0,
                      Utils.deviceWidth(context) * 0.05,
                      0),
                  child: const Row(
                    children: [
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Upload Images',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      Spacer(),
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'View All',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff005AFF)),
                    ],
                  ),
                ),
                App.appSpacer.vHxxs,
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      Utils.deviceWidth(context) * 0.05,
                      0,
                      Utils.deviceWidth(context) * 0.05,
                      0),
                  child: DottedBorder(
                    dashPattern: [8],
                    color: const Color(0xffD0D5DD),
                    strokeWidth: 2,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(9),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 8,
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.5,
                          shrinkWrap: true,
                          children: quantityViewModel.imageList.map((value) {
                            return Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Image.file(
                                File(value['imgPath']),
                                fit: BoxFit.cover,
                              ),
                            );
                          }).toList(),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await imageBase64Convert();
                          },
                          child: const CustomTextField(
                              textAlign: TextAlign.center,
                              text: 'Add Images',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              fontColor: Color(0xff969DB2)),
                        ),
                        App.appSpacer.vHxxs,
                        GestureDetector(
                          onTap: () async {
                            await imageBase64Convert();
                          },
                          child: const CustomTextField(
                              textAlign: TextAlign.center,
                              text: 'Supports: PNG, JPG, JPEG, WEBP',
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              fontColor: Color(0xff505050)),
                        ),
                      ],
                    ),
                  ),
                ),
                App.appSpacer.vHxs,
                App.appSpacer.vHxs,
                App.appSpacer.vHs,
                App.appSpacer.vHs,
                App.appSpacer.vHxs,
                App.appSpacer.vHxs,
                App.appSpacer.vHs,
                App.appSpacer.vHs,
                App.appSpacer.vHxs,
                App.appSpacer.vHxs,
                App.appSpacer.vHs,
                App.appSpacer.vHs,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _categoryWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.smm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Category',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          MyCustomDropDown<String>(
            initialValue: quantityViewModel.mStrcategory.value,
            itemList: quantityViewModel.categoryList,
            hintText: 'Select',
            validateOnChange: true,
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },
            validator: (value) {
              if (value == null || value == 'Select Category') {
                return "   Select a category";
              }
              return null;
            },
            onChange: (item) {
              quantityViewModel.mStrcategory.value = item!.toString();
              quantityViewModel.mStrmaterial.value = 'Select Material';
              quantityViewModel
                  .getMaterial(quantityViewModel.mStrcategory.value);
            },
          ),
        ],
      ),
    );
  }

  Widget get _materialNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.smm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Material',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          MyCustomDropDown<String>(
            initialValue: quantityViewModel.mStrmaterial.value,
            enabled: quantityViewModel.materialList.isEmpty ? false : true,
            itemList: quantityViewModel.materialList,
            hintText: 'Select',
            validateOnChange: true,
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },
            validator: (value) {
              if (value == null || value == 'Select Material') {
                return "   Select a material";
              }
              return null;
            },
            onChange: (item) {
              // quantityViewModel.mStrUnit.value = 'Select Unit';
              quantityViewModel.mStrmaterial.value = item!.toString();
              // quantityViewModel.getUnit(quantityViewModel.mStrmaterial.value);
            },
          ),
        ],
      ),
    );
  }

  Widget get _unitWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.smm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Unit',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          MyCustomDropDown<String>(
            initialValue: quantityViewModel.mStrUnit.value,
            enabled: quantityViewModel.unitList.isEmpty ? false : true,
            itemList: quantityViewModel.unitList,
            hintText: 'Select',
            validateOnChange: true,
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },
            validator: (value) {
              if (value == null || value == 'Select Unit') {
                return "   Select a unit";
              }
              return null;
            },
            onChange: (item) {
              quantityViewModel.mStrUnit.value = item!.toString();
            },
          ),
        ],
      ),
    );
  }

  Widget get _binWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.smm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Bin',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          MyCustomDropDown<String>(
            itemList: quantityViewModel.binList,
            hintText: 'Select',
            validateOnChange: true,
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },
            onChange: (item) {
              quantityViewModel.mStrBin.value = item!.toString();
            },
          ),
        ],
      ),
    );
  }

  Widget _expirationDateWidget(BuildContext context) {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Expiration Date',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              readOnly: true,
              onTab: () async {
                await _selectDate(context);
              },
              suffixIcon: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 2),
                child: Image.asset(
                  'assets/images/ic_calender.png',
                ),
              ),
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Expiration Date',
              controller: quantityViewModel.expirationController.value,
              focusNode: FocusNode(),
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    print('<><><><><>callll');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      quantityViewModel.expirationController.value.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Widget get _quantityWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Quantity Received',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
            ],
            width: App.appQuery.responsiveWidth(90),
            height: 25,
            borderRadius: BorderRadius.circular(10.0),
            hint: 'Quantity',
            controller: quantityViewModel.quantityController.value,
            focusNode: FocusNode(),
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.number,
            validating: (value) {
              if (value!.isEmpty) {
                return 'Enter quantity';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget get _breakageWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          App.appSpacer.vHs,
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Breakage Quantity Received',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
            ],
            width: App.appQuery.responsiveWidth(90),
            height: 25,
            borderRadius: BorderRadius.circular(10.0),
            hint: 'Quantity',
            controller: quantityViewModel.breakageController.value,
            focusNode: FocusNode(),
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.number,
            validating: (value) {
              // int newValue = int.parse(value!);
              if (value!.isEmpty) {
                return 'Enter breakage quantity';
              } else if (!value.isNum) {
                return 'Quantity must be a number';
              } else if (value.isNum &&
                  double.parse(value) >=
                      double.parse(
                          quantityViewModel.quantityController.value.text)) {
                return 'Breakage quantity must be less than received quantity';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _addButtonWidget(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: MyCustomButton(
        width: App.appQuery.responsiveWidth(70) /*312.0*/,
        height: 45,
        borderRadius: BorderRadius.circular(10.0),
        onPressed: () async => {
          Utils.isCheck = true,
          if (_formKey.currentState!.validate())
            {quantityViewModel.addQuantiytToList(context)}
        },
        text: 'Add Quantity',
      ),
    );
  }
}
