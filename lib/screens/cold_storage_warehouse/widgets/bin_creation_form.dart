import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/view_models/controller/warehouse/create_bin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../../res/colors/app_color.dart';
import '../../../utils/utils.dart';
import '../../../view_models/services/app_services.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class BinCreationForm extends StatelessWidget {
  BinCreationForm({super.key});

  final createBinViewModel = Get.put(CreateBinViewModel());
  final _formKey = GlobalKey<FormState>();
  late i18n.Translations translation;

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
                        text: translation.bin_creation,
                        fontSize: 18.0.sp,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Image.asset(
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
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              SizedBox(height: 8.h,),
              _binNameWidget,
              SizedBox(height: 12.h,),
              _typeOfStorageWidget,
              SizedBox(height: 12.h,),
              _storageConditionWidget,
              SizedBox(height: 12.h,),
              _capacityWidget,
              SizedBox(height: 12.h,),
              _temperatureRangeWidget,
              SizedBox(height: 12.h,),
              _humidityRangeWidget,
              SizedBox(height: 120.h,),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _binNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.bin_name,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.bin_name,
              controller: createBinViewModel.binNameController.value,
              focusNode: createBinViewModel.binNameFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return translation.enter_bin_name;
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _typeOfStorageWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.smm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.type_of_storage,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          Obx(
            () => MyCustomDropDown<String>(
              hintFontSize: 14.0.sp,
              itemList: createBinViewModel.storageTypeList.value,
              hintText: translation.select_type_of_storage,
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
                if (value == null) {
                  return "   ${translation.select_a_storage}";
                }
                return null;
              },
              onChange: (item) {
                createBinViewModel.storageType.value = item!.toString();
              },
            ),
          ),
          Obx(() {
            if (createBinViewModel.storageType.value.toString() == 'Other') {
              return _otherStorageTypeField;
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget get _otherStorageTypeField {
    return Column(
      children: [
        SizedBox(height: 8.h,),
        CustomTextFormField(
            width: App.appQuery.responsiveWidth(100),
            height: 25.h,
            borderRadius: BorderRadius.circular(10.0),
            hint: translation.storage_name,
            controller: createBinViewModel.otherStorageTypeController.value,
            focusNode: createBinViewModel.otherStorageTypeFocusNode.value,
            validating: (value) {
              if (value!.isEmpty) {
                return translation.enter_storage_name;
              }
              return null;
            },
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text),
      ],
    );
  }

  Widget get _storageConditionWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.storage_condition,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              minLines: 3,
              maxLines: 3,
              width: App.appQuery.responsiveWidth(100),
              height: 50.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.information_hint,
              controller: createBinViewModel.storageConditionController.value,
              backgroundColor: Colors.white,
              focusNode: createBinViewModel.storageConditionFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return translation.enter_storage_condition;
                }
                else if(value.isNotEmpty){
                  final splitted = value.split(' ');
                  if(splitted.length > 250){
                    return translation.max_limit_250_words;
                  }
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _capacityWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.storage_capacity,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.storage_capacity,
              controller: createBinViewModel.capacityController.value,
              focusNode: createBinViewModel.capacityFocusNode.value,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              validating: (value) {
                if (value!.isEmpty) {
                  return translation.enter_storage_capacity;
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: const TextInputType.numberWithOptions(decimal: true,signed: true)),
        ],
      ),
    );
  }

  Widget get _temperatureRangeWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.smm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.temperature_range,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormFieldSmall(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: translation.max_temp,
                buttonText: translation.max_button_text,
                controller: createBinViewModel.maxTempController.value,
                focusNode: createBinViewModel.maxTempFocusNode.value,
                textCapitalization: TextCapitalization.none,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validating: (value) {
                  if (createBinViewModel.maxTempController.value.text.isEmpty &&
                      value!.isEmpty) {
                    if (createBinViewModel
                        .minTempController.value.text.isNotEmpty) {
                      if (value!.isEmpty) {
                        return translation.enter_max_temp;
                      }else if(!value.isNum){
                        return translation.must_be_a_number;
                      } else if (value.isNum && double.parse(createBinViewModel.minTempController.value.text) >= double.parse(value)) {
                        return translation.must_be_a_number;
                      }
                    }
                  }

                  return null;
                },
              ),
              TextFormFieldSmall(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: translation.min_temp,
                buttonText: translation.min_button_text,
                controller: createBinViewModel.minTempController.value,
                focusNode: createBinViewModel.minTempFocusNode.value,
                textCapitalization: TextCapitalization.none,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validating: (value) {
                  if (createBinViewModel
                      .maxTempController.value.text.isNotEmpty) {
                    if (value!.isEmpty) {
                      return translation.enter_min_temp;
                    } else if(!value.isNum){
                      return translation.must_be_a_number;
                    }
                    else if (value.isNum && double.parse(
                            createBinViewModel.maxTempController.value.text) <=
                        double.parse(value)) {
                      return translation.must_be_less_than_max;
                    }
                  }

                  return null;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _humidityRangeWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.smm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.humidity_range,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormFieldSmall(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: translation.max_humidity,
                buttonText: translation.max_button_text,
                controller: createBinViewModel.maxHumidityController.value,
                focusNode: createBinViewModel.maxHumidityFocusNode.value,
                textCapitalization: TextCapitalization.none,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validating: (value) {
                  if (createBinViewModel
                          .maxHumidityController.value.text.isEmpty &&
                      value!.isEmpty) {
                    if (createBinViewModel
                        .minHumidityController.value.text.isNotEmpty) {
                      if (value.isEmpty) {
                        return translation.enter_max_humidity;
                      }else if(!value.isNum){
                        return translation.must_be_a_number;
                      } else if (value.isNum && double.parse(createBinViewModel.minHumidityController.value.text) >= double.parse(value)) {
                        return translation.must_be_greater_than_max;
                      }
                    }
                  }
                  return null;
                },
              ),
              TextFormFieldSmall(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: translation.min_humidity,
                buttonText: translation.min_button_text,
                controller: createBinViewModel.minHumidityController.value,
                focusNode: createBinViewModel.minHumidityFocusNode.value,
                textCapitalization: TextCapitalization.none,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validating: (value) {
                  if (createBinViewModel
                      .maxHumidityController.value.text.isNotEmpty) {
                    if (value!.isEmpty) {
                      return translation.enter_min_humidity;
                    } else if(!value.isNum){
                      return translation.must_be_a_number;
                    } else if (value.isNum && double.parse(createBinViewModel
                            .maxHumidityController.value.text) <=
                        double.parse(value)) {
                      return translation.must_be_less_than_max;
                    }
                  }

                  return null;
                },
              ),
            ],
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
            {createBinViewModel.addBinToList(context)}
        },
        text: translation.add_bin,
      ),
    );
  }
}
