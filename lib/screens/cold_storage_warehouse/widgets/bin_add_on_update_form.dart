import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../../models/storage_type/storage_types.dart';
import '../../../utils/utils.dart';
import '../../../view_models/controller/warehouse/update/add_bin_on_update_viewmodel.dart';
import '../../../view_models/services/app_services.dart';

class BinAddOnUpdateForm extends StatelessWidget {
  BinAddOnUpdateForm({super.key});

  final addBinOnUpdateViewmodel = Get.put(AddBinOnUpdateViewmodel());
  final _addOnUpdateBinFormKey = GlobalKey<FormState>();

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
        key: _addOnUpdateBinFormKey,
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
              controller: addBinOnUpdateViewmodel.binNameController.value,
              focusNode: addBinOnUpdateViewmodel.binNameFocusNode.value,
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
          Obx(
                () => MyCustomDropDown<StorageType>(
              itemList: addBinOnUpdateViewmodel.storageTypeList.value,
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
                addBinOnUpdateViewmodel.storageType = item!;
                addBinOnUpdateViewmodel.storageName.value = item.name!;
              },
            ),
          ),
          Obx(() {
            if (addBinOnUpdateViewmodel.storageName.value.toLowerCase() == 'other') {
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
        App.appSpacer.vHxs,
        CustomTextFormField(
            width: App.appQuery.responsiveWidth(90),
            height: 25,
            borderRadius: BorderRadius.circular(10.0),
            hint: 'Storage Name',
            controller: addBinOnUpdateViewmodel.otherStorageTypeController.value,
            focusNode: addBinOnUpdateViewmodel.otherStorageTypeFocusNode.value,
            validating: (value) {
              if (value!.isEmpty) {
                return 'Enter storage name';
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
              controller: addBinOnUpdateViewmodel.storageConditionController.value,
              backgroundColor: Colors.white,
              focusNode: addBinOnUpdateViewmodel.storageConditionFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return 'Enter storage condition';
                }else if(value.isNotEmpty){
                  final splitted = value.split(' ');
                  if(splitted.length > 250){
                    return 'Max limit 250 words';
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
              controller: addBinOnUpdateViewmodel.capacityController.value,
              focusNode: addBinOnUpdateViewmodel.capacityFocusNode.value,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              validating: (value) {
                if (value!.isEmpty) {
                  return 'Enter storage capacity';
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
                controller: addBinOnUpdateViewmodel.maxTempController.value,
                focusNode: addBinOnUpdateViewmodel.maxTempFocusNode.value,
                textCapitalization: TextCapitalization.none,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                validating: (value) {
                  if (addBinOnUpdateViewmodel.maxTempController.value.text.isEmpty &&
                      value!.isEmpty) {
                    if (addBinOnUpdateViewmodel
                        .minTempController.value.text.isNotEmpty) {
                      if (value.isEmpty) {
                        return 'Enter max temp';
                      }else if(!value.isNum){
                        return 'Must be a number';
                      } else if (value.isNum && double.parse(addBinOnUpdateViewmodel.minTempController.value.text) >= double.parse(value)) {
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
                controller: addBinOnUpdateViewmodel.minTempController.value,
                focusNode: addBinOnUpdateViewmodel.minTempFocusNode.value,
                textCapitalization: TextCapitalization.none,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                validating: (value) {
                  if (addBinOnUpdateViewmodel
                      .maxTempController.value.text.isNotEmpty) {
                    if (value!.isEmpty) {
                      return 'Enter min temp';
                    } else if(!value.isNum){
                      return 'Must be a number';
                    }
                    else if (value.isNum && double.parse(
                        addBinOnUpdateViewmodel.maxTempController.value.text) <=
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
                controller: addBinOnUpdateViewmodel.maxHumidityController.value,
                focusNode: addBinOnUpdateViewmodel.maxHumidityFocusNode.value,
                textCapitalization: TextCapitalization.none,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                validating: (value) {
                  if (addBinOnUpdateViewmodel
                      .maxHumidityController.value.text.isEmpty &&
                      value!.isEmpty) {
                    if (addBinOnUpdateViewmodel
                        .minHumidityController.value.text.isNotEmpty) {
                      if (value.isEmpty) {
                        return 'Enter max humidity';
                      }else if(!value.isNum){
                        return 'Must be a number';
                      } else if (value.isNum && double.parse(addBinOnUpdateViewmodel.minHumidityController.value.text) >= double.parse(value)) {
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
                controller: addBinOnUpdateViewmodel.minHumidityController.value,
                focusNode: addBinOnUpdateViewmodel.minHumidityFocusNode.value,
                textCapitalization: TextCapitalization.none,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                validating: (value) {
                  if (addBinOnUpdateViewmodel
                      .maxHumidityController.value.text.isNotEmpty) {
                    if (value!.isEmpty) {
                      return 'Enter min humidity';
                    } else if(!value.isNum){
                      return 'Must be a number';
                    } else if (value.isNum && double.parse(addBinOnUpdateViewmodel
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
          if (_addOnUpdateBinFormKey.currentState!.validate())
            {
              addBinOnUpdateViewmodel.addBinToList(context)
            }
        },
        text: 'Add Bin',
      ),
    );
  }
}
