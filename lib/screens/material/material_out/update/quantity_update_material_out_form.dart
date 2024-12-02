import 'dart:convert';
import 'dart:io';

import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/screens/material/material_out/widgets/dialog_utils.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/material_out/quantity_out_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/material_out/update/quantity_out_update_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

import '../../../../res/components/dialog/common_dialogs.dart';

class QuantityUpdateMaterialOutForm extends StatelessWidget {
  QuantityUpdateMaterialOutForm({super.key});

  DateTime selectedDate = DateTime.now();
  final quantityViewModel = Get.put(QuantityOutUpdateViewModel());
  final _formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
     late i18n.Translations translation;
  XFile? image;

  // Future<void> imageBase64Convert2() async {
  //   print('<><><><> ${quantityViewModel.categoryList.length}');
  //   image = await picker.pickImage(source: ImageSource.gallery);
  //   if (image == null) {
  //   } else {
  //     final bytes = File(image!.path).readAsBytesSync();
  //     String base64Image = "data:image/png;base64,${base64Encode(bytes)}";
  //     Map<String, dynamic> imageData = {
  //       "imgPath": image!.path.toString(),
  //       "imgName": image!.name.toString(),
  //       "imgBase": base64Image.toString()
  //     };
  //     quantityViewModel.addImageToList(imageData);
  //   }
  // }

  Future<void> imageBase64Convert(BuildContext context) async {
    if(quantityViewModel.imageList.length >= 5){
      showCustomWarningDialog(
          warningText: translation.dialog_img_count_validation
      );
      return;
    }
    // String res = await quantityViewModel.validateImages();
    // if(res.isNotEmpty){
    //   showCustomWarningDialog(
    //       warningText: translation.dialog_img_size_validation
    //   );
    //   return;
    // }
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
        quantityViewModel.addImageToList(img: imageData,translation: translation);
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
        quantityViewModel.addImageToList(img: imageData,translation: translation);
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     CustomTextField(
                        textAlign: TextAlign.center,
                        text: translation.update_quantity,
                        fontSize: 18.0.sp,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        Get.back();
                      },
                      child: Image.asset(
                        height: 20.h,
                        width: 20.h,
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
                SizedBox(height: 8.h,),
                _categoryWidget,
                SizedBox(height: 12.h,),
                _materialNameWidget,
                SizedBox(height: 12.h,),
                _unitWidget,
                if (quantityViewModel.isBin.value) ...[
                  SizedBox(height: 12.h,),
                  _binWidget,
                ],
                if (quantityViewModel.isavailableQuantity.value) ...[
                  SizedBox(height: 12.h,),
                  _availableQuantityWidget,
                  SizedBox(height: 12.h,),
                  _quantityWidget,
                ],
                SizedBox(height: 12.h,),
                _notesWidget,
                SizedBox(height: 12.h,),
                Padding(
                  padding: App.appSpacer.edgeInsets.x.smm,
                  child:  Row(
                    children: [
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: translation.upload_images,
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      Spacer(),
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: translation.view_all,
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff005AFF)),
                    ],
                  ),
                ),
                SizedBox(height: 4.h,),
                Padding(
                  padding: App.appSpacer.edgeInsets.x.smm,
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
                            await imageBase64Convert(context);
                          },
                          child:  CustomTextField(
                              textAlign: TextAlign.center,
                              text: translation.add_images,
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.w500,
                              fontColor: Color(0xff969DB2)),
                        ),
                        SizedBox(height: 4.h,),
                        GestureDetector(
                          onTap: () async {
                            await imageBase64Convert(context);
                          },
                          child: CustomTextField(
                              textAlign: TextAlign.center,
                              text: 'Supports: PNG, JPG, JPEG, WEBP',
                              fontSize: 10.0.h,
                              fontWeight: FontWeight.w400,
                              fontColor: Color(0xff505050)),
                        ),
                      ],
                    ),
                  ),
                ),
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
              text: translation.select_category,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          MyCustomDropDown<String>(
            hintFontSize: 14.0.sp,
            initialValue: quantityViewModel.mStrcategory.value,
            itemList: quantityViewModel.categoryList,
            hintText: translation.select_category,
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
              text: translation.select_material,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          MyCustomDropDown<String>(
            hintFontSize: 14.0.sp,
            initialValue: quantityViewModel.mStrmaterial.value,
            enabled: quantityViewModel.materialList.isEmpty ? false : true,
            itemList: quantityViewModel.materialList,
            hintText: translation.select_material,
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

  Widget get _unitWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.smm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.select_unit,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          MyCustomDropDown<String>(
            hintFontSize: 14.0.sp,
            initialValue: quantityViewModel.mStrUnit.value,
            enabled: quantityViewModel.unitList.isEmpty ? false : true,
            itemList: quantityViewModel.unitList,
            hintText: translation.select_unit,
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
              if (value == null || value == 'Select Unit') {
                return "   ${translation.select_a_unit}";
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
              text: translation.quantity_dispatched,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            ],
            // width: App.appQuery.responsiveWidth(90),
            height: 25,
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
            height: 25,
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
              text: translation.notes,
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
            hint: translation.notes,
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
        height: 45.h,
        borderRadius: BorderRadius.circular(10.0),
        onPressed: () async => {
          Utils.isCheck = true,
          if (_formKey.currentState!.validate())
            {quantityViewModel.addQuantiytToList(context)}
        },
        text: translation.update_quantity,
      ),
    );
  }
}
