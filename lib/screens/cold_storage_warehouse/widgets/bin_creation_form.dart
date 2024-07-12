import 'dart:developer';
import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../../models/storage_type/storage_types.dart';
import '../../../res/colors/app_color.dart';
import '../../../res/components/image_view/svg_asset_image.dart';
import '../../../res/components/text_field/range_text_field.dart';
import '../../../res/variables/var_string.dart';
import '../../../utils/utils.dart';
import '../../../view_models/controller/warehouse/create_warehouse_view_model.dart';
import '../../../view_models/services/app_services.dart';

class BinCreationForm extends StatelessWidget {
  BinCreationForm({
    super.key,
    required this.width,
  });

  final double width;
  final WareHouseViewModel controller = Get.find();
  final _coldStorageBinFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: kBinCardBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Obx(()=>
        Form(
          key: _coldStorageBinFormKey,
          child: Column(
            children: [
              App.appSpacer.vHxs,
              _pageHeadingWidget,
              App.appSpacer.vHs,
              if(controller.entityBinList.isNotEmpty)...[
                _addedBinTile,
                App.appSpacer.vHsm,
                if(!controller.addBinFormOpen.value)...[
                  _addMoreBinTile,
                  App.appSpacer.vHsm,
                ],
                _endLineWidget,
                App.appSpacer.vHs,
              ],
              if(controller.entityBinList.isEmpty && !controller.addBinFormOpen.value)...[
                _addMoreBinTile,
                App.appSpacer.vHs,
              ],
              if(controller.addBinFormOpen.value)...[
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
                App.appSpacer.vHs,
                _addButtonWidget,
                App.appSpacer.vHs,
                _endLineWidget,
              ],
            ],
            ),
        )
      ),
    );
  }

  Widget get _pageHeadingWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          SVGAssetImage(
            width: width*0.25,
            url: horizontalLine,
          ),
          const CustomTextField(
            textAlign: TextAlign.center,
            text: 'Bin Creation',
            fontSize: 16.0,
            fontColor: kAppBlackB,
            fontWeight: FontWeight.w500
          ),
          SVGAssetImage(
            width: width*0.25,
            url: horizontalLine,
          ),
        ],
      ),
    );
  }

  Widget get _binNameWidget{
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Bin Name',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Xyz123',
              controller: controller.binNameC,
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Name', 'Enter bin name');
                  return 'Enter bin name';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text
          ),
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
            textAlign: TextAlign.left,
            text: 'Type Of Storage',
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          Obx(()=>
            MyCustomDropDown<StorageType>(
              itemList: controller.storageTypeList!.value,
              hintText: 'Select Type Of Storage',
              validateOnChange: true,
              headerBuilder: (context, selectedItem, enabled) {
                return Text(selectedItem.name!);
              },
              listItemBuilder: (context, item, isSelected, onItemSelect) {
                return Text(item.name!);
              },
              validator: (value) {
                if (value == null) {
                  Utils.snackBar('Storage', 'Select a storage');
                  return "   Select a storage";
                }
                return null;
              },
              onChange: (item) {
                log('changing value to: ${item?.id}');
                controller.binTypeOfStorageId.value = item!.id.toString() ?? '';
              },
            ),
          ),
          Obx(() {
            if(controller.binTypeOfStorageId.value.toString() == '9') {
              return _otherStorageTypeField;
            }
            return const SizedBox.shrink();
           }
          ),
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
            controller: controller.binOtherStorageNameC,
            focusNode: FocusNode(),
            validating: (value) {
              if (value!.isEmpty) {
                Utils.snackBar('Storage Name', 'Enter storage name');
                return 'Enter storage name';
              }
              return null;
            },
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text
        ),
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
              textAlign: TextAlign.left,
              text: 'Storage Condition',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              minLines: 3,
              maxLines: 3,
              width: App.appQuery.responsiveWidth(90),
              height: 50,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Information',
              controller: controller.binStorageConditionC,
              backgroundColor: Colors.white,
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Bin', 'Enter storage condition');
                  return 'Enter storage condition';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text
          ),
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
              text: 'Capacity',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(90),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Storage Capacity',
              controller: controller.binStorageCapacityC,
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Capacity', 'Enter storage capacity');
                  return 'Enter storage capacity';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text
          ),
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
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RangeTextFormField(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: 'Max Temp',
                buttonText: 'Max',
                controller: controller.binTempRangeMaxC,
                textCapitalization: TextCapitalization.none,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              RangeTextFormField(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: 'Min Temp',
                buttonText: 'Min',
                controller: controller.binTempRangeMinC,
                textCapitalization: TextCapitalization.none,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
              fontColor: Color(0xff1A1A1A)
          ),
          App.appSpacer.vHxxs,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RangeTextFormField(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: 'Max Humidity',
                buttonText: 'Max',
                controller: controller.binHumidityRangeMaxC,
                textCapitalization: TextCapitalization.none,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              RangeTextFormField(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: 'Min Humidity',
                buttonText: 'Min',
                controller: controller.binHumidityRangeMinC,
                textCapitalization: TextCapitalization.none,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _addButtonWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.smm,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyCustomButton(
            width: App.appQuery.responsiveWidth(25)/*312.0*/,
            height: 45,
            borderRadius: BorderRadius.circular(10.0),
            onPressed: () => {
              // if(_coldStorageBinFormKey.currentState!.validate()){
              //   controller.addBinToList(),
                _coldStorageBinFormKey.currentState!.reset(),
                controller.addBinFormOpen.value = false,
            },
            text: 'Close',
          ),
          MyCustomButton(
            width: App.appQuery.responsiveWidth(25)/*312.0*/,
            height: 45,
            borderRadius: BorderRadius.circular(10.0),
            onPressed: () => {
              if(_coldStorageBinFormKey.currentState!.validate()){
                controller.addBinToList(),
                _coldStorageBinFormKey.currentState!.reset(),
                controller.addBinFormOpen.value = false,
              }
              // if(!controller.addBinFormOpen.value && controller.createdBinCount.value == 0){
              //   controller.createdBinCount.value = 1,
              //   print('object 1')
              // }
              // else if(controller.addBinFormOpen.value && controller.createdBinCount.value > 0){
              //   // controller.createdBinCount.value = 1,
              //   controller.addBinFormOpen.value = false,
              //   print('object 2')
              // }
            },
            text: 'Add',
          ),
        ],
      ),
    );
  }

  Widget get _addMoreBinTile{
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                textAlign: TextAlign.left,
                text: controller.entityBinList.isEmpty ? 'Add Bin' :'Add more Bin',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                fontColor: const Color(0xff1A1A1A)
              ),
              InkWell(
                onTap: () {
                  controller.addBinFormOpen.value = true;
                },
                splashColor: kAppPrimary,
                child: SVGAssetImage(
                  width: width*0.10,
                  height: 25,
                  url: addIconSvg,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget get _addedBinTile{
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.entityBinList.length,
      separatorBuilder: (context, index) {
        return App.appSpacer.vHs;
      },
      itemBuilder: (context, index) {
        RxBool editActive = false.obs;
        return Padding(
          padding: App.appSpacer.edgeInsets.x.sm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                textAlign: TextAlign.left,
                text: 'Bin ${index+1}',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                fontColor: kAppBlack
              ),
              App.appSpacer.vHxxs,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: CustomTextFormField(
                      width: 1,
                      height: 25,
                      borderRadius: BorderRadius.circular(10.0),
                      hint: controller.entityBinList[index]['bin_name'],
                      readOnly: true,
                      controller: TextEditingController(),
                      focusNode: FocusNode(),
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.text
                    ),
                  ),
                  App.appSpacer.vWsm,
                  Expanded(
                    flex: 4,
                    child: CustomTextFormField(
                      width: 1,
                      height: 25,
                      borderRadius: BorderRadius.circular(10.0),
                      hint: controller.storageTypeList?[controller.storageTypeList!.indexWhere((value) {
                        return value.id == int.parse(controller.entityBinList[index]['type_of_storage']);
                      },)].name ?? '',
                      readOnly: true,
                      controller: TextEditingController(),
                      focusNode: FocusNode(),
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.text
                    ),
                  ),
                  App.appSpacer.vWsm,
                  Expanded(
                    flex: 4,
                    child: CustomTextFormField(
                      width: 1,
                      height: 25,
                      borderRadius: BorderRadius.circular(10.0),
                      hint: controller.entityBinList[index]['capacity'],
                      readOnly: true,
                      controller: TextEditingController(),
                      focusNode: FocusNode(),
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.text
                    ),
                  ),
                  App.appSpacer.vWxs,
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {

                        },
                        splashColor: kAppPrimary,
                        padding: EdgeInsets.zero,
                        icon: SVGAssetImage(
                          width: width*0.10,
                          height: 25,
                          url: editIconSvg,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              App.appSpacer.vHs,

            ],
          ),
        );
      },
    );
  }

  // Widget get _addedBinEditForm{
  //   return
  // }

  Widget get _endLineWidget {
    return SVGAssetImage(
      width: width*0.85,
      url: horizontalLine,
    );
  }
}
