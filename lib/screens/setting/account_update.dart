import 'dart:convert';
import 'dart:io';

import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/screens/material/material_out/widgets/dialog_utils.dart';
import 'package:cold_storage_flutter/screens/phone_widget.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/account/update_account_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reusable_components/reusable_components.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class AccountUpdate extends StatefulWidget {
  const AccountUpdate({super.key});

  @override
  State<AccountUpdate> createState() => _AccountCreateState();
}

class _AccountCreateState extends State<AccountUpdate> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  final accountViewModel = Get.put(UpdateAccountViewModel());
  final _formkey = GlobalKey<FormState>();
  List<String> languageItems = ['English', 'Spanish'];
  late i18n.Translations translation;

  Future<void> imageBase64Convert() async {
    DialogUtils.showMediaDialog(context, cameraBtnFunction: () async {
      Get.back(closeOverlays: true);
      image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) {
      accountViewModel.imageBase64.value = '';
      accountViewModel.imageName.value = '';
    } else {
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = "data:image/png;base64,${base64Encode(bytes)}";
      accountViewModel.imageBase64.value = base64Image;
      accountViewModel.imageName.value = image!.name;
      print('<><><>##### ${image!.name}');
    }
    }, libraryBtnFunction: () async {
      Get.back(closeOverlays: true);
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
      accountViewModel.imageBase64.value = '';
      accountViewModel.imageName.value = '';
    } else {
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = "data:image/png;base64,${base64Encode(bytes)}";
      accountViewModel.imageBase64.value = base64Image;
      accountViewModel.imageName.value = image!.name;
      print('<><><>##### ${image!.name}');
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    translation = i18n.Translations.of(context);
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !showFab,
        child: MyCustomButton(
          width: App.appQuery.responsiveWidth(70),
          height: Utils.deviceHeight(context) * 0.06,
          padding: Utils.deviceWidth(context) * 0.04,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {
            Utils.isCheck = true,
            if (_formkey.currentState!.validate())
              {accountViewModel.submitAccountForm()}
          },
          text: translation.update,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color(0xFFFFFFFF),
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
                    CustomTextField(
                        textAlign: TextAlign.left,
                        text: translation.update_account,
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    // Padding(
                    //   padding: App.appSpacer.edgeInsets.top.none,
                    //   child: Obx(() => IconButton(
                    //       padding: EdgeInsets.zero,
                    //       onPressed: () {
                    //         // _sliderDrawerKey.currentState!.toggle();
                    //         Get.toNamed(RouteName.profileDashbordSetting)!.then((value) {});
                    //       },
                    //       icon: AppCachedImage(
                    //           roundShape: true,
                    //           height: 20,
                    //           width: 20,
                    //           fit: BoxFit.cover,
                    //           url: UserPreference.profileLogo.value))),
                    // ),
                  ],
                ),
              ),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            return Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormFieldLabel(
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: translation.account_name,
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(8.0),
                    hint: translation.account_name_hint,
                    controller: accountViewModel.accountNameController.value,
                    focusNode: accountViewModel.accountNameFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    validating: (value) {
                      if (value!.isEmpty) {
                        return translation.account_name_required;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                    readOnly: true,
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: translation.email_address,
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(8.0),
                    hint: translation.email_address,
                    controller: accountViewModel.emailController.value,
                    focusNode: accountViewModel.emailFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    validating: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return translation.invalid_email;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Utils.deviceWidth(context) * 0.04,
                        0,
                        Utils.deviceWidth(context) * 0.04,
                        0),
                    child: CustomTextField(
                      required: true,
                      textAlign: TextAlign.left,
                      text: translation.phone,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      fontColor: const Color(0xff1A1A1A),
                    ),
                  ),
                  SizedBox(
                    height: Utils.deviceWidth(context) * 0.02,
                  ),
                  PhoneWidget(
                    countryCode: accountViewModel.countryCode,
                    textEditingController:
                        accountViewModel.phoneNumberController,
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CustomTextField(
                            textAlign: TextAlign.left,
                            text: '.......................',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            fontColor: Color(0xff1A1A1A)),
                        const Spacer(),
                        CustomTextField(
                            textAlign: TextAlign.center,
                            text: translation.address,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            fontColor: const Color(0xff1A1A1A)),
                        const Spacer(),
                        const CustomTextField(
                            textAlign: TextAlign.right,
                            text: '.......................',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            fontColor: Color(0xff1A1A1A))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: translation.street_1,
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: translation.street_1,
                      controller: accountViewModel.streetOneController.value,
                      focusNode: accountViewModel.streetOneFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return translation.street_1_required;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                      isRequired: false,
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: translation.street_2,
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: translation.street_2,
                      controller: accountViewModel.streetTwoController.value,
                      focusNode: accountViewModel.streetTwoFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: translation.country,
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: translation.country,
                      controller: accountViewModel.countryController.value,
                      focusNode: accountViewModel.countryFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return translation.empty_country;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: translation.state,
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: translation.state,
                      controller: accountViewModel.stateController.value,
                      focusNode: accountViewModel.stateFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return translation.empty_state;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: translation.city,
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: translation.city,
                      controller: accountViewModel.cityController.value,
                      focusNode: accountViewModel.cityFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return translation.empty_city;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(7),
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: translation.postal_code,
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: translation.postal_code,
                      controller: accountViewModel.postalCodeController.value,
                      focusNode: accountViewModel.postalFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return translation.empty_postal_code;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Utils.deviceWidth(context) * 0.04,
                        0,
                        Utils.deviceWidth(context) * 0.04,
                        0),
                    child: Row(
                      children: [
                        CustomTextField(
                            textAlign: TextAlign.left,
                            text: translation.billing_address,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            fontColor: const Color(0xff1A1A1A)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            accountViewModel.isCheckedBilling.value = !accountViewModel.isCheckedBilling.value; 
                          },
                          child:  accountViewModel.isCheckedBilling.value
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
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                   accountViewModel.isCheckedBilling.value
                      ? Column(
                          children: [
                             SizedBox(
                              height: Utils.deviceHeight(context) * 0.02,
                            ),
                            TextFormFieldLabel(
                                padding: Utils.deviceWidth(context) * 0.04,
                                lebelText: translation.street_1,
                                lebelFontColor: const Color(0xff1A1A1A),
                                borderRadius: BorderRadius.circular(8.0),
                                hint: translation.street_1,
                                controller:
                                    accountViewModel.streetOneBillingController.value,
                                focusNode:
                                    accountViewModel.streetOneBillingFocusNode.value,
                                textCapitalization: TextCapitalization.none,
                                validating: (value) {
                                  if (value!.isEmpty && accountViewModel.isCheckedBilling.value) {
                                    return translation.street_1_required;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text),
                            SizedBox(
                              height: Utils.deviceHeight(context) * 0.02,
                            ),
                            TextFormFieldLabel(
                                isRequired: false,
                                padding: Utils.deviceWidth(context) * 0.04,
                                lebelText: translation.street_2,
                                lebelFontColor: const Color(0xff1A1A1A),
                                borderRadius: BorderRadius.circular(8.0),
                                hint: translation.street_2,
                                controller:
                                    accountViewModel.streetTwoBillingController.value,
                                focusNode:
                                    accountViewModel.streetTwoBillingFocusNode.value,
                                textCapitalization: TextCapitalization.none,
                                keyboardType: TextInputType.text),
                            SizedBox(
                              height: Utils.deviceHeight(context) * 0.02,
                            ),
                            TextFormFieldLabel(
                                padding: Utils.deviceWidth(context) * 0.04,
                                lebelText: translation.country,
                                lebelFontColor: const Color(0xff1A1A1A),
                                borderRadius: BorderRadius.circular(8.0),
                                hint: translation.country,
                                controller:
                                    accountViewModel.countryBillingController.value,
                                focusNode:
                                    accountViewModel.countryBillingFocusNode.value,
                                textCapitalization: TextCapitalization.none,
                                validating: (value) {
                                  if (value!.isEmpty && accountViewModel.isCheckedBilling.value) {
                                    return translation.empty_country;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text),
                            SizedBox(
                              height: Utils.deviceHeight(context) * 0.02,
                            ),
                            TextFormFieldLabel(
                                padding: Utils.deviceWidth(context) * 0.04,
                                lebelText: translation.state,
                                lebelFontColor: const Color(0xff1A1A1A),
                                borderRadius: BorderRadius.circular(8.0),
                                hint: translation.state,
                                controller:
                                    accountViewModel.stateBillingController.value,
                                focusNode:
                                    accountViewModel.stateBillingFocusNode.value,
                                textCapitalization: TextCapitalization.none,
                                validating: (value) {
                                  if (value!.isEmpty && accountViewModel.isCheckedBilling.value) {
                                    return translation.empty_state;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text),
                            SizedBox(
                              height: Utils.deviceHeight(context) * 0.02,
                            ),
                            TextFormFieldLabel(
                                padding: Utils.deviceWidth(context) * 0.04,
                                lebelText: translation.city,
                                lebelFontColor: const Color(0xff1A1A1A),
                                borderRadius: BorderRadius.circular(8.0),
                                hint: translation.city,
                                controller:
                                    accountViewModel.cityBillingController.value,
                                focusNode: accountViewModel.cityBillingFocusNode.value,
                                textCapitalization: TextCapitalization.none,
                                validating: (value) {
                                  if (value!.isEmpty && accountViewModel.isCheckedBilling.value) {
                                    return translation.city_required;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text),
                            SizedBox(
                              height: Utils.deviceHeight(context) * 0.02,
                            ),
                            TextFormFieldLabel(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(7),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s')),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                padding: Utils.deviceWidth(context) * 0.04,
                                lebelText: translation.postal_code,
                                lebelFontColor: const Color(0xff1A1A1A),
                                borderRadius: BorderRadius.circular(8.0),
                                hint: translation.postal_code,
                                controller:
                                    accountViewModel.postalCodeBillingController.value,
                                focusNode:
                                    accountViewModel.postalBillingFocusNode.value,
                                textCapitalization: TextCapitalization.none,
                                validating: (value) {
                                  if (value!.isEmpty && accountViewModel.isCheckedBilling.value) {
                                    return translation.postal_code_required;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text),
                            const SizedBox(
                              height: 15.0,
                            ),
                          ],
                        )
                      : Container(),
                  _defaultWidgetWidget,
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  _timeZoneWidget,
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  //_measurementUnitWidget,
                  // SizedBox(
                  //   height: Utils.deviceHeight(context) * 0.02,
                  // ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          Utils.deviceWidth(context) * 0.04, 0, 0, 0),
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: translation.logo,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor: const Color(0xff1A1A1A)),
                    ),
                  ),
                  SizedBox(
                    height: Utils.deviceWidth(context) * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Utils.deviceWidth(context) * 0.04,
                        0,
                        Utils.deviceWidth(context) * 0.04,
                        0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black.withOpacity(0.4), width: 1),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomTextField(
                                  text: accountViewModel.imageName.value,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            MyCustomButton(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              width: 87.0,
                              height: 38.0,
                              borderRadius: BorderRadius.circular(8.0),
                              onPressed: () => {imageBase64Convert()},
                              text: translation.upload,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                      isRequired: false,
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: translation.description,
                      lebelFontColor: const Color(0xff1A1A1A),
                      minLines: 2,
                      maxLines: 4,
                      borderRadius: BorderRadius.circular(8.0),
                      hint: translation.description,
                      controller: accountViewModel.descriptionController.value,
                      focusNode: accountViewModel.descriptionFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 20.0,
                  ),

                  const SizedBox(
                    height: 60.0,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget get _defaultWidgetWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.default_language,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          App.appSpacer.vHxs,
          MyCustomDropDown<String>(
            initialValue: accountViewModel.defaultLanguage.value,
            itemList: languageItems,
            hintText: translation.selectDefault_language,
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return translation.error_select_default_language;
              }
              return null;
            },
            onChange: (item) {
              // log('changing value to: $item');
              accountViewModel.defaultLanguage.value = item ?? '';
              // controller.managerNameC = item ?? '';
            },
            validateOnChange: true,
          ),
        ],
      ),
    );
  }

  Widget get _timeZoneWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.time_zone,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: const Color(0xff1A1A1A)),
          App.appSpacer.vHxs,
          MyCustomDropDown<String>(
            initialValue: accountViewModel.timeZone.value,
            itemList: accountViewModel.timeZoneList.toList(),
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },
            hintText: translation.select_timezone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return translation.error_select_timezone;
              }
              return null;
            },
            onChange: (item) {
              // log('changing value to: $item');
              accountViewModel.timeZone.value = item ?? '';
              // controller.managerNameC = item ?? '';
            },
            validateOnChange: true,
          ),
        ],
      ),
    );
  }
  //_timeZoneWidget

  Widget get _measurementUnitWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'sm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: translation.unit_of_measurements,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxs,
          MyCustomDropDown<String>(
            itemList: accountViewModel.unitList.toList(),
            headerBuilder: (context, selectedItem, enabled) {
              return Text(Utils.textCapitalizationString(selectedItem));
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(Utils.textCapitalizationString(item));
            },
            hintText: translation.select_unit,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return translation.select_unit_of_measurements;
              }
              return null;
            },
            onChange: (item) {
              // log('changing value to: $item');
              accountViewModel.unitOfM.value = item ?? '';
              // controller.managerNameC = item ?? '';
            },
            validateOnChange: true,
          ),
        ],
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
