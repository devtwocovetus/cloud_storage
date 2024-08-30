import 'dart:convert';
import 'dart:io';

import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/material_in/quantity_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/material_out/quantity_out_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:reusable_components/reusable_components.dart';

class QuantityUpdateMaterialOutForm extends StatelessWidget {
  QuantityUpdateMaterialOutForm({super.key});

  DateTime selectedDate = DateTime.now();
  final quantityViewModel = Get.put(QuantityOutViewModel());
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
          child: Obx(
                () => Column(
              children: [
                App.appSpacer.vHxs,
                _categoryWidget,
                App.appSpacer.vHs,
                _materialNameWidget,
                App.appSpacer.vHs,
                _unitWidget,
                if (quantityViewModel.isBin.value) ...[
                  App.appSpacer.vHs,
                  _binWidget,
                ],
                if (quantityViewModel.isavailableQuantity.value) ...[
                  App.appSpacer.vHs,
                  _availableQuantityWidget,
                  App.appSpacer.vHs,
                  _quantityWidget,
                ],
                App.appSpacer.vHs,
                _notesWidget,
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
              text: 'Select Category',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          MyCustomDropDown<String>(
            initialValue: quantityViewModel.mStrcategory.value,
            itemList: quantityViewModel.categoryList,
            hintText: 'Select Category',
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
              quantityViewModel.isavailableQuantity.value = false;
              quantityViewModel.mStrcategory.value = item!.toString();
              quantityViewModel.mStrmaterial.value = 'Select Material';
              quantityViewModel.getMaterial();
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
              text: 'Select Material',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          MyCustomDropDown<String>(
            initialValue: quantityViewModel.mStrmaterial.value,
            enabled: quantityViewModel.materialList.isEmpty ? false : true,
            itemList: quantityViewModel.materialList,
            hintText: 'Select Material',
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
              quantityViewModel.isavailableQuantity.value = false;
              quantityViewModel.mStrUnit.value = 'Select Unit';
              quantityViewModel.mStrmaterial.value = item!.toString();
              quantityViewModel.getUnit();
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
              text: 'Select Unit',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          MyCustomDropDown<String>(
            initialValue: quantityViewModel.mStrUnit.value,
            enabled: quantityViewModel.unitList.isEmpty ? false : true,
            itemList: quantityViewModel.unitList,
            hintText: 'Select Unit',
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
              quantityViewModel.isavailableQuantity.value = true;
              quantityViewModel.mStrUnit.value = item!.toString();
              quantityViewModel.getAvailableQuantity();
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
              text: 'Select Bin',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          MyCustomDropDown<String>(
            itemList: quantityViewModel.binList,
            hintText: 'Select Bin',
            validateOnChange: true,
            headerBuilder: (context, selectedItem, enabled) {
              return quantityViewModel.binList.contains(selectedItem)
                  ? Text(selectedItem)
                  : const Text('Select Bin');
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },
            onChange: (item) {
              if (quantityViewModel.binList[0] == 'Select Bin') {
                quantityViewModel.binList.removeAt(0);
                quantityViewModel.binListId.removeAt(0);
              }
              quantityViewModel.mStrBin.value = item!.toString();
            },
          ),
        ],
      ),
    );
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
              text: 'Quantity Dispatched',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            ],
            width: App.appQuery.responsiveWidth(90),
            height: 25,
            borderRadius: BorderRadius.circular(10.0),
            hint: 'Quantity',
            controller: quantityViewModel.quantityController.value,
            focusNode: quantityViewModel.quantityFocus.value,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.number,
            validating: (value) {
              if (value!.isEmpty) {
                return 'Enter quantity';
              } else if (int.parse(value) == 0) {
                return 'Enter quantity more then 0';
              } else if (quantityViewModel
                  .availableQuantityController.value.text.isEmpty) {
                return 'No quantity available for out';
              } else if (int.parse(quantityViewModel
                  .availableQuantityController.value.text) <
                  int.parse(value)) {
                return 'Not have enough quantity available to dispatch';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget get _availableQuantityWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Available quantity',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
            readOnly: true,
            backgroundColor: kBinCardBackground,
            width: App.appQuery.responsiveWidth(90),
            height: 25,
            borderRadius: BorderRadius.circular(10.0),
            hint: 'Quantity',
            controller: quantityViewModel.availableQuantityController.value,
            focusNode: quantityViewModel.availableQuantityFocus.value,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget get _notesWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Notes',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
            minLines: 2,
            maxLines: 4,
            width: App.appQuery.responsiveWidth(90),
            height: 25,
            borderRadius: BorderRadius.circular(10.0),
            hint: 'Notes',
            controller: quantityViewModel.noteController.value,
            focusNode: quantityViewModel.noteFocus.value,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
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
