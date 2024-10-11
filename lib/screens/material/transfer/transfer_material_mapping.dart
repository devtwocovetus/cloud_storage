import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/transfer/transfer_mapping_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../../res/colors/app_color.dart';
import '../../../res/routes/routes_name.dart';
import '../../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class TransferMaterialMapping extends StatelessWidget {
  TransferMaterialMapping({super.key});
  DateTime selectedDate = DateTime.now();
  final controller = Get.put(TransferMappingViewModel());
  final _coldStorageFormKey = GlobalKey<FormState>();
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
     translation = i18n.Translations.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _addButtonWidget,
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
                        Get.back();
                      },
                      padding: EdgeInsets.zero,
                      icon: Image.asset(
                        height: 15.h,
                        width: 10.h,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text:
                              '${controller.materialName.value.toString()} ${translation.details}',
                          fontSize: 18.0.sp,
                          fontColor: const Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                    ),
                    Obx(
                      () => IconButton(
                          onPressed: () {
                            // _sliderDrawerKey.currentState!.toggle();
                            Get.toNamed(RouteName.profileDashbordSetting)!.then((value) {});
                          },
                          icon: AppCachedImage(
                              roundShape: true,
                              height: 20.h,
                              width: 20.h,
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
                      SizedBox(height: 12.h,),
                      _clientNameWidget,
                      SizedBox(height: 12.h,),
                      _binWidget,
                      SizedBox(height: 12.h,),
                      SizedBox(height: 12.h,),
                      _customMappingWidget,
                      SizedBox(height: 12.h,),
                      SizedBox(height: 12.h,),
                      _restWidget(context),
                      _restDividerWidget0(context),
                      _restCategoryWidget(context),
                      _restDividerWidget2(context),
                      _restMaterialWidget(context),
                      SizedBox(height: 68.h,),
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
                       CustomTextField(
                        textAlign: TextAlign.left,
                        text: translation.vendor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff8F8F8F),
                      ),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: Utils.textCapitalizationString(
                            controller.supplierName.value.toString()),
                        fontSize: 14.sp,
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
                    width: 30.h,
                    height: 30.h,
                  ),
                ),
                SizedBox(
                  width: Utils.deviceWidth(context) * 0.46,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       CustomTextField(
                        textAlign: TextAlign.left,
                        text: translation.your_account,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        fontColor: Color(0xff8F8F8F),
                      ),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text: Utils.textCapitalizationString(
                            controller.receiverName.value.toString()),
                        fontSize: 14.sp,
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
                       CustomTextField(
                          textAlign: TextAlign.left,
                          text: translation.category,
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      SizedBox(height: 8.h,),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text:Utils.textCapitalizationString(controller.categoryName.value.toString()),
                        fontSize: 13.sp,
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
                        width: 30.h,
                        height: 30.h,
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

if(controller.isCustomMapping.value)...[

                      CustomTextField(
                          required: true,
                          textAlign: TextAlign.left,
                          text: translation.category,
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: controller.isCustomMapping.value
                              ? const Color(0xff1A1A1A)
                              : Colors.grey.withOpacity(0.8)),
                        SizedBox(height: 4.h,),
                        MyCustomDropDown<String>(
                        hintFontSize: 14.0.sp,
                        enabled: controller.isCustomMapping.value,
                        initialValue: controller.mStrcategory.value,
                        itemList: controller.categoryList,
                        hintText: translation.select_category,
                        validateOnChange: true,
                        headerBuilder: (context, selectedItem, enabled) {
                          return Text(
                              Utils.textCapitalizationString(selectedItem),
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: kAppBlack,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.5.sp)),
                          );
                        },
                        listItemBuilder:
                            (context, item, isSelected, onItemSelect) {
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
]else...[
   CustomTextField(
                          textAlign: TextAlign.left,
                          text: translation.category,
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
  SizedBox(height: 8.h,),
  CustomTextField(
                        textAlign: TextAlign.left,
                        text:Utils.textCapitalizationString(controller.categoryName.value.toString()),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        fontColor: const Color(0xff474747),
                      ),
]
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
                       CustomTextField(
                          textAlign: TextAlign.left,
                          text: translation.material,
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      SizedBox(height: 8.h,),
                      CustomTextField(
                        textAlign: TextAlign.left,
                        text:Utils.textCapitalizationString(controller.materialName.value.toString()),
                        fontSize: 13.sp,
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
                        width: 30.h,
                        height: 30.h,
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
                      if(controller.isCustomMapping.value)...[
 CustomTextField(
                          required: true,
                          textAlign: TextAlign.left,
                          text: translation.material,
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: controller.isCustomMapping.value
                              ? const Color(0xff1A1A1A)
                              : Colors.grey.withOpacity(0.8)),
                      App.appSpacer.vHxxs,
                      MyCustomDropDown<String>(
                        hintFontSize: 14.0.sp,
                        initialValue: controller.mStrmaterial.value,
                        enabled: controller.materialList.isNotEmpty &&
                                controller.isCustomMapping.value == true
                            ? true
                            : false,
                        itemList: controller.materialList,
                        hintText: translation.select_material,
                        validateOnChange: true,
                        headerBuilder: (context, selectedItem, enabled) {
                          return Text(
                              Utils.textCapitalizationString(selectedItem),
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: kAppBlack,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.5.sp)),
                          );
                        },
                        listItemBuilder:
                            (context, item, isSelected, onItemSelect) {
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
                          controller.mStrmaterial.value = item!.toString();
                        },
                      ),
                      ]else...[
                          CustomTextField(
                          textAlign: TextAlign.left,
                          text: translation.material,
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                        SizedBox(height: 8.h,),
                        CustomTextField(
                        textAlign: TextAlign.left,
                        text:Utils.textCapitalizationString(controller.materialName.value.toString()),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        fontColor: const Color(0xff474747),
                      ),
                      ]
                     
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.entity,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              backgroundColor: Colors.grey.withOpacity(0.2),
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.vendor,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              backgroundColor: Colors.grey.withOpacity(0.2),
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.vendor,
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.need_custom_mapping,
              fontSize: 16.0.sp,
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
                    width: 34.h,
                    height: 20.h,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/ic_switch_off.png',
                    width: 34.h,
                    height: 20.h,
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.select_bin,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          MyCustomDropDown<String>(
            hintFontSize: 14.0.sp,
            itemList: controller.binList,
            hintText: translation.select_bin,
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
        height: 45.h,
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
        text: translation.confirm,
      ),
    );
  }
}
