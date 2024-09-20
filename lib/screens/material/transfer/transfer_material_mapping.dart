import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/transfer/transfer_mapping_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../../view_models/controller/user_preference/user_prefrence_view_model.dart';

class TransferMaterialMapping extends StatelessWidget {
  TransferMaterialMapping({super.key});
  DateTime selectedDate = DateTime.now();
  final controller = Get.put(TransferMappingViewModel());
  final _coldStorageFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _addButtonWidget,
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
                    Expanded(
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text:
                              '${controller.materialName.value.toString()} Details',
                          fontSize: 18.0,
                          fontColor: const Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                    ),
                    Obx(
                      () => IconButton(
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                          },
                          icon: AppCachedImage(
                              roundShape: true,
                              height: 20,
                              width: 20,
                              url: UserPreference.profileLogo.value)),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
          child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: App.appSpacer.edgeInsets.y.smm,
              child: Obx(
                () => Form(
                  key: _coldStorageFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _entityNameWidget,
                      App.appSpacer.vHs,
                      _clientNameWidget,
                      App.appSpacer.vHs,
                      _binWidget,
                      App.appSpacer.vHs,
                      App.appSpacer.vHs,
                      _customMappingWidget,
                      App.appSpacer.vHs,
                      App.appSpacer.vHs,
                      _restWidget(context),
                      _restDividerWidget0(context),
                      _restCategoryWidget(context),
                      _restDividerWidget2(context),
                      _restMaterialWidget(context),
                      App.appSpacer.vHs,
                      App.appSpacer.vHxxl,
                      // _addButtonWidget
                    ],
                  ),
                ),
              ))),
    );
  }

  Widget _restWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: App.appSpacer.edgeInsets.x.sm,
          decoration: const BoxDecoration(
            color: Color(0xffEFF8FF),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
            child: Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Supplier',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff8F8F8F),
                      ),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: Utils.textCapitalizationString(
                            controller.supplierName.value.toString()),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontColor: const Color(0xff1A1A1A),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.20,
                  child: Image.asset(
                    'assets/images/ic_group_arrow.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.46,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextField(
                        textAlign: TextAlign.left,
                        text: 'Your Account',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff8F8F8F),
                      ),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: Utils.textCapitalizationString(
                            controller.receiverName.value.toString()),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontColor: const Color(0xff1A1A1A),
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

  Widget _restDividerWidget0(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: App.appSpacer.edgeInsets.x.sm,
            child: Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.25,
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.20,
                  child: const Align(
                    alignment: Alignment.center,
                    child: DottedLine(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.start,
                      lineLength: 10,
                      lineThickness: 2.0,
                      dashLength: 1,
                      dashColor: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.46,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _restDividerWidget2(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0.0, -5.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: App.appSpacer.edgeInsets.x.sm,
            child: Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.25,
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.20,
                  child: const Align(
                    alignment: Alignment.center,
                    child: DottedLine(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.start,
                      lineLength: 20,
                      lineThickness: 2.0,
                      dashLength: 1,
                      dashColor: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.46,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _restDividerWidget3(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0.0, -5.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: App.appSpacer.edgeInsets.x.sm,
            child: Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.30,
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.20,
                  child: const Align(
                    alignment: Alignment.center,
                    child: DottedLine(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.start,
                      lineLength: 20,
                      lineThickness: 2.0,
                      dashLength: 1,
                      dashColor: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.41,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _restCategoryWidget(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0.0, -2.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: App.appSpacer.edgeInsets.x.sm,
            child: Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Category',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      App.appSpacer.vHxxs,
                      App.appSpacer.vHxxs,
                       CustomTextField(
                        textAlign: TextAlign.left,
                        text:Utils.textCapitalizationString(controller.categoryName.value.toString()),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontColor: const Color(0xff474747),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.20,
                  child: Column(
                    children: [
                      SizedBox(
                        width: Utils.deviceWidth(context) * 0.20,
                        child: const Align(
                          alignment: Alignment.center,
                          child: DottedLine(
                            direction: Axis.vertical,
                            alignment: WrapAlignment.center,
                            lineLength: 20,
                            lineThickness: 2.0,
                            dashLength: 1,
                            dashColor: Colors.black,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/ic_group_arrow.png',
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                        width: Utils.deviceWidth(context) * 0.20,
                        child: const Align(
                          alignment: Alignment.center,
                          child: DottedLine(
                            direction: Axis.vertical,
                            alignment: WrapAlignment.center,
                            lineLength: 20,
                            lineThickness: 2.0,
                            dashLength: 1,
                            dashColor: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.46,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                          required: true,
                          textAlign: TextAlign.left,
                          text: 'Category',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor: controller.isCustomMapping.value
                              ? const Color(0xff1A1A1A)
                              : Colors.grey.withOpacity(0.8)),
                      App.appSpacer.vHxxs,
                      MyCustomDropDown<String>(
                        enabled: controller.isCustomMapping.value,
                        initialValue: controller.mStrcategory.value,
                        itemList: controller.categoryList,
                        hintText: 'Select Category',
                        validateOnChange: true,
                        headerBuilder: (context, selectedItem, enabled) {
                          return Text(
                              Utils.textCapitalizationString(selectedItem));
                        },
                        listItemBuilder:
                            (context, item, isSelected, onItemSelect) {
                          return Text(Utils.textCapitalizationString(item));
                        },
                        validator: (value) {
                          if (value == null || value == 'Select Category') {
                            return "   Select a category";
                          }
                          return null;
                        },
                        onChange: (item) async {
                          // controller.mStrUnit.value = 'Select Unit'; if (controller.categoryList[0] == 'Select Category') {
                          //   controller.categoryList.removeAt(0);
                          //   controller.categoryListId.removeAt(0);
                          // }
                          controller.mStrcategory.value = item!.toString();
                          controller.mStrmaterial.value = 'Select Material';
                          await controller
                              .getMaterial(controller.mStrcategory.value);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _restMaterialWidget(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0.0, -5.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: App.appSpacer.edgeInsets.x.sm,
            child: Row(
              children: [
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Material',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      App.appSpacer.vHxxs,
                      App.appSpacer.vHxxs,
                       CustomTextField(
                        textAlign: TextAlign.left,
                        text:Utils.textCapitalizationString(controller.materialName.value.toString()),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontColor: const Color(0xff474747),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.20,
                  child: Column(
                    children: [
                      SizedBox(
                        width: Utils.deviceWidth(context) * 0.20,
                        child: const Align(
                          alignment: Alignment.center,
                          child: DottedLine(
                            direction: Axis.vertical,
                            alignment: WrapAlignment.center,
                            lineLength: 20,
                            lineThickness: 2.0,
                            dashLength: 1,
                            dashColor: Colors.black,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/ic_group_arrow.png',
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                        width: Utils.deviceWidth(context) * 0.20,
                        child: const Align(
                          alignment: Alignment.center,
                          child: DottedLine(
                            direction: Axis.vertical,
                            alignment: WrapAlignment.center,
                            lineLength: 20,
                            lineThickness: 2.0,
                            dashLength: 1,
                            dashColor: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.46,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                          required: true,
                          textAlign: TextAlign.left,
                          text: 'Material',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor: controller.isCustomMapping.value
                              ? const Color(0xff1A1A1A)
                              : Colors.grey.withOpacity(0.8)),
                      App.appSpacer.vHxxs,
                      MyCustomDropDown<String>(
                        initialValue: controller.mStrmaterial.value,
                        enabled: controller.materialList.isNotEmpty &&
                                controller.isCustomMapping.value == true
                            ? true
                            : false,
                        itemList: controller.materialList,
                        hintText: 'Select Material',
                        validateOnChange: true,
                        headerBuilder: (context, selectedItem, enabled) {
                          return Text(
                              Utils.textCapitalizationString(selectedItem));
                        },
                        listItemBuilder:
                            (context, item, isSelected, onItemSelect) {
                          return Text(Utils.textCapitalizationString(item));
                        },
                        validator: (value) {
                          if (value == null || value == 'Select Material') {
                            return "   Select a material name";
                          }
                          return null;
                        },
                        onChange: (item) {
                          controller.mStrmaterial.value = item!.toString();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget get _entityNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Entity',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              backgroundColor: Colors.grey.withOpacity(0.2),
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Entity Name',
              readOnly: true,
              controller: controller.entityNameController.value,
              focusNode: controller.entityNameFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _clientNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Client',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              backgroundColor: Colors.grey.withOpacity(0.2),
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: 'Client Name',
              readOnly: true,
              controller: controller.clientNameController.value,
              focusNode: controller.clientNameFocusNode.value,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }


  Widget get _customMappingWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Row(
        children: [
          const CustomTextField(
              textAlign: TextAlign.left,
              text: 'Need Custom Mapping',
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          const Spacer(),
          GestureDetector(
            onTap: () {
              controller.isCustomMapping.value =
                  !controller.isCustomMapping.value;
            },
            child: controller.isCustomMapping.value
                ? Image.asset(
                    'assets/images/ic_switch_on.png',
                    width: 34,
                    height: 20,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/ic_switch_off.png',
                    width: 34,
                    height: 20,
                    fit: BoxFit.cover,
                  ),
          ),
        ],
      ),
    );
  }

  Widget get _binWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
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
            itemList: controller.binList,
            hintText: 'Select Bin',
            validateOnChange: true,
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },
            onChange: (item) {
              controller.mStrBin.value = item!.toString();
            },
          ),
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
        onPressed: () async => {
          if (controller.isCustomMapping.value)
            {
              if (_coldStorageFormKey.currentState!.validate())
                {controller.addQuantiytToList()}
            }
          else
            {controller.autoMappingData()}
        },
        text: 'Confirm',
      ),
    );
  }
}
