import 'dart:convert';
import 'dart:io';

import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/screens/material/material_out/widgets/dialog_utils.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/transfer/entity_to_entity/entity_to_entity_transfer_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:reusable_components/reusable_components.dart';

class EntityToEntityTransferScreen extends StatelessWidget {
  EntityToEntityTransferScreen({super.key});
  DateTime selectedDate = DateTime.now();
  final quantityViewModel = Get.put(EntityToEntityTransferViewModel());
  final _formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  XFile? image;

  Future<void> imageBase64Convert(BuildContext context) async {
    DialogUtils.showMediaDialog(context, cameraBtnFunction: () async {
      Get.back(closeOverlays: true);
      image = await picker.pickImage(source: ImageSource.camera);
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
    }, libraryBtnFunction: () async {
      Get.back(closeOverlays: true);
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
    });
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
                        if (quantityViewModel.comeFrom.value == 'Normal') {
                          Get.back();
                        } else {
                          Get.offAllNamed(RouteName.homeScreenView,
                              arguments: []);
                        }
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
                        text: 'Material Transfer',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Padding(
                      padding: App.appSpacer.edgeInsets.top.none,
                      child: Obx(
                        () => IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              // _sliderDrawerKey.currentState!.toggle();
                              Get.toNamed(RouteName.profileDashbordSetting)!
                                  .then((value) {});
                            },
                            icon: AppCachedImage(
                                roundShape: true,
                                height: 20,
                                width: 20,
                                url: UserPreference.profileLogo.value)),
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
                _restWidget(context),
                App.appSpacer.vHs,
                _categoryWidget,
                App.appSpacer.vHs,
                _materialNameWidget,
                if (quantityViewModel.isBin.value) ...[
                  App.appSpacer.vHs,
                  _binWidget,
                ],
                App.appSpacer.vHs,
                _transferDateWidget(context),
                if (quantityViewModel.isavailableQuantity.value) ...[
                  App.appSpacer.vHs,
                  _availableQuantityWidget,
                  App.appSpacer.vHs,
                  _quantityWidget,
                ],
                App.appSpacer.vHs,
                _expirationDateWidget(context),
                App.appSpacer.vHs,
                _reasonWidget,
                App.appSpacer.vHs,
                _notesWidget,
                App.appSpacer.vHs,
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
              quantityViewModel.isavailableQuantity.value = false;
              quantityViewModel.mStrcategory.value = item!.toString();
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
              text: 'Material',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          MyCustomDropDown<String>(
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
              quantityViewModel.isavailableQuantity.value = false;
              quantityViewModel.mStrmaterial.value = item!.toString();
              quantityViewModel.getUnit();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController textEditingController) async {
    print('<><><><><>callll');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      textEditingController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Widget _transferDateWidget(BuildContext context) {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.smm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Date of Transfer',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
            readOnly: true,
            onTab: () async {
              await _selectDate(
                  context, quantityViewModel.transferDateController.value);
            },
            suffixIcon: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 10, 2),
              child: Image.asset(
                'assets/images/ic_calender.png',
              ),
            ),
            // width: App.appQuery.responsiveWidth(90),
            height: 25,
            borderRadius: BorderRadius.circular(10.0),
            hint: 'Date of Transfer',
            controller: quantityViewModel.transferDateController.value,
            focusNode: quantityViewModel.transferDateFocus.value,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
            validating: (value) {
              if (value!.isEmpty) {
                return 'Add transfer date';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _restWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: App.appSpacer.edgeInsets.x.smm,
          decoration: const BoxDecoration(
            color: Color(0xffEFF8FF),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
            child: Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Entity From',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff8F8F8F),
                      ),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: Utils.textCapitalizationString(
                            quantityViewModel.entityName.value),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontColor: const Color(0xff1A1A1A),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.25,
                  child: Image.asset(
                    'assets/images/ic_group_arrow.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Entity To',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff8F8F8F),
                      ),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: Utils.textCapitalizationString(
                            quantityViewModel.toEntityName.value),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontColor: Color(0xff1A1A1A),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _expirationDateWidget(BuildContext context) {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.smm,
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
                await _selectDate(
                    context, quantityViewModel.expirationController.value);
              },
              suffixIcon: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 2),
                child: Image.asset(
                  'assets/images/ic_calender.png',
                ),
              ),
              // width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Expiration Date',
              controller: quantityViewModel.expirationController.value,
              focusNode: quantityViewModel.expirationFocus.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
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
      padding: App.appSpacer.edgeInsets.x.smm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Quantity Transfer',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            ],
            // width: App.appQuery.responsiveWidth(90),
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
      padding: App.appSpacer.edgeInsets.x.smm,
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
            // width: App.appQuery.responsiveWidth(90),
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
      padding: App.appSpacer.edgeInsets.x.smm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Comments/Notes',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
            minLines: 2,
            maxLines: 4,
            // width: App.appQuery.responsiveWidth(90),
            height: 25,
            borderRadius: BorderRadius.circular(10.0),
            hint: 'Comments/Notes',
            controller: quantityViewModel.noteController.value,
            focusNode: quantityViewModel.noteFocus.value,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }

  Widget get _reasonWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.smm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Reason for Transfer',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
            minLines: 2,
            maxLines: 4,
            // width: App.appQuery.responsiveWidth(90),
            height: 25,
            borderRadius: BorderRadius.circular(10.0),
            hint: 'Reason for Transfer',
            controller: quantityViewModel.reasonController.value,
            focusNode: quantityViewModel.reasonFocus.value,
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
            {quantityViewModel.transferMaterial()}
        },
        text: 'Generate',
      ),
    );
  }
}
