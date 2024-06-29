import 'dart:developer';

import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../../res/colors/app_color.dart';
import '../../../res/components/image_view/svg_asset_image.dart';
import '../../../res/components/text_field/range_text_field.dart';
import '../../../res/variables/var_string.dart';
import '../../../utils/utils.dart';
import '../../../view_models/services/app_services.dart';

class BinCreationForm extends StatelessWidget {
  BinCreationForm({
    super.key,
    required this.width,
    this.createdBinCount = 0,
    this.addBinFormOpen = false
  });

  final double width;
  int createdBinCount;
  bool addBinFormOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: kBinCardBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          App.appSpacer.vHxs,
          _pageHeadingWidget,
          App.appSpacer.vHs,
          if(createdBinCount > 0 )...[
            _addedBinTile,
            App.appSpacer.vHsm,
            if(!addBinFormOpen)...[
              _addMoreBinTile,
              App.appSpacer.vHsm,
            ],
            _endLineWidget,
            App.appSpacer.vHs,
          ],
          if(createdBinCount == 0 || addBinFormOpen)...[
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
              controller: TextEditingController(),
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Name', 'Enter bin name');
                  return '';
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
          MyCustomDropDown(
            itemList: const [
              'Developer',
              'Designer',
              'Consultant',
              'Student',
            ],
            hintText: 'Select Type Of Change',
            validator: (value) {
                return value == null ? "Must not be null" : null;
            },
            onChange: (item) {
              log('changing value to: $item');
            },
            validateOnChange: true,
          ),
        ],
      ),
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
              controller: TextEditingController(),
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Bin', 'Enter storage condition');
                  return '';
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
              controller: TextEditingController(),
              focusNode: FocusNode(),
              validating: (value) {
                if (value!.isEmpty) {
                  Utils.snackBar('Capacity', 'Enter storage capacity');
                  return '';
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
      padding: App.appSpacer.edgeInsets.x.sm,
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
                controller: TextEditingController(),
                textCapitalization: TextCapitalization.none,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              RangeTextFormField(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: 'Min Temp',
                buttonText: 'Min',
                controller: TextEditingController(),
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
      padding: App.appSpacer.edgeInsets.x.sm,
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
                controller: TextEditingController(),
                textCapitalization: TextCapitalization.none,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              RangeTextFormField(
                width: App.appQuery.responsiveWidth(43),
                height: App.appQuery.responsiveWidth(10),
                hint: 'Min Humidity',
                buttonText: 'Min',
                controller: TextEditingController(),
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
    return MyCustomButton(
      width: App.appQuery.responsiveWidth(25)/*312.0*/,
      height: 45,
      borderRadius: BorderRadius.circular(10.0),
      onPressed: () => {

      },
      text: 'Add',
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
              const CustomTextField(
                textAlign: TextAlign.left,
                text: 'Add more Bin',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                fontColor: Color(0xff1A1A1A)
              ),
              InkWell(
                onTap: () {

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
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Bin 1',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)
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
                    hint: 'ABCDE12300',
                    readOnly: true,
                    controller: TextEditingController(),
                    focusNode: FocusNode(),
                    validating: (value) {
                      if (value!.isEmpty) {
                        Utils.snackBar('ABCDE12300', 'Enter ABCDE12300');
                        return '';
                      }
                      return null;
                    },
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
                    hint: 'Freezer',
                    readOnly: true,
                    controller: TextEditingController(),
                    focusNode: FocusNode(),
                    validating: (value) {
                      if (value!.isEmpty) {
                        Utils.snackBar('Freezer', 'Enter Freezer');
                        return '';
                      }
                      return null;
                    },
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
                    hint: '1 Ton',
                    readOnly: true,
                    controller: TextEditingController(),
                    focusNode: FocusNode(),
                    validating: (value) {
                      if (value!.isEmpty) {
                        Utils.snackBar('Capacity', 'Enter storage capacity');
                        return '';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.text
                ),
              ),
              App.appSpacer.vWsm,
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {

                    },
                    splashColor: kAppPrimary,
                    child: SVGAssetImage(
                      width: width*0.10,
                      height: 25,
                      url: editIconSvg,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _endLineWidget {
    return SVGAssetImage(
      width: width*0.85,
      url: horizontalLine,
    );
  }
}
