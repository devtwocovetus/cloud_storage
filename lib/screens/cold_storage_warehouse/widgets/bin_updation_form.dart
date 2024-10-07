import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../../models/storage_type/storage_types.dart';
import '../../../res/components/dropdown/my_custom_drop_down.dart';
import '../../../utils/utils.dart';
import '../../../view_models/controller/warehouse/update/update_bin_view_model.dart';
import '../../../view_models/services/app_services.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class BinUpdationForm extends StatefulWidget {
  const BinUpdationForm({super.key, required this.index});

  final int index;

  @override
  State<BinUpdationForm> createState() => _BinUpdationFormState();
}

class _BinUpdationFormState extends State<BinUpdationForm> {
  final _updateBinFormKey = GlobalKey<FormState>();

  late final UpdateBinViewModel _updateBinViewModel;
   late i18n.Translations translation;

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translation = i18n.Translations.of(context);
  }


  @override
  void initState() {
    _updateBinViewModel = Get.put(UpdateBinViewModel(binIndex: widget.index));
    super.initState();
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
            child: SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     CustomTextField(
                        textAlign: TextAlign.center,
                        text: translation.bin_creation,
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Image.asset(
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
        key: _updateBinFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              App.appSpacer.vHxs,
              _binNameWidget,
              App.appSpacer.vHs,
              _typeOfStorageWidget,
              App.appSpacer.vHs,
              _storageConditionWidget,
              App.appSpacer.vHs,
              _capacityWidget,
              App.appSpacer.vHs,
              _temperatureRangeWidget,
              App.appSpacer.vHs,
              _humidityRangeWidget,
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
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.bin_name,
              controller: _updateBinViewModel.binNameController.value,
              focusNode: _updateBinViewModel.binNameFocusNode.value,
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
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          Obx(() =>
            MyCustomDropDown<StorageType>(
              initialValue: _updateBinViewModel.storageType,
              itemList: _updateBinViewModel.storageTypeList.value,
              hintText: translation.select_type_of_storage,
              validateOnChange: true,
              headerBuilder: (context, selectedItem, enabled) {
                return Text(Utils.textCapitalizationString(selectedItem.name!));
              },
              listItemBuilder: (context, item, isSelected, onItemSelect) {
                return Text(Utils.textCapitalizationString(item.name!));
              },
              validator: (value) {
                if (value == null) {
                  return "   ${translation.select_a_storage}";
                }
                return null;
              },
              onChange: (item) {
                _updateBinViewModel.storageType = item!;
                _updateBinViewModel.storageName.value = item.name!;
              },
            ),
          ),
           _otherStorageTypeField
        ],
      ),
    );
  }

  Widget get _otherStorageTypeField {
    return
      Obx(()=>
      _updateBinViewModel.storageName.value.toLowerCase() == 'other' ? Column(
        children: [
          App.appSpacer.vHxs,
           CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.storage_name,
              controller: _updateBinViewModel.otherStorageTypeController.value,
              focusNode: _updateBinViewModel.otherStorageTypeFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return translation.enter_storage_name;
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ): const SizedBox.shrink(),
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
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              minLines: 3,
              maxLines: 3,
              width: App.appQuery.responsiveWidth(90),
              height: 50,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.information_hint,
              controller: _updateBinViewModel.storageConditionController.value,
              backgroundColor: Colors.white,
              focusNode: _updateBinViewModel.storageConditionFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return translation.enter_storage_condition;
                }else if(value.isNotEmpty){
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
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.storage_capacity,
              controller: _updateBinViewModel.capacityController.value,
              focusNode: _updateBinViewModel.capacityFocusNode.value,
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
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormFieldSmall(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: translation.max_temp,
                buttonText: translation.max_button_text,
                controller: _updateBinViewModel.maxTempController.value,
                focusNode: _updateBinViewModel.maxTempFocusNode.value,
                textCapitalization: TextCapitalization.none,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                validating: (value) {
                  if (_updateBinViewModel.maxTempController.value.text.isEmpty &&
                      value!.isEmpty) {
                    if (_updateBinViewModel
                        .minTempController.value.text.isNotEmpty) {
                      if (value.isEmpty) {
                        return translation.enter_max_temp;
                      }else if(!value.isNum){
                        return translation.must_be_a_number;
                      } else if (value.isNum && double.parse(_updateBinViewModel.minTempController.value.text) >= double.parse(value)) {
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
                hint: translation.min_temp,
                buttonText: translation.min_button_text,
                controller: _updateBinViewModel.minTempController.value,
                focusNode: _updateBinViewModel.minTempFocusNode.value,
                textCapitalization: TextCapitalization.none,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                validating: (value) {
                  if (_updateBinViewModel
                      .maxTempController.value.text.isNotEmpty) {
                    if (value!.isEmpty) {
                      return translation.enter_min_temp;
                    } else if(!value.isNum){
                      return translation.must_be_a_number;
                    }
                    else if (value.isNum && double.parse(
                        _updateBinViewModel.maxTempController.value.text) <=
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
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormFieldSmall(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: translation.max_humidity,
                buttonText: translation.max_button_text,
                controller: _updateBinViewModel.maxHumidityController.value,
                focusNode: _updateBinViewModel.maxHumidityFocusNode.value,
                textCapitalization: TextCapitalization.none,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                validating: (value) {
                  if (_updateBinViewModel
                      .maxHumidityController.value.text.isEmpty &&
                      value!.isEmpty) {
                    if (_updateBinViewModel
                        .minHumidityController.value.text.isNotEmpty) {
                      if (value.isEmpty) {
                        return translation.enter_max_humidity;
                      }else if(!value.isNum){
                        return translation.must_be_a_number;
                      } else if (value.isNum && double.parse(_updateBinViewModel.minHumidityController.value.text) >= double.parse(value)) {
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
                controller: _updateBinViewModel.minHumidityController.value,
                focusNode: _updateBinViewModel.minHumidityFocusNode.value,
                textCapitalization: TextCapitalization.none,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                validating: (value) {
                  if (_updateBinViewModel
                      .maxHumidityController.value.text.isNotEmpty) {
                    if (value!.isEmpty) {
                      return translation.enter_min_humidity;
                    } else if(!value.isNum){
                      return translation.must_be_a_number;
                    } else if (value.isNum && double.parse(_updateBinViewModel
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
        height: 45,
        borderRadius: BorderRadius.circular(10.0),
        onPressed: () async => {
          Utils.isCheck = true,
          if (_updateBinFormKey.currentState!.validate())
            {
              _updateBinViewModel.updateBinToList(context)
              // createBinViewModel.addBinToList(context)
            }
        },
        text: translation.update_bin,
      ),
    );
  }
}
