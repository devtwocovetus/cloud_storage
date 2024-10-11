import 'dart:io';
import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/res/components/image_view/svg_asset_image.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/res/variables/var_string.dart';
import 'package:cold_storage_flutter/screens/material/material_out/widgets/signature_pad_out.dart';
import 'package:cold_storage_flutter/screens/material/widgets/dialog_utils.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/material_out/material_out_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class MaterialOut extends StatelessWidget {
  MaterialOut({super.key});
  DateTime selectedDate = DateTime.now();
  final controller = Get.put(MaterialOutViewModel());
  final _coldStorageFormKey = GlobalKey<FormState>();
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
     translation = i18n.Translations.of(context);
    print('<><><><>value ${controller.isManual.value}');
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(() => Visibility(
          visible: !showFab,
          child: controller.isConfirm.value
              ? bottomGestureButtons(context)
              : _addButtonWidget)),
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
                          text: translation.material_out,
                          fontSize: 18.0.sp,
                          fontColor: Color(0xFF000000),
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
                              url: UserPreference.profileLogo.value)
                      ),
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
                      _customerNameWidget,
                      if (controller.isManual.value != '1' &&
                          controller.isManual.value != '5') ...[
                        SizedBox(height: 12.h,),
                        _entityListWidget,
                      ],

                      SizedBox(height: 12.h,),
                      _dateWidget(context),
                      if (!controller.isConfirm.value) ...[
                        SizedBox(height: 12.h,),
                        _addedBinTile(context),
                      ],

                      if (controller.isConfirm.value) ...[
                        SizedBox(height: 12.h,),
                        _addedConfirmTile(context),
                      ],

                      SizedBox(height: 68.h,),
                      // _addButtonWidget
                    ],
                  ),
                ),
              ))),
    );
  }

  Widget get _entityNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.entity,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
            backgroundColor: kBinCardBackground,
              readOnly: true,
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.entity,
              controller: controller.entityNameController.value,
              focusNode: controller.entityNameFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return translation.enter_entity_name;
                }
                return null;
              },
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  

  Widget get _customerNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.customer,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          MyCustomDropDown<String>(
            hintFontSize: 14.0.sp,
            enabled: controller.isConfirm.value ? false : true,
            itemList: controller.clientCustomerList,
            hintText: translation.select,
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
                return "   ${translation.select_customer_name}";
              }
              return null;
            },
            onChange: (item) {
              controller.mStrCustomerClient.value = item.toString();
              int index = controller.clientCustomerList
                  .indexOf(controller.mStrCustomerClient.value);
              controller.isManual.value =
                  controller.clientCustomerListManual[index];
                  controller.getCustomerEntity(controller.clientCustomerListId[index].toString());
            },
          ),
        ],
      ),
    );
  }

  Widget get _entityListWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.entity,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          MyCustomDropDown<String>(
            hintFontSize: 14.0.sp,
            enabled: controller.isConfirm.value ? false : true,
            itemList: controller.entityList,
            hintText: translation.select_entity,
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
                return "   Select a entity";
              }
              return null;
            },
            onChange: (item) {
              controller.mStrEntity.value = item.toString();
            },
          ),
        ],
      ),
    );
  }

  Widget _dateWidget(BuildContext context) {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.date_of_dispatch,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              readOnly: true,
              backgroundColor: controller.isConfirm.value ? Colors.grey.withOpacity(0.2) : const Color(0xffffffff),
              onTab: () async {
                if (!controller.isConfirm.value) {
                  await _selectDate(context);
                }
              },
              suffixIcon: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 2),
                child: Image.asset(
                  'assets/images/ic_calender.png',
                ),
              ),
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.date_of_dispatch,
              controller: controller.dateController.value,
              focusNode: controller.dateFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return translation.select_date_of_dispatch;
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    print('<><><><><>callll');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        locale: Locale(i18n.LocaleSettings.currentLocale.languageCode),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      controller.dateController.value.text =
          DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Widget get _addButtonWidget {
    return Align(
      alignment: Alignment.bottomCenter,
      child: MyCustomButton(
        width: App.appQuery.responsiveWidth(70) /*312.0*/,
        height: 45.h,
        borderRadius: BorderRadius.circular(10.0),
        onPressed: () async => {
          if (_coldStorageFormKey.currentState!.validate())
            {
              if (controller.entityQuantityList.isNotEmpty)
                {controller.isConfirm.value = true}
              else
                {
                  Utils.isCheck = true,
                  Utils.snackBar(translation.error, translation.please_add_quantity)
                }
            }
        },
        text: translation.confirm,
      ),
    );
  }

  Widget bottomGestureButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyCustomButton(
          width: App.appQuery.responsiveWidth(35) /*312.0*/,
          height: 45.h,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {controller.isConfirm.value = false},
          text: translation.back,
        ),
        MyCustomButton(
          width: App.appQuery.responsiveWidth(35) /*312.0*/,
          height: 45.h,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {
            if (_coldStorageFormKey.currentState!.validate()){
              if(controller.signatureFilePath.value.isNotEmpty){
                DialogUtils.showCustomDialog(
                  context,
                  okBtnFunction: () {
                    Get.back(closeOverlays: true);
                    controller.addMaterialOut();
                  },
                )
              }else{
                Utils.isCheck = true,
                Utils.snackBar(translation.error, translation.please_add_signature)
              },
            }
          },
          text: translation.generate,
        )
      ],
    );
  }

  Widget _addedBinTile(BuildContext context) {
    return controller.entityQuantityList.isNotEmpty
        ? Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            decoration: BoxDecoration(
              color: kBinCardBackground,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                SizedBox(height: 12.h,),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      App.appSpacer.sm, 0, App.appSpacer.sm, App.appSpacer.sm),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: '.......................',
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      Spacer(),
                      CustomTextField(
                          textAlign: TextAlign.center,
                          text: translation.quantity,
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      Spacer(),
                      CustomTextField(
                          textAlign: TextAlign.right,
                          text: '.......................',
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A))
                    ],
                  ),
                ),
                SizedBox(height: 12.h,),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      App.appSpacer.sm, 0, App.appSpacer.sm, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextField(
                        required: controller.entityQuantityList.isEmpty ? true : false,
                          textAlign: TextAlign.left,
                          text: controller.entityQuantityList.isEmpty
                              ? translation.add_quantity
                              : translation.add_more_quantity,
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xff1A1A1A)),
                      InkWell(
                        onTap: () {
                       
                            Get.toNamed(
                                RouteName.quantityCreationMaterialoutScreen,
                                arguments: [
                                  {
                                    "entityName": controller.entityName.value,
                                    "entityId": controller.entityId.value,
                                    "entityType": controller.entityType.value,
                                  }
                                ]);
                         
                        },
                        splashColor: kAppPrimary,
                        child: SVGAssetImage(
                          width: Utils.deviceWidth(context) * 0.10,
                          height: 25.h,
                          url: addIconSvg,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 12.h,),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.entityQuantityList.length,
                  separatorBuilder: (context, index) {
                    return App.appSpacer.vHs;
                  },
                  itemBuilder: (context, index) {
                    return clientViewTile(
                        index, context, controller.entityQuantityList[index]);
                  },
                ),
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            decoration: BoxDecoration(
              color: kBinCardBackground,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      App.appSpacer.sm, 0, App.appSpacer.sm, App.appSpacer.sm),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: '.......................',
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      Spacer(),
                      CustomTextField(
                          textAlign: TextAlign.center,
                          text: translation.quantity,
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                      Spacer(),
                      CustomTextField(
                          textAlign: TextAlign.right,
                          text: '.......................',
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A))
                    ],
                  ),
                ),
                SizedBox(height: 12.h,),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      App.appSpacer.sm, 0, App.appSpacer.sm, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextField(
                          required: controller.entityQuantityList.isEmpty ? true : false,
                          textAlign: TextAlign.left,
                          text: controller.entityQuantityList.isEmpty
                              ? translation.add_quantity
                              : translation.add_more_quantity,
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xff1A1A1A)),
                      InkWell(
                        onTap: () {
                        
                            Get.toNamed(
                                RouteName.quantityCreationMaterialoutScreen,
                                arguments: [
                                  {
                                    "entityName": controller.entityName.value,
                                    "entityId": controller.entityId.value,
                                    "entityType": controller.entityType.value,
                                  }
                                ]);
                         
                        },
                        splashColor: kAppPrimary,
                        child: SVGAssetImage(
                          width: Utils.deviceWidth(context) * 0.10,
                          height: 25.h,
                          url: addIconSvg,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 12.h,),
              ],
            ),
          );
  }

  Widget _addedConfirmTile(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      decoration: BoxDecoration(
        color: kBinCardBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            App.appSpacer.sm, 0, App.appSpacer.sm, App.appSpacer.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                    textAlign: TextAlign.left,
                    text: '...............',
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.w500,
                    fontColor: Color(0xff1A1A1A)),
                Spacer(),
                CustomTextField(
                    textAlign: TextAlign.center,
                    text: translation.transportation_details,
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.w500,
                    fontColor: Color(0xff1A1A1A)),
                Spacer(),
                CustomTextField(
                    textAlign: TextAlign.right,
                    text: '...............',
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.w500,
                    fontColor: Color(0xff1A1A1A))
              ],
            ),
            SizedBox(height: 12.h,),
            CustomTextField(
                required: true,
                textAlign: TextAlign.left,
                text: translation.driver_name,
                fontSize: 14.0.sp,
                fontWeight: FontWeight.w500,
                fontColor: Color(0xff1A1A1A)),
            SizedBox(height: 4.h,),
            CustomTextFormField(
                width: App.appQuery.responsiveWidth(100),
                height: 25.h,
                borderRadius: BorderRadius.circular(10.0),
                hint: translation.driver_name,
                controller: controller.driverController.value,
                focusNode: controller.driverFocusNode.value,
                validating: (value) {
                  if (value!.isEmpty) {
                    return translation.text_error_enter_driver_name;
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.text),
            SizedBox(height: 12.h,),
             CustomTextField(
                required: true,
                textAlign: TextAlign.left,
                text: translation.signature,
                fontSize: 14.0.sp,
                fontWeight: FontWeight.w500,
                fontColor: Color(0xff1A1A1A)),
            SizedBox(height: 4.h,),
            DottedBorder(
              dashPattern: [8],
              color: const Color(0xffD0D5DD),
              strokeWidth: 2,
              borderType: BorderType.RRect,
              radius: const Radius.circular(9),
              child: Container(
                width: App.appQuery.responsiveWidth(100),
                color: const Color(0xffFFFFFF),
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    if (controller.signatureFilePath.value.isNotEmpty) ...[
                      Image.file(
                        File(controller.signatureFilePath.value),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 4.h,),
                    ],
                    GestureDetector(
                      onTap: () async {
                        Get.dialog(
                          const SignaturePadOut(),
                        );
                      },
                      child:  CustomTextField(
                          textAlign: TextAlign.center,
                          text: translation.add_signature,
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff969DB2)),
                    ),
                    SizedBox(height: 4.h,),
                    GestureDetector(
                      onTap: () async {
                        Get.dialog(
                          const SignaturePadOut(),
                        );
                      },
                      child:  CustomTextField(
                          textAlign: TextAlign.center,
                          text: translation.click_here_to_draw_signature,
                          fontSize: 10.0.sp,
                          fontWeight: FontWeight.w400,
                          fontColor: Color(0xff505050)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget clientViewTile(
      int index, BuildContext context, Map<String, dynamic> quantity) {
    return Container(
      margin: EdgeInsets.fromLTRB(Utils.deviceWidth(context) * 0.03, 0,
          Utils.deviceWidth(context) * 0.03, Utils.deviceWidth(context) * 0.03),
      padding: EdgeInsets.fromLTRB(
          Utils.deviceWidth(context) * 0.03,
          Utils.deviceWidth(context) * 0.03,
          Utils.deviceWidth(context) * 0.03,
          0),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
        border: Border.all(
          color: kBorder,
        ),
        borderRadius: BorderRadius.circular(20.0),
        color: kAppWhite,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: Utils.textCapitalizationString(quantity['material'].toString()),
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xff1A1A1A)),
                    ),
                    SizedBox(
                      width: 3.h,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: '(${Utils.textCapitalizationString(quantity['category'].toString())})',
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xff808080)),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                 
                  GestureDetector(
                    onTap: (){
                       DialogUtils.showDeleteConfirmDialog(
                  context,
                  okBtnFunction: () {
                    Get.back(closeOverlays: true);
                    controller.deleteBinToList(index);
                  },
                );
                    },
                    child: Image.asset(
                      height: 20.sp,
                      width: 20.sp,
                      'assets/images/ic_delete.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 15.h,
                  ),
                  GestureDetector(
                    onTap: (){
                       Get.toNamed(
                                RouteName.quantityCreationMaterialOutUpdateForm,
                                arguments: [
                                  {
                                    "entityName": controller.entityName.value,
                                    "entityId": controller.entityId.value,
                                    "entityType": controller.entityType.value,
                                    "index": index,
                                    "category": quantity['category'].toString(),
                                    "material": quantity['material'].toString(),
                                    "category_id": quantity['category_id'].toString(),
                                    "material_id": quantity['material_id'].toString(),
                                    "quantity": quantity['quantity'].toString(),
                                    "bin_name": quantity['bin_name'].toString(),
                                    "bin_number": quantity['bin_number'].toString(),
                                    "unit_id": quantity['unit_id'].toString(),
                                    "unit_name": quantity['unit_name'].toString(),
                                    "mou_name": quantity['mou_name'].toString(),
                                    "unit_quantity": quantity['unit_quantity'].toString(),
                                    "images": quantity['images'],
                                  }
                                ]);
                    },
                    child: Image.asset(
                      height: 20.h,
                      width: 20.h,
                      'assets/images/ic_edit.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h,),
          const Divider(
            color: kAppGreyC,
          ),
          SizedBox(height: 2.h,),
          Row(
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.30,
                child:  CustomTextField(
                  textAlign: TextAlign.left,
                  text: translation.bin,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
               SizedBox(
                width: Utils.deviceWidth(context) * 0.30,
                child:  CustomTextField(
                  textAlign: TextAlign.left,
                  text: translation.quantity,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.27,
                child:  CustomTextField(
                  textAlign: TextAlign.left,
                  text: translation.uom,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontColor: Color(0xff808080),
                ),
              ),
             
            ],
          ),
          SizedBox(height: 2.h,),
          Row(
            children: [
              SizedBox(
                width: Utils.deviceWidth(context) * 0.30,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: quantity['bin_name'].toString().isNotEmpty ? quantity['bin_name'].toString() : 'NA',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
               SizedBox(
                width: Utils.deviceWidth(context) * 0.30,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: quantity['quantity'].toString(),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
              SizedBox(
                width: Utils.deviceWidth(context) * 0.27,
                child: CustomTextField(
                  textAlign: TextAlign.left,
                  text: '${quantity['unit_quantity']} ${quantity['mou_name']}',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontColor: const Color(0xff1a1a1a),
                ),
              ),
             
            ],
          ),
          SizedBox(height: 8.h,),
        ],
      ),
    );
  }
}
