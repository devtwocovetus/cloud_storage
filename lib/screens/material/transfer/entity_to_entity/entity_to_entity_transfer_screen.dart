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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class EntityToEntityTransferScreen extends StatelessWidget {
  EntityToEntityTransferScreen({super.key});
  DateTime selectedDate = DateTime.now();
  final quantityViewModel = Get.put(EntityToEntityTransferViewModel());
  final _formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
     late i18n.Translations translation;
  XFile? image;

  Future<void> imageBase64Convert(BuildContext context) async {
    DialogUtils.showMediaDialog(context,
        title: translation.add_photo,
        cameraBtnText: translation.camera,
        libraryBtnText: translation.library,
        cameraBtnFunction: () async {
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
        translation = i18n.Translations.of(context);
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          Visibility(visible: !showFab, child: _addButtonWidget(context)),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: SafeArea(
            child: Container(
              height: 60.h,
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
                        height: 15.h,
                        width: 10.h,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                     CustomTextField(
                        textAlign: TextAlign.center,
                        text: translation.material_transfer,
                        fontSize: 18.0.sp,
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
                                height: 20.h,
                                width: 20.h,
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
                SizedBox(height: 8.h,),
                _restWidget(context),
                SizedBox(height: 12.h,),
                _categoryWidget,
                SizedBox(height: 12.h,),
                _materialNameWidget,
                if (quantityViewModel.isBin.value) ...[
                  SizedBox(height: 12.h,),
                  _binWidget,
                ],
                SizedBox(height: 12.h,),
                _transferDateWidget(context),
                if (quantityViewModel.isavailableQuantity.value) ...[
                  SizedBox(height: 12.h,),
                  _availableQuantityWidget,
                  SizedBox(height: 12.h,),
                  _quantityWidget,
                ],
                SizedBox(height: 12.h,),
                _expirationDateWidget(context),
                SizedBox(height: 12.h,),
                _reasonWidget,
                SizedBox(height: 12.h,),
                _notesWidget,
                SizedBox(height: 120.h,),
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
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.category,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          MyCustomDropDown<String>(
            hintFontSize: 14.0.sp,
            initialValue: quantityViewModel.mStrcategory.value,
            itemList: quantityViewModel.categoryList,
            hintText: translation.select,
            validateOnChange: true,
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem),
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: kAppBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.5.sp)),
              );
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item),
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: kAppBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.5.sp)),
              );
            },
            validator: (value) {
              if (value == null || value == 'Select Category') {
                return "   ${translation.select_a_category}";
              }
              return null;
            },
            onChange: (item) {
              quantityViewModel.isavailableQuantity.value = false;
              quantityViewModel.mStrcategory.value = item!.toString();
              quantityViewModel.getMaterial();
              quantityViewModel.mStrmaterial.value = 'Select Material';
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
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.material,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          MyCustomDropDown<String>(
            hintFontSize: 14.0.sp,
            enabled: quantityViewModel.materialList.isEmpty ? false : true,
            initialValue: quantityViewModel.mStrmaterial.value,
            itemList: quantityViewModel.materialList,
            hintText: translation.select,
            validateOnChange: true,
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem),
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: kAppBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.5.sp)),
              );
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item),
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: kAppBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.5.sp)),
              );
            },
            validator: (value) {
              print("MYMYMYMY:::: ${value}");
              if (value == null || value == 'Select Material') {
                return "   ${translation.select_a_material}";
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
      lastDate: DateTime(2101),
      locale: Locale(i18n.LocaleSettings.currentLocale.languageCode)
    );
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
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.date_of_transfer,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
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
            height: 25.h,
            borderRadius: BorderRadius.circular(10.0),
            hint: translation.date_of_transfer,
            controller: quantityViewModel.transferDateController.value,
            focusNode: quantityViewModel.transferDateFocus.value,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
            validating: (value) {
              if (value!.isEmpty) {
                return translation.add_transfer_date;
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
                       CustomTextField(
                        textAlign: TextAlign.left,
                        text: translation.entity_from,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff8F8F8F),
                      ),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: Utils.textCapitalizationString(
                            quantityViewModel.entityName.value),
                        fontSize: 14.sp,
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
                    width: 30.h,
                    height: 30.h,
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       CustomTextField(
                        textAlign: TextAlign.left,
                        text: translation.entity_to,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff8F8F8F),
                      ),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: Utils.textCapitalizationString(
                            quantityViewModel.toEntityName.value),
                        fontSize: 14.sp,
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.expiration_date,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              readOnly: true,
              onTab: () async {
                await _selectDate(
                    context, quantityViewModel.expirationController.value);
              },
              suffixIcon: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 2),
                child: Image.asset(
                  height: 19.h,
                  width: 20.h,
                  'assets/images/ic_calender.png',
                ),
              ),
              // width: App.appQuery.responsiveWidth(90),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.expiration_date,
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.select_bin,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          MyCustomDropDown<String>(
            hintFontSize: 14.0.sp,
            itemList: quantityViewModel.binList,
            initialValue: quantityViewModel.mStrBin.value,
            hintText: translation.select_bin,
            validateOnChange: true,
            headerBuilder: (context, selectedItem, enabled) {
              return quantityViewModel.binList.contains(selectedItem)
                  ? Text(selectedItem,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: kAppBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.5.sp)),
              )
                  :  Text(translation.select_bin,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: kAppBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.5.sp)),
              );
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item),
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: kAppBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.5.sp)),
              );
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
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.quantity_transfer,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            ],
            // width: App.appQuery.responsiveWidth(90),
            height: 25.h,
            borderRadius: BorderRadius.circular(10.0),
            hint: translation.quantity,
            controller: quantityViewModel.quantityController.value,
            focusNode: quantityViewModel.quantityFocus.value,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.number,
            validating: (value) {
              if (value!.isEmpty) {
                return translation.enter_quantity;
              } else if (int.parse(value) == 0) {
                return translation.enter_quantity_more_than_zero;
              } else if (quantityViewModel
                  .availableQuantityController.value.text.isEmpty) {
                return translation.no_quantity_available;
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.available_quantity,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
            readOnly: true,
            backgroundColor: kBinCardBackground,
            // width: App.appQuery.responsiveWidth(90),
            height: 25.h,
            borderRadius: BorderRadius.circular(10.0),
            hint: translation.quantity,
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.comments_notes,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
            minLines: 2,
            maxLines: 4,
            // width: App.appQuery.responsiveWidth(90),
            height: 25.h,
            borderRadius: BorderRadius.circular(10.0),
            hint: translation.comments_notes,
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.reason_for_transfer,
              fontSize: 14.0.h,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
            minLines: 2,
            maxLines: 4,
            // width: App.appQuery.responsiveWidth(90),
            height: 25.h,
            borderRadius: BorderRadius.circular(10.0),
            hint: translation.reason_for_transfer,
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
        height: 45.h,
        borderRadius: BorderRadius.circular(10.0),
        onPressed: () async => {
          Utils.isCheck = true,
          if (_formKey.currentState!.validate())
            {quantityViewModel.transferMaterial()}
        },
        text: translation.generate,
      ),
    );
  }
}
