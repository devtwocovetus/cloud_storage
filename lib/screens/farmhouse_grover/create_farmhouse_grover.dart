import 'dart:developer';

import 'package:cold_storage_flutter/res/components/tags_text_field/tag_text_field.dart';
import 'package:cold_storage_flutter/view_models/controller/farmhouse/farmhouse_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:reusable_components/reusable_components.dart';
import '../../models/home/user_list_model.dart';
import '../../res/colors/app_color.dart';
import '../../res/components/dropdown/custom_dropdown_with_checkbox.dart';
import '../../res/components/dropdown/my_custom_drop_down.dart';
import '../../res/components/image_view/network_image_view.dart';
import '../../res/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import '../phone_widget.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class CreateFarmhouseGrover extends StatelessWidget {
  CreateFarmhouseGrover({super.key});
  final _farmHouseFormKey = GlobalKey<FormState>();
  final FarmhouseViewModel controller = Get.put(FarmhouseViewModel());
  final GlobalKey _scrollToPurchaseDetailsKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  late i18n.Translations translation;

  @override
  Widget build(BuildContext context) {
    translation = i18n.Translations.of(context);
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          Visibility(visible: !showFab, child: _addButtonWidget),
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
                          text: translation.add_farm_grower,
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
                              url: UserPreference.profileLogo.value)),
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
          child: Obx(()=>
            SingleChildScrollView(
              controller: _scrollController,
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: App.appSpacer.edgeInsets.y.smm,
                    child: Form(
            key: _farmHouseFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _storageNameWidget,
                SizedBox(height: 12.h,),
                _emailWidget,
                SizedBox(height: 12.h,),
                _addressWidget,
                SizedBox(height: 12.h,),
                _phoneWidget,
                SizedBox(height: 12.h,),
                _ownerNameWidget,
                SizedBox(height: 12.h,),
                _managerNameWidget,
                SizedBox(height: 12.h,),
                ///Profile Picture
                _profilePictureWidget(context),
                SizedBox(height: 12.h,),
                _farmSizeWidget,
                SizedBox(height: 12.h,),
                _typeOfFarmingWidget,
                SizedBox(height: 16.h,),
                    InkWell(
                      onTap: () {
                        controller.isAdditionalDetails.value =
                        !controller.isAdditionalDetails.value;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          final context = _scrollToPurchaseDetailsKey.currentContext;
                          if (context != null) {
                            Scrollable.ensureVisible(
                              context,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          }
                        });
                      },
                      child: Padding(
                        key: _scrollToPurchaseDetailsKey,
                        padding: App.appSpacer.edgeInsets.symmetric(x: 'sm',y: 's'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                             CustomTextField(
                                textAlign: TextAlign.left,
                                text: translation.additional_details,
                                fontSize: 16.0.sp,
                                fontWeight: FontWeight.w500,
                                fontColor: Color(0xff1A1A1A)
                            ),
                            // const Spacer(),
                            Image.asset(
                              height: 11.h,
                              width: 19.h,
                              controller.isAdditionalDetails.value
                                  ? 'assets/images/ic_arrow_up.png'
                                  : 'assets/images/ic_arrow_down.png',
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                App.appSpacer.vHxxs,
                   Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.isAdditionalDetails.value) ...[
                        SizedBox(height: 12.h,),
                        _farmingMethodWidget,
                        SizedBox(height: 12.h,),
                        _typeOfSoil,
                        SizedBox(height: 12.h,),
                        _irrigationSystemWidget,
                        SizedBox(height: 12.h,),
                        _complianceCertificates,
                        SizedBox(height: 12.h,),
                        _storageFacility,
                        SizedBox(height: 12.h,),
                      ],
                    ],
                  ),
                SizedBox(height: 56.h,),
                // _addButtonWidget
              ],
            ),
                    ),
                  ),
          )),
    );
  }

  // Widget get _pageHeadingWidget {
  //   return Padding(
  //     padding: App.appSpacer.edgeInsets.x.sm,
  //     child: const CustomTextField(
  //         textAlign: TextAlign.left,
  //         text: 'Add Farm/Grower',
  //         fontSize: 20.0,
  //         fontColor: kAppBlack,
  //         fontWeight: FontWeight.w500
  //     ),
  //   );
  // }

  Widget get _storageNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.farm_name_label,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.farm_name_label,
              controller: controller.farmNameC,
              focusNode: controller.farmNameCFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return translation.farm_name_validation_error;
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _emailWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.email,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
            width: App.appQuery.responsiveWidth(100),
            height: 25.h,
            borderRadius: BorderRadius.circular(10.0),
            hint: translation.email_address,
            controller: controller.emailC,
            focusNode: controller.emailCFocusNode.value,
            validating: (value) {
              if (value!.isEmpty ||
                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                return translation.enter_valid_email_address;
              }
              return null;
            },
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.emailAddress,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _addressWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.address,
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
              hint: translation.address,
              controller: controller.addressC,
              focusNode: controller.addressCFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return translation.address_validation_error;
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _phoneWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.phone,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          PhoneWidget(
            countryCode: controller.countryCode,
            textEditingController: controller.phoneC,
            padding: EdgeInsets.zero,
            borderColor: Colors.black.withOpacity(0.4),
          ),
          // CustomTextFormField(
          //     width: App.appQuery.responsiveWidth(100),
          //     height: 25,
          //     borderRadius: BorderRadius.circular(10.0),
          //     hint: 'Phone Number',
          //     controller: controller.phoneC,
          //     focusNode: FocusNode(),
          //     validating: (value) {
          //       if (value!.isEmpty) {
          //         Utils.snackBar('Phone', 'Enter phone number');
          //         return 'Enter phone number';
          //       }
          //       return null;
          //     },
          //     textCapitalization: TextCapitalization.none,
          //     keyboardType: TextInputType.phone
          // ),
        ],
      ),
    );
  }

  Widget _profilePictureWidget(BuildContext context) {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.profile_picture,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: CustomTextFormField(
                    readOnly: true,
                    width: App.appQuery.responsiveWidth(100),
                    height: 25.sp,
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(10)),
                    hint: translation.upload_images,
                    controller: controller.profilePicC,
                    focusNode: controller.profilePicCFocusNode.value,
                    validating: (value) {
                      if (value!.isEmpty) {
                        // Utils.snackBar('Capacity', 'Enter storage capacity');
                        // return '';
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.text),
              ),
              Expanded(
                flex: 2,
                child: MyCustomButton(
                  splashColor: kWhite_8,
                  fontSize: 13.0.sp,
                  fontWeight: FontWeight.w400,
                  // width: 87.0,
                  height: 47.0.h,
                  borderRadius:
                      const BorderRadius.horizontal(right: Radius.circular(10)),
                  onPressed: () {
                    controller.imageBase64Convert(context);
                  },
                  text: translation.upload,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget get _farmSizeWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.farm_size_label,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.farm_size_label,
              controller: controller.farmSizeC,
              focusNode: controller.farmSizeCFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return translation.farm_size_validation_error;
                }
                return null;
              },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.number),
        ],
      ),
    );
  }

  Widget get _typeOfFarmingWidget {
    FocusNode focusNode = FocusNode();
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.type_of_farming_label,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomDropdownWithCheckbox<String>(
            focusNode: focusNode,
            enabled: controller.hasFarmingTypeData,
            controller: controller.farmingTypeController,
            itemList: controller.farmingTypeDropdownItems!,
            hintText: 'Farming Type',
            onSelectionChange: (selectedItems) {
              debugPrint("OnSelectionChange: $selectedItems");
            },
            onOtherTileTap: () {
              controller.isFarmingTypeTextFieldExpanded.value =
                  !controller.isFarmingTypeTextFieldExpanded.value;
              controller.farmingTypeController.value.closeDropdown();
              debugPrint(
                  'isTextFieldExpanded : ${controller.isFarmingTypeTextFieldExpanded}');
            },
          ),
          SizedBox(height: 4.h,),
          Obx(() => Visibility(
              visible: controller.isFarmingTypeTextFieldExpanded.value,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 8,
                    child: CustomTextFormField(
                      controller: controller.farmingTypeTextC,
                      focusNode: focusNode,
                      hint: translation.enter_tag,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      height: 25.h,
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(10)),
                      // onChanged: textFieldTagValues.onTagChanged,
                      // onSubmit: textFieldTagValues.onTagSubmitted,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: MyCustomButton(
                      splashColor: kWhite_8,
                      fontSize: 13.0.sp,
                      fontWeight: FontWeight.w400,
                      // width: 87.0,
                      height: 47.0.h,
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(8)),
                      onPressed: () {
                        controller.addFarmingType(
                            controller.farmingTypeTextC.text.toString());
                        controller.isFarmingTypeTextFieldExpanded.value = false;
                        controller.farmingTypeController.value.closeDropdown();
                        controller.farmingTypeTextC.clear();
                      },
                      text: translation.add,
                    ),
                  )
                ],
              ))),
          // CustomTextFormField(
          //     width: App.appQuery.responsiveWidth(100),
          //     height: 25,
          //     borderRadius: BorderRadius.circular(10.0),
          //     hint: 'Farming Type',
          //     controller: controller.typeOfFarmingC,
          //     focusNode: controller.typeOfFarmingCFocusNode.value,
          //     textCapitalization: TextCapitalization.none,
          //     keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _ownerNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.created_by,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25.h,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.created_by,
              readOnly: true,
              controller: controller.ownerNameC,
              focusNode: controller.ownerNameCFocusNode.value,
              // validating: (value) {
              //   if (value!.isEmpty) {
              //     Utils.snackBar('Storage', 'Enter storage name');
              //     return '';
              //   }
              //   return null;
              // },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _managerNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.manager_name,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          Obx(
            () => MyCustomDropDown<UsersList>(
              hintFontSize: 14.0.sp,
              itemList: controller.userList!.value,
              hintText: translation.select_manager_hint,
              validateOnChange: true,
              headerBuilder: (context, selectedItem, enabled) {
                return Text(Utils.textCapitalizationString(selectedItem.name!),
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: kAppBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.5.sp)),
                );
              },
              listItemBuilder: (context, item, isSelected, onItemSelect) {
                return Text(Utils.textCapitalizationString(item.name!),
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: kAppBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.5.sp)),
                );
              },
              validator: (value) {
                if (value == null) {
                  return translation.select_manager_error_text;
                }
                return null;
              },
              onChange: (item) {
                controller.managerId = item?.id.toString() ?? '';
                log('changing value to: ${item!.id}');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget get _farmingMethodWidget {
    FocusNode focusNode = FocusNode();
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.farming_method,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomDropdownWithCheckbox<String>(
            focusNode: focusNode,
            enabled: controller.hasFarmingMethodData,
            controller: controller.farmingMethodController,
            itemList: controller.farmingMethodDropdownItems!,
            hintText: translation.farming_method,
            onSelectionChange: (selectedItems) {
              debugPrint("OnSelectionChange: $selectedItems");
            },
            onOtherTileTap: () {
              controller.isFarmingMethodTextFieldExpanded.value =
                  !controller.isFarmingMethodTextFieldExpanded.value;
              controller.farmingMethodController.value.closeDropdown();
              debugPrint(
                  'isTextFieldExpanded : ${controller.isFarmingMethodTextFieldExpanded}');
            },
          ),
          App.appSpacer.vHxxs,
          Obx(() => Visibility(
              visible: controller.isFarmingMethodTextFieldExpanded.value,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 8,
                    child: CustomTextFormField(
                      controller: controller.farmingMethodTextC,
                      focusNode: focusNode,
                      hint: translation.enter_tag,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      height: 25.h,
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(10)),
                      // onChanged: textFieldTagValues.onTagChanged,
                      // onSubmit: textFieldTagValues.onTagSubmitted,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: MyCustomButton(
                      splashColor: kWhite_8,
                      fontSize: 13.0.sp,
                      fontWeight: FontWeight.w400,
                      // width: 87.0,
                      height: 47.0.h,
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(8)),
                      onPressed: () {
                        controller.addFarmingMethod(
                            controller.farmingMethodTextC.text.toString());
                        controller.isFarmingMethodTextFieldExpanded.value =
                            false;
                        controller.farmingMethodController.value
                            .closeDropdown();
                        controller.farmingMethodTextC.clear();
                      },
                      text: translation.add,
                    ),
                  )
                ],
              ))),
          // CustomTextFormField(
          //     width: App.appQuery.responsiveWidth(100),
          //     height: 25,
          //     borderRadius: BorderRadius.circular(10.0),
          //     hint: 'Farming Method',
          //     controller: controller.farmingMethodC,
          //     focusNode: controller.farmingMethodCFocusNode.value,
          //     textCapitalization: TextCapitalization.none,
          //     keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _irrigationSystemWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.irrigation_system,
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
              hint: translation.irrigation_system_hint,
              controller: controller.irrigationSystemC,
              focusNode: controller.irrigationSystemCFocusNode.value,
              // validating: (value) {
              //   if (value!.isEmpty) {
              //     Utils.snackBar('Irrigation', 'Enter Irrigation System');
              //     return 'Enter Irrigation System';
              //   }
              //   return null;
              // },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _typeOfSoil {
    FocusNode focusNode = FocusNode();

    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.type_of_soil,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          CustomDropdownWithCheckbox<String>(
            focusNode: focusNode,
            enabled: controller.hasSoilTypeData,
            controller: controller.typeOfSoilController,
            itemList: controller.soilDropdownItems!,
            hintText: translation.type_of_soil_hint,
            onSelectionChange: (selectedItems) {
              debugPrint("OnSelectionChange: $selectedItems");
            },
            onOtherTileTap: () {
              controller.isSoilTextFieldExpanded.value =
                  !controller.isSoilTextFieldExpanded.value;
              controller.typeOfSoilController.value.closeDropdown();
              debugPrint(
                  'isTextFieldExpanded : ${controller.isSoilTextFieldExpanded}');
            },
          ),
          SizedBox(height: 4.h,),
          Obx(() => Visibility(
              visible: controller.isSoilTextFieldExpanded.value,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 8,
                    child: CustomTextFormField(
                      controller: controller.typeOfSoilTextC,
                      focusNode: focusNode,
                      hint: translation.enter_tag,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      height: 25.h,
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(10)),
                      // onChanged: textFieldTagValues.onTagChanged,
                      // onSubmit: textFieldTagValues.onTagSubmitted,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: MyCustomButton(
                      splashColor: kWhite_8,
                      fontSize: 13.0.sp,
                      fontWeight: FontWeight.w400,
                      // width: 87.0,
                      height: 47.0.h,
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(8)),
                      onPressed: () {
                        // controller.typeOfSoilController.value.addItem(
                        //     DropdownItem(label: controller.typeOfSoilTextC.text,
                        //         value: '${controller.typeOfSoilController.value.items.length + 1}',
                        //         selected: true
                        //     ),
                        //     index: controller.typeOfSoilController.value.items.length-1
                        // );
                        controller.addSoilTypes(
                            controller.typeOfSoilTextC.text.toString());
                        controller.isSoilTextFieldExpanded.value = false;
                        controller.typeOfSoilController.value.closeDropdown();
                        controller.typeOfSoilTextC.clear();
                      },
                      text: translation.add,
                    ),
                  )
                ],
              ))),
          // TagsTextField(
          //   stringTagController: controller.soilTagController,
          //   textFieldTagValues: controller.soilFieldValues,
          //   hintText1: 'Add Soil Type',
          //   hintText2: 'Enter tag...',
          //   onAddButtonTap: () {
          //     if (controller.soilFieldValues.value.textEditingController.text
          //         .isNotEmpty) {
          //       controller.soilFieldValues.value.onTagSubmitted(controller
          //           .soilFieldValues.value.textEditingController.text);
          //       // controller.soilTagsList.value =
          //       //     controller.soilFieldValues.value.tags;
          //       controller.soilTagsList.value.addAll(controller.soilFieldValues.value.tags);
          //       controller.soilTagsList.value = controller.soilTagsList.value.toSet().toList();
          //       controller.soilFieldValues.value.tags = controller.soilTagsList.value;
          //       controller.visibleSoilTagField.value = false;
          //     }
          //   },
          //   tagsList: controller.soilTagsList,
          //   tagScrollController: controller.soilTagScroller,
          //   visibleTagField: controller.visibleSoilTagField,
          // ),
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
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.compliance_certificates,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          TagsTextField(
            stringTagController: controller.complianceTagController,
            textFieldTagValues: controller.complianceFieldValues,
            hintText1: translation.add_certificate,
            hintText2: translation.enter_tag,
            onAddButtonTap: () {
              if (controller.complianceFieldValues.value.textEditingController
                  .text.isNotEmpty) {
                controller.complianceFieldValues.value.onTagSubmitted(controller
                    .complianceFieldValues.value.textEditingController.text);
                // controller.complianceTagsList.value =
                //     controller.complianceFieldValues.value.tags;
                controller.complianceTagsList.value
                    .addAll(controller.complianceFieldValues.value.tags);
                controller.complianceTagsList.value =
                    controller.complianceTagsList.value.toSet().toList();
                controller.complianceFieldValues.value.tags =
                    controller.complianceTagsList.value;
                controller.visibleComplianceTagField.value = false;
              }
            },
            tagsList: controller.complianceTagsList,
            tagScrollController: controller.complianceTagScroller,
            visibleTagField: controller.visibleComplianceTagField,
            // validating: (value) {
            //   if (controller.complianceTagsList.isEmpty) {
            //     Utils.snackBar('Certificates', 'Enter Compliance Certificates');
            //     return 'Enter Compliance Certificates';
            //   }
            //   return null;
            // },
          ),
        ],
      ),
    );
  }

  Widget get _storageFacility {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: false,
              textAlign: TextAlign.left,
              text: translation.storage_facilities,
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          SizedBox(height: 4.h,),
          TagsTextField(
            stringTagController: controller.storageFacilityTagController,
            textFieldTagValues: controller.storageFacilityFieldValues,
            hintText1: translation.storage_facilities_hint1,
            hintText2: translation.enter_tag,
            onAddButtonTap: () {
              if (controller.storageFacilityFieldValues.value
                  .textEditingController.text.isNotEmpty) {
                controller.storageFacilityFieldValues.value.onTagSubmitted(
                    controller.storageFacilityFieldValues.value
                        .textEditingController.text);
                // controller.storageFacilityTagsList.value =
                //     controller.storageFacilityFieldValues.value.tags;
                controller.storageFacilityTagsList.value
                    .addAll(controller.storageFacilityFieldValues.value.tags);
                controller.storageFacilityTagsList.value =
                    controller.storageFacilityTagsList.value.toSet().toList();
                controller.storageFacilityFieldValues.value.tags =
                    controller.storageFacilityTagsList.value;
                controller.visibleStorageFacilityTagField.value = false;
              }
            },
            tagsList: controller.storageFacilityTagsList,
            tagScrollController: controller.storageFacilityTagScroller,
            visibleTagField: controller.visibleStorageFacilityTagField,
          ),
        ],
      ),
    );
  }

  Widget get _addButtonWidget {
    return Align(
      alignment: Alignment.bottomCenter,
      child: MyCustomButton(
        width: App.appQuery.responsiveWidth(60) /*312.0*/,
        height: 45.h,
        borderRadius: BorderRadius.circular(10.0),
        onPressed: () async => {
          Utils.isCheck = true,
          if (_farmHouseFormKey.currentState!.validate())
            {
              // await controller.addFarmhouse()
              await controller.addFarmHouse2()
            }
        },
        text: translation.add_entity,
      ),
    );
  }
}
