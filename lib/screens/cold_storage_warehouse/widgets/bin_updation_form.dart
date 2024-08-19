import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../../models/storage_type/storage_types.dart';
import '../../../res/components/dropdown/my_custom_drop_down.dart';
import '../../../utils/utils.dart';
import '../../../view_models/controller/warehouse/update/update_bin_view_model.dart';
import '../../../view_models/services/app_services.dart';

class BinUpdationForm extends StatefulWidget {
  BinUpdationForm({super.key, required this.index});

  final int index;

  @override
  State<BinUpdationForm> createState() => _BinUpdationFormState();
}

class _BinUpdationFormState extends State<BinUpdationForm> {
  final _updateBinFormKey = GlobalKey<FormState>();

  late final UpdateBinViewModel _updateBinViewModel;
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
                padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Bin Creation',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
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
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Bin Name',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Bin name',
              controller: _updateBinViewModel.binNameController.value,
              focusNode: _updateBinViewModel.binNameFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return 'Enter bin name';
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
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Type Of Storage',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          Obx(() =>
            MyCustomDropDown<StorageType>(
              itemList: _updateBinViewModel.storageTypeList.value,
              hintText: 'Select Type Of Storage',
              validateOnChange: true,
              headerBuilder: (context, selectedItem, enabled) {
                return Text(Utils.textCapitalizationString(selectedItem.name!));
              },
              listItemBuilder: (context, item, isSelected, onItemSelect) {
                return Text(Utils.textCapitalizationString(item.name!));
              },
              validator: (value) {
                if (value == null) {
                  return "   Select a storage";
                }
                return null;
              },
              onChange: (item) {
                _updateBinViewModel.storageType?.value = item!;
              },
            ),
          ),
           _otherStorageTypeField
        ],
      ),
    );
  }

  Widget get _otherStorageTypeField {
    return  Obx(() =>
    _updateBinViewModel.storageType?.value.name.toString() == 'Other' ? Column(
        children: [
          App.appSpacer.vHxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Storage Name',
              controller: _updateBinViewModel.otherStorageTypeController.value,
              focusNode: _updateBinViewModel.otherStorageTypeFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return 'Enter storage name';
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
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Storage Condition',
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
              hint: 'Information',
              controller: _updateBinViewModel.storageConditionController.value,
              backgroundColor: Colors.white,
              focusNode: _updateBinViewModel.storageConditionFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Bin', 'Enter storage condition');
                  return 'Enter storage condition';
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
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Storage Capacity',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Storage Capacity',
              controller: _updateBinViewModel.capacityController.value,
              focusNode: _updateBinViewModel.capacityFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Capacity', 'Enter storage capacity');
                  return 'Enter storage capacity';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.number),
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
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Temperature Range (\u00B0C)',
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
                hint: 'Max Temp',
                buttonText: 'Max',
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
                      if (value!.isEmpty) {
                        return 'Enter max temp';
                      }else if(!value.isNum){
                        return 'Must be a number';
                      } else if (value.isNum && double.parse(_updateBinViewModel.minTempController.value.text) >= double.parse(value)) {
                        return 'Must be grater than Max';
                      }
                    }
                  }

                  return null;
                },
              ),
              TextFormFieldSmall(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: 'Min Temp',
                buttonText: 'Min',
                controller: _updateBinViewModel.minTempController.value,
                focusNode: _updateBinViewModel.minTempFocusNode.value,
                textCapitalization: TextCapitalization.none,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                validating: (value) {
                  if (_updateBinViewModel
                      .maxTempController.value.text.isNotEmpty) {
                    if (value!.isEmpty) {
                      return 'Enter min temp';
                    } else if(!value.isNum){
                      return 'Must be a number';
                    }
                    else if (value.isNum && double.parse(
                        _updateBinViewModel.maxTempController.value.text) <=
                        double.parse(value)) {
                      return 'Must be less than Max';
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
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Humidity Range (%)',
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
                hint: 'Max Humidity',
                buttonText: 'Max',
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
                        return 'Enter max humidity';
                      }else if(!value.isNum){
                        return 'Must be a number';
                      } else if (value.isNum && double.parse(_updateBinViewModel.minHumidityController.value.text) >= double.parse(value)) {
                        return 'Must be grater than Max';
                      }
                    }
                  }
                  return null;
                },
              ),
              TextFormFieldSmall(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: 'Min Humidity',
                buttonText: 'Min',
                controller: _updateBinViewModel.minHumidityController.value,
                focusNode: _updateBinViewModel.minHumidityFocusNode.value,
                textCapitalization: TextCapitalization.none,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                validating: (value) {
                  if (_updateBinViewModel
                      .maxHumidityController.value.text.isNotEmpty) {
                    if (value!.isEmpty) {
                      return 'Enter min humidity';
                    } else if(!value.isNum){
                      return 'Must be a number';
                    } else if (value.isNum && double.parse(_updateBinViewModel
                        .maxHumidityController.value.text) <=
                        double.parse(value)) {
                      return 'Must be less than Max';
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
              // createBinViewModel.addBinToList(context)
            }
        },
        text: 'Update Bin',
      ),
    );
  }
}
