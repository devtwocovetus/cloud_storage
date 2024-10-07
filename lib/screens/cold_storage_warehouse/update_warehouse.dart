import 'dart:developer';

import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/res/components/image_view/network_image_view.dart';
import 'package:cold_storage_flutter/screens/cold_storage_warehouse/widgets/bin_add_on_update_form.dart';
import 'package:cold_storage_flutter/screens/cold_storage_warehouse/widgets/bin_updation_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../models/home/user_list_model.dart';
import '../../res/components/image_view/svg_asset_image.dart';
import '../../res/components/tags_text_field/tag_text_field.dart';
import '../../res/components/text_field/range_text_field.dart';
import '../../res/routes/routes_name.dart';
import '../../res/variables/var_string.dart';
import '../../utils/utils.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import '../../view_models/controller/warehouse/update/update_warehouse_view_model.dart';
import '../../view_models/services/app_services.dart';
import '../phone_widget.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class UpdateWarehouse extends StatelessWidget {
  UpdateWarehouse({super.key});

  final UpdateWarehouseViewModel controller = Get.put(UpdateWarehouseViewModel());
  final _updateColdStorageFormKey = GlobalKey<FormState>();
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
      Visibility(visible: !showFab, child: _updateButtonWidget),
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
                          text: translation.update_cold_storage,
                          fontSize: 18.0,
                          fontColor: Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                    ),
                    Obx(() =>
                      IconButton(
                        onPressed: () {
                        // _sliderDrawerKey.currentState!.toggle();
                          Get.toNamed(RouteName.profileDashbordSetting)!.then((value) {});
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
          child: Obx(()=>
            SingleChildScrollView(
              controller: _scrollController,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: App.appSpacer.edgeInsets.y.smm,
              child: Form(
                key: _updateColdStorageFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _storageNameWidget,
                    App.appSpacer.vHs,
                    _emailWidget,
                    App.appSpacer.vHs,
                    _addressWidget,
                    App.appSpacer.vHs,
                    _phoneWidget,
                    App.appSpacer.vHs,
                    _ownerNameWidget,
                    App.appSpacer.vHs,
                    _managerNameWidget,
                    App.appSpacer.vHs,

                    ///Profile Picture
                    _profilePictureWidget(context),
                    App.appSpacer.vHs,
                    App.appSpacer.vHxxs,
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
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    fontColor: Color(0xff1A1A1A)
                                ),
                                const Spacer(),
                                Image.asset(
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
                            App.appSpacer.vHs,
                            _capacityWidget,
                            App.appSpacer.vHs,
                            _temperatureRangeWidget,
                            App.appSpacer.vHs,
                            _humidityRangeWidget,
                            App.appSpacer.vHs,
                            Padding(
                              padding:  EdgeInsets.fromLTRB(App.appSpacer.sm, 0, App.appSpacer.sm, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomTextField(
                                      textAlign: TextAlign.left,
                                      text: controller.entityBinList.isEmpty ? translation.add_bin :translation.add_more_bin,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      fontColor: const Color(0xff1A1A1A)
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.dialog(
                                        BinAddOnUpdateForm(),
                                      );
                                    },
                                    splashColor: kAppPrimary,
                                    child: SVGAssetImage(
                                      width: Utils.deviceWidth(context)*0.10,
                                      height: 25,
                                      url: addIconSvg,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            _addedBinTile(context),
                            App.appSpacer.vHs,
                            _complianceCertificates,
                            App.appSpacer.vHs,
                            _regulationInformationWidget,
                            App.appSpacer.vHs,
                            _safetyMeasures,
                            App.appSpacer.vHs,
                            _operationHoursWidget,
                            App.appSpacer.vHs,
                          ],
                        ],
                      ),
                    App.appSpacer.vHxxl,
                    // _addButtonWidget
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget get _storageNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.storage_name,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.storage_name,
              controller: controller.storageNameC,
              focusNode: controller.storageNameCFocusNode.value,
              validating: (value) {
                if (value!.isEmpty) {
                  return translation.enter_storage_name;
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
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
            width: App.appQuery.responsiveWidth(100),
            height: 25,
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
              FilteringTextInputFormatter.deny( RegExp(r'\s')),
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
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              minLines: 3,
              maxLines: 3,
              width: App.appQuery.responsiveWidth(100),
              height: 50,
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
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
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
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: CustomTextFormField(
                    readOnly: true,
                    width: App.appQuery.responsiveWidth(100),
                    height: 25,
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(10)),
                    hint: translation.upload_images,
                    controller: controller.profilePicC,
                    focusNode: controller.profilePicCFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.text),
              ),
              Expanded(
                flex: 2,
                child: MyCustomButton(
                  splashColor: kWhite_8,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  // width: 87.0,
                  height: 47.0,
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

  Widget get _capacityWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: false,
              textAlign: TextAlign.left,
              text: translation.storage_capacity,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.storage_capacity,
              controller: controller.capacityC,
              focusNode: controller.capacityCFocusNode.value,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              // validating: (value) {
              //   if (value!.isEmpty) {
              //     return 'Enter storage capacity';
              //   }
              //   return null;
              // },
              textCapitalization: TextCapitalization.none,
              keyboardType: const TextInputType.numberWithOptions(decimal: true,signed: true)),
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
                buttonText: 'Max',
                controller: controller.tempRangeMaxC,
                focusNode: controller.tempRangeMaxCFocusNode.value,
                textCapitalization: TextCapitalization.none,
                keyboardType: const TextInputType.numberWithOptions(decimal: true,signed: true),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                ],
                validating: (value) {
                  if (controller.tempRangeMaxC.text.isEmpty && value!.isEmpty){
                    if (controller.tempRangeMinC.text.isNotEmpty) {
                      if (value.isEmpty) {
                        return translation.enter_max_temp;
                      }else if(!value.isNum){
                        return translation.must_be_a_number;
                      } else if (value.isNum && double.parse(controller.tempRangeMinC.text) >= double.parse(value)) {
                        return translation.must_be_a_number;
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
                buttonText: 'Min',
                controller: controller.tempRangeMinC,
                focusNode: controller.tempRangeMinCFocusNode.value,
                textCapitalization: TextCapitalization.none,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true,signed: true),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                ],
                validating: (value) {
                  if (controller.tempRangeMaxC.text.isNotEmpty) {
                    if (value!.isEmpty) {
                      return translation.enter_min_temp;
                    } else if(!value.isNum){
                      return translation.must_be_a_number;
                    } else if (value.isNum && double.parse(controller.tempRangeMaxC.text) <=
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
      padding: App.appSpacer.edgeInsets.x.sm,
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
                buttonText: 'Max',
                controller: controller.humidityRangeMaxC,
                focusNode: controller.humidityRangeMaxCFocusNode.value,
                textCapitalization: TextCapitalization.none,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                ],
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validating: (value) {
                  if (controller.humidityRangeMaxC.text.isEmpty && value!.isEmpty){
                    if (controller.humidityRangeMinC.text.isNotEmpty) {
                      if (value.isEmpty) {
                        return translation.enter_max_humidity;
                      }else if(!value.isNum){
                        return translation.must_be_a_number;
                      } else if (value.isNum && double.parse(controller.humidityRangeMinC.text) >= double.parse(value)) {
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
                buttonText: 'Min',
                controller: controller.humidityRangeMinC,
                focusNode: controller.humidityRangeMinCFocusNode.value,
                textCapitalization: TextCapitalization.none,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                ],
                validating: (value) {

                  if (controller.humidityRangeMaxC.text.isNotEmpty) {
                    if (value!.isEmpty) {
                      return translation.enter_min_humidity;
                    } else if(!value.isNum){
                      return translation.must_be_a_number;
                    }
                    else if (value.isNum && double.parse(controller.humidityRangeMaxC.text) <=
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

  Widget get _ownerNameWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.owner_name,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              width: App.appQuery.responsiveWidth(100),
              height: 25,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.owner_name,
              readOnly: true,
              controller: controller.ownerNameC,
              focusNode: controller.ownerNameCFocusNode.value,
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
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          Obx(() => MyCustomDropDown<UsersList>(
            enabled: controller.userRoleId.value == '3' ? false : controller.userRoleId.value == '3' ? false : true,
            initialValue: controller.manager,
            itemList: controller.userList!.value,
            hintText: 'Select Manager',
            validateOnChange: true,
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem.name!));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item.name!));
            },
            validator: (value) {
              if (value == null) {
                return "   Select a manager";
              }
              return null;
            },
            onChange: (item) {
              controller.manager = item;
              controller.managerId = item?.id.toString() ?? '';
              log('changing value to: ${controller.manager}');
            },
          ),
          ),
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
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
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

                controller.complianceTagsList.addAll(controller.complianceFieldValues.value.tags);
                controller.complianceTagsList.value = controller.complianceTagsList.toSet().toList();
                controller.complianceFieldValues.value.tags = controller.complianceTagsList;
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

  Widget get _regulationInformationWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
              textAlign: TextAlign.left,
              text: translation.regulation_information,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          CustomTextFormField(
              minLines: 3,
              maxLines: 3,
              width: App.appQuery.responsiveWidth(100),
              height: 50,
              borderRadius: BorderRadius.circular(10.0),
              hint: translation.information_hint,
              controller: controller.regulationInfoC,
              focusNode: controller.regulationInfoCFocusNode.value,
              // validating: (value) {
              //   if (value!.isEmpty) {
              //     Utils.snackBar('Regulation', 'Enter Regulation Information');
              //     return 'Enter Regulation Information';
              //   }
              //   return null;
              // },
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text),
        ],
      ),
    );
  }

  Widget get _safetyMeasures {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
            // required: true,
              textAlign: TextAlign.left,
              text: translation.safety_measures,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          TagsTextField(
            stringTagController: controller.safetyMeasureTagController,
            textFieldTagValues: controller.safetyMeasureFieldValues,
            hintText1: translation.add_safety_measures,
            hintText2: translation.enter_tag,
            onAddButtonTap: () {
              if (controller.safetyMeasureFieldValues.value
                  .textEditingController.text.isNotEmpty) {
                controller.safetyMeasureFieldValues.value.onTagSubmitted(
                    controller.safetyMeasureFieldValues.value
                        .textEditingController.text);
                // controller.safetyMeasureTagsList.value =
                //     controller.safetyMeasureFieldValues.value.tags;
                controller.safetyMeasureTagsList.addAll(controller.safetyMeasureFieldValues.value.tags);
                controller.safetyMeasureTagsList.value = controller.safetyMeasureTagsList.toSet().toList();
                controller.safetyMeasureFieldValues.value.tags = controller.safetyMeasureTagsList;
                controller.visibleSafetyMeasureTagField.value = false;
              }
            },
            tagsList: controller.safetyMeasureTagsList,
            tagScrollController: controller.safetyMeasureTagScroller,
            visibleTagField: controller.visibleSafetyMeasureTagField,
            // validating: (value) {
            //   if (controller.complianceTagsList.isEmpty) {
            //     Utils.snackBar('Measures', 'Enter Safety Measures');
            //     return 'Enter Safety Measures';
            //   }
            //   return null;
            // },
          ),
        ],
      ),
    );
  }

  Widget get _operationHoursWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.x.sm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
            // required: true,
              textAlign: TextAlign.left,
              text: translation.operational_hours,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxxs,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  controller.selectTime(controller.operationalHourStartC);
                },
                child: RangeTextFormField(
                  enabled: false,
                  width: App.appQuery.responsiveWidth(40),
                  height: App.appQuery.responsiveWidth(10),
                  isTime: true,
                  hint: 'HH:MM',
                  buttonText: '',
                  controller: controller.operationalHourStartC,
                  focusNode: controller.operationalHourStartCFocusNode.value,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.datetime,
                  // validating: (value) {
                  //   if (value!.isEmpty) {
                  //     Utils.snackBar('Hours', 'Enter Operational Hours');
                  //     return '';
                  //   }
                  //   return null;
                  // },
                ),
              ),
              Padding(
                padding: App.appSpacer.edgeInsets.x.xxs,
                child: Text(
                  translation.to_label,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: kAppBlack.withOpacity(0.4),
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.selectTime(controller.operationalHourEndC);
                },
                child: RangeTextFormField(
                  enabled: false,
                  width: App.appQuery.responsiveWidth(40),
                  height: App.appQuery.responsiveWidth(10),
                  isTime: true,
                  hint: 'HH:MM',
                  buttonText: '',
                  controller: controller.operationalHourEndC,
                  focusNode: controller.operationalHourEndCFocusNode.value,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.datetime,
                  // validating: (value) {
                  //   if (value!.isEmpty) {
                  //     Utils.snackBar('Hours', 'Enter Operational Hours');
                  //     return '';
                  //   }
                  //   return null;
                  // },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget get _updateButtonWidget {
    return Align(
      alignment: Alignment.bottomCenter,
      child: MyCustomButton(
        width: App.appQuery.responsiveWidth(70) /*312.0*/,
        height: 45,
        borderRadius: BorderRadius.circular(10.0),
        onPressed: () async => {
          Utils.isCheck = true,
          if (_updateColdStorageFormKey.currentState!.validate())
            {
              await controller.updateColdStorage()
            }
        },
        text: translation.update_entity,
      ),
    );
  }

  Widget _addedBinTile(BuildContext context){
    return Obx(() =>  controller.entityBinList.isNotEmpty ? Column(
      children: [
        App.appSpacer.vHs,
        Container(
            margin: EdgeInsets.fromLTRB(App.appSpacer.sm, 0, App.appSpacer.sm, 0),
            padding: const EdgeInsets.fromLTRB(0, 5,0, 0),
            decoration: BoxDecoration(
              color: kBinCardBackground,
              borderRadius: BorderRadius.circular(15),
            ),
            child:  ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.entityBinList.length,
              separatorBuilder: (context, index) {
                return App.appSpacer.vHs;
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: App.appSpacer.edgeInsets.x.sm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                          textAlign: TextAlign.left,
                          text: '${translation.bin} ${index+1}',
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
                                hint: Utils.textCapitalizationString(controller.entityBinList[index].binName!),
                                readOnly: true,
                                controller: TextEditingController(),
                                focusNode: FocusNode(),
                                textCapitalization: TextCapitalization.none,
                                keyboardType: TextInputType.text
                            ),
                          ),
                          App.appSpacer.vWsm,
                          Expanded(
                            flex: 6,
                            child: Obx(()=>
                              CustomTextFormField(
                                  width: 1,
                                  height: 25,
                                  borderRadius: BorderRadius.circular(10.0),
                                  // hint: '',
                                  hint: controller.storageTypeList!.value[controller.storageTypeList!.indexWhere((value) {
                                    return value.id == controller.entityBinList[index].typeOfStorage!;
                                  },)].name ?? '',
                                  readOnly: true,
                                  controller: TextEditingController(),
                                  focusNode: FocusNode(),
                                  textCapitalization: TextCapitalization.none,
                                  keyboardType: TextInputType.text
                              ),
                            ),
                          ),
                          App.appSpacer.vWsm,
                          Expanded(
                            flex: 4,
                            child: CustomTextFormField(
                                width: 1,
                                height: 25,
                                borderRadius: BorderRadius.circular(10.0),
                                hint: Utils.textCapitalizationString(controller.entityBinList[index].capacity!),
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
                                  Get.dialog(
                                    BinUpdationForm(index: index),
                                  );
                                },
                                splashColor: kAppPrimary,
                                padding: EdgeInsets.zero,
                                icon: SVGAssetImage(
                                  width: Utils.deviceWidth(context)*0.10,
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
            ) ),
      ],
    ) : Container());

  }

}
