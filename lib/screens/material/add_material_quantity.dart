import 'dart:developer';

import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/screens/material/widgets/add_specification_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../models/material/quality_type_model.dart';
import '../../res/components/dropdown/my_custom_drop_down.dart';
import '../../res/components/image_view/svg_asset_image.dart';
import '../../res/components/tags_text_field/tag_text_field.dart';
import '../../res/variables/var_string.dart';
import '../../utils/utils.dart';
import '../../view_models/controller/material/material_view_model.dart';
import '../../view_models/services/app_services.dart';

class AddMaterialQuantity extends StatelessWidget {
  AddMaterialQuantity({super.key});

  final MaterialViewModel controller = Get.put(MaterialViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: _addButtonWidget,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                        Get.back();
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
                        text: 'Add Material Quantity',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                        const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              // _sliderDrawerKey.currentState!.toggle();
                            },
                            icon: Image.asset(
                              height: 20,
                              width: 20,
                              'assets/images/ic_notification_bell.png',
                              fit: BoxFit.cover,
                            )),
                        Obx(
                          () => IconButton(
                              onPressed: () {
                                // _sliderDrawerKey.currentState!.toggle();
                              },
                              icon: AppCachedImage(
                                  roundShape: true,
                                  height: 25,
                                  width: 25,
                                  url: controller.logoUrl.value)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: App.appSpacer.edgeInsets.y.smm,
          child: Form(
              key: controller.addMaterialFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Utils.deviceWidth(context) * 0.04,
                        0,
                        Utils.deviceWidth(context) * 0.04,
                        0),
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                            textAlign: TextAlign.center,
                            text: controller.materialCategory
                                .toString().length > 20 ? '${controller.materialCategory
                                .toString().substring(0,20)}...'
                                : controller.materialCategory
                                .toString(),
                            fontSize: 16.0,
                            fontColor: const Color(0xFF000000),
                            fontWeight: FontWeight.w500),
                        const SizedBox(
                          width: 3,
                        ),
                        Image.asset(
                          'assets/images/ic_forward_black.png',
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Expanded(
                          child: CustomTextField(
                              textAlign: TextAlign.center,
                              text: controller.materialName.toString(),
                              fontSize: 16.0,
                              fontColor: const Color(0xFF000000),
                              fontWeight: FontWeight.w500),
                        ),
                        Image.asset(
                          'assets/images/ic_forward_black.png',
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        const Expanded(
                          child: CustomTextField(
                              textAlign: TextAlign.center,
                              text: 'Create Unit',
                              fontSize: 16.0,
                              fontColor: Color(0xFF000000),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  App.appSpacer.vHs,
                  _unitNameWidget,
                  App.appSpacer.vHs,
                  _qualityTypeWidget,
                  App.appSpacer.vHs,
                  _unitValue,
                  App.appSpacer.vHs,
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Utils.deviceWidth(context) * 0.04,
                        0,
                        Utils.deviceWidth(context) * 0.04,
                        0),
                    child: const CustomTextField(
                        required: true,
                        textAlign: TextAlign.left,
                        text: 'Measurement Of Unit',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        fontColor: Color(0xff1A1A1A)),
                  ),
                  App.appSpacer.vHxxs,
                  measurementUnitsWidget(context),
                  App.appSpacer.vHs,
                  App.appSpacer.vHsm,
                  AddSpecificationCard(width: App.appQuery.width),
                  App.appSpacer.vHsm,
                  _additionHeadingWidget,
                  App.appSpacer.vHsm,
                  _storageConditions,
                  App.appSpacer.vHs,
                  _safetyDataWidget,
                  App.appSpacer.vHs,
                  _complianceCertificates,
                  App.appSpacer.vHs,
                  _regulatoryInformationWidget,
                  App.appSpacer.vHs,
                  App.appSpacer.vHxxl,
                  // _addButtonWidget
                ],
              )),
        ),
      ),
    );
  }

  Widget get _unitNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Unit Name',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Enter Name Of Unit',
              controller: controller.unitNameC.value,
              focusNode: controller.unitNameCFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return 'Enter unit name';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _unitValue {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Unit quantity',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Enter quantity',
              controller: controller.unitValueC.value,
              focusNode: controller.unitValueCFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return 'Enter unit quantity';
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.number),
        ],
      ),
    );
  }

  Widget get _qualityTypeWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Quality type',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          Obx(
            () => MyCustomDropDown<QualityType>(
              itemList: controller.qualityTypeTypeList!.value,
              hintText: 'Quality Type',
              validateOnChange: true,
              headerBuilder: (context, selectedItem, enabled) {
                return Text(Utils.textCapitalizationString(selectedItem.name!));
              },
              listItemBuilder: (context, item, isSelected, onItemSelect) {
                return Text(Utils.textCapitalizationString(item.name!));
              },
              validator: (value) {
                if (value == null) {
                  return "   Select a quality type";
                }
                return null;
              },
              onChange: (item) {
                controller.quantityTypeId = item?.id.toString() ?? '';
                log('changing value to: ${controller.quantityTypeId}');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget get _additionHeadingWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          SVGAssetImage(
            width: App.appQuery.responsiveWidth(20),
            url: horizontalLine,
          ),
          const Expanded(
            child: CustomTextField(
                textAlign: TextAlign.center,
                text: 'Additional Information',
                fontSize: 16.0,
                fontColor: kAppBlackB,
                fontWeight: FontWeight.w500),
          ),
          SVGAssetImage(
            width: App.appQuery.responsiveWidth(20),
            url: horizontalLine,
          ),
        ],
      ),
    );
  }

  Widget get _storageConditions {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Storage Conditions',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          TagsTextField(
            stringTagController: controller.storageConditionsTagController,
            textFieldTagValues: controller.storageConditionsFieldValues,
            hintText1: 'Add Storage Conditions',
            hintText2: 'Enter tag...',
            onAddButtonTap: () {
              if (controller.storageConditionsFieldValues.value
                  .textEditingController.text.isNotEmpty) {
                controller.storageConditionsFieldValues.value.onTagSubmitted(
                    controller.storageConditionsFieldValues.value
                        .textEditingController.text);
                // controller.storageConditionsTagsList.value =
                //     controller.storageConditionsFieldValues.value.tags;
                controller.storageConditionsTagsList.value.addAll(controller.storageConditionsFieldValues.value.tags);
                controller.storageConditionsTagsList.value = controller.storageConditionsTagsList.value.toSet().toList();
                controller.storageConditionsFieldValues.value.tags = controller.storageConditionsTagsList.value;
                controller.visibleStorageConditionsTagField.value = false;
              }
            },
            tagsList: controller.storageConditionsTagsList,
            tagScrollController: controller.storageConditionsTagScroller,
            visibleTagField: controller.visibleStorageConditionsTagField,
          ),
        ],
      ),
    );
  }

  Widget get _safetyDataWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Safety Data',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              minLines: 2,
              maxLines: 3,
              width: App.appQuery.responsiveWidth(100),
              height: 50,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Brief safety data or handling instructions.',
              controller: controller.safetyDataC.value,
              focusNode: controller.safetyDataCFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _complianceCertificates {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Compliance Certificates',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          TagsTextField(
            stringTagController: controller.complianceTagController,
            textFieldTagValues: controller.complianceFieldValues,
            hintText1: 'Add Certificate',
            hintText2: 'Enter tag...',
            onAddButtonTap: () {
              if (controller.complianceFieldValues.value.textEditingController
                  .text.isNotEmpty) {
                controller.complianceFieldValues.value.onTagSubmitted(controller
                    .complianceFieldValues.value.textEditingController.text);
                // controller.complianceTagsList.value =
                //     controller.complianceFieldValues.value.tags;
                controller.complianceTagsList.value.addAll(controller.complianceFieldValues.value.tags);
                controller.complianceTagsList.value = controller.complianceTagsList.value.toSet().toList();
                controller.complianceFieldValues.value.tags = controller.complianceTagsList.value;
                controller.visibleComplianceTagField.value = false;
              }
            },
            tagsList: controller.complianceTagsList,
            tagScrollController: controller.complianceTagScroller,
            visibleTagField: controller.visibleComplianceTagField,
          ),
        ],
      ),
    );
  }

  Widget get _regulatoryInformationWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Regulatory Information',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              minLines: 2,
              maxLines: 3,
              width: App.appQuery.responsiveWidth(100),
              height: 50,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Regulatory information or restrictions.',
              controller: controller.regulatoryInformationC.value,
              focusNode: controller.regulatoryInformationCFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _addButtonWidget {
    return Align(
      alignment: Alignment.bottomCenter,
      child: MyCustomButton(
        width: App.appQuery.responsiveWidth(70) /*312.0*/,
        height: 45,
        borderRadius: BorderRadius.circular(10.0),
        onPressed: () async {
          Utils.isCheck = true;
          if (controller.addMaterialFormKey.currentState!.validate()) {
            await controller.addMaterialUnit();
            // await controller.addColdStorage2()
          }
        },
        text: 'Create',
      ),
    );
  }

  Widget get _unitTypeDropDownWidget {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
        margin: const EdgeInsets.fromLTRB(3, 3, 10, 3),
        //width: 300.0,
        child: const CustomTextField(
            textAlign: TextAlign.left,
            text: 'Regulatory',
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontColor: Color(0xff1A1A1A)));
  }

  Widget get _unitMouDropDownWidget {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
        margin: const EdgeInsets.fromLTRB(3, 3, 10, 3),
        //width: 300.0,
        child: const CustomTextField(
            textAlign: TextAlign.center,
            text: 'Regulatory',
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontColor: Color(0xff1A1A1A)));
  }

  Widget measurementUnitsWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.04, 0,
          Utils.deviceWidth(context) * 0.04, 0),
      padding: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.04, 10,
          Utils.deviceWidth(context) * 0.04, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kDisableField,
        border: Border.all(width: 1, color: Colors.grey),
      ),
      width: double.infinity,
      child:  IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: CustomTextField(
                    textAlign: TextAlign.center,
                    text: controller.mOUType.value.toString(),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontColor: const Color(0xff1A1A1A))),
            const VerticalDivider(),
            Expanded(
                child: CustomTextField(
                    textAlign: TextAlign.center,
                   text: controller.mouName.value.toString(),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontColor: const Color(0xff1A1A1A))),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color color, double width) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }
}
