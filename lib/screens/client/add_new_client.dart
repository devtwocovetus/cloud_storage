import 'dart:convert';
import 'dart:io';

import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/screens/phone_widget.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/account/account_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/client/create_client_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/components/image_view/network_image_view.dart';

class AddNewClient extends StatefulWidget {
  const AddNewClient({super.key});

  @override
  State<AddNewClient> createState() => _AddNewClientState();
}

class _AddNewClientState extends State<AddNewClient> {
  final createClientViewModel = Get.put(CreateClientViewModel());
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButton: Visibility(
        visible: !showFab,
        child: MyCustomButton(
          elevation: 70,
          width: App.appQuery.responsiveWidth(70),
          height: Utils.deviceHeight(context) * 0.06,
          padding: Utils.deviceWidth(context) * 0.04,
          borderRadius: BorderRadius.circular(10.0),
          onPressed: () => {
            Utils.isCheck = true,
            if (_formkey.currentState!.validate())
              {createClientViewModel.submitAccountForm()}
          },
          text: 'Create Client',
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
                padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      padding: EdgeInsets.zero,
                      icon: Image.asset(
                        height: 20,
                        width: 10,
                        'assets/images/ic_back_btn.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const CustomTextField(
                        textAlign: TextAlign.center,
                        text: 'Create Client',
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Obx(()=>
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              // _sliderDrawerKey.currentState!.toggle();
                            },
                            icon: AppCachedImage(
                                roundShape: true,
                                height: 25,
                                width: 25,
                                url: createClientViewModel.logoUrl.value)
                        ),
                    ),
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
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: 'Client Name',
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(8.0),
                    hint: 'Client name',
                    controller:
                        createClientViewModel.clientNameController.value,
                    focusNode: createClientViewModel.clientNameFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    validating: (value) {
                      if (value!.isEmpty) {
                        return 'Enter client name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTextField(
                            textAlign: TextAlign.left,
                            text: '.......................',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            fontColor: Color(0xff1A1A1A)),
                        Spacer(),
                        CustomTextField(
                            textAlign: TextAlign.center,
                            text: 'Address',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            fontColor: Color(0xff1A1A1A)),
                        Spacer(),
                        CustomTextField(
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
                      lebelText: 'Street 1',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'Street 1',
                      controller:
                          createClientViewModel.streetOneController.value,
                      focusNode: createClientViewModel.streetOneFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter street 1';
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
                      lebelText: 'Street 2',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'Street 2',
                      controller:
                          createClientViewModel.streetTwoController.value,
                      focusNode: createClientViewModel.streetTwoFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: 'Country',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'Country',
                      controller: createClientViewModel.countryController.value,
                      focusNode: createClientViewModel.countryFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter country';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: 'State',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'State',
                      controller: createClientViewModel.stateController.value,
                      focusNode: createClientViewModel.stateFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter state';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: 'City',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'City',
                      controller: createClientViewModel.cityController.value,
                      focusNode: createClientViewModel.cityFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter city';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: 'Postal Code',
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'Postal Code',
                      controller:
                          createClientViewModel.postalCodeController.value,
                      focusNode: createClientViewModel.postalFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter postal code';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Utils.deviceWidth(context) * 0.04,
                        0,
                        Utils.deviceWidth(context) * 0.04,
                        0),
                    child: const CustomTextField(
                      required: true,
                      textAlign: TextAlign.left,
                      text: 'Phone Number',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      fontColor: Color(0xff1A1A1A),
                    ),
                  ),
                  SizedBox(
                    height: Utils.deviceWidth(context) * 0.02,
                  ),
                  PhoneWidget(
                    countryCode: createClientViewModel.countryCode,
                    textEditingController:
                        createClientViewModel.phoneNumberController,
                  ),
                  SizedBox(
                    height: Utils.deviceWidth(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: 'Email Address',
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(8.0),
                    hint: 'Email Address',
                    controller: createClientViewModel.emailController.value,
                    focusNode: createClientViewModel.emailFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    validating: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
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
                        const CustomTextField(
                            textAlign: TextAlign.left,
                            text: 'Add Primary Contact',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            fontColor: Color(0xff1A1A1A)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            createClientViewModel.isPocChecked.value =
                                !createClientViewModel.isPocChecked.value;
                          },
                          child: createClientViewModel.isPocChecked.value
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
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  createClientViewModel.isPocChecked.value
                      ? Container(
                          decoration: BoxDecoration(
                            color: kBinCardBackground,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Utils.deviceHeight(context) * 0.02,
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomTextField(
                                        textAlign: TextAlign.left,
                                        text: '.......................',
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500,
                                        fontColor: Color(0xff1A1A1A)),
                                    Spacer(),
                                    CustomTextField(
                                        textAlign: TextAlign.center,
                                        text: 'Point Of Contact',
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500,
                                        fontColor: Color(0xff1A1A1A)),
                                    Spacer(),
                                    CustomTextField(
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
                                  containerbackgroundColor: kBinCardBackground,
                                  padding: Utils.deviceWidth(context) * 0.04,
                                  lebelText: 'Contact Name',
                                  lebelFontColor: const Color(0xff1A1A1A),
                                  borderRadius: BorderRadius.circular(8.0),
                                  hint: 'Contact name',
                                  controller: createClientViewModel
                                      .pocContactNameController.value,
                                  focusNode: createClientViewModel
                                      .pocContactNameFocusNode.value,
                                  textCapitalization: TextCapitalization.none,
                                  validating: (value) {
                                    if (createClientViewModel
                                        .isPocChecked.value) {
                                      if (value!.isEmpty) {
                                        return 'Enter contact name';
                                      }
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text),
                              SizedBox(
                                height: Utils.deviceHeight(context) * 0.02,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    Utils.deviceWidth(context) * 0.04,
                                    0,
                                    Utils.deviceWidth(context) * 0.04,
                                    0),
                                child: const CustomTextField(
                                  required: true,
                                  textAlign: TextAlign.left,
                                  text: 'Contact Number',
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  fontColor: Color(0xff1A1A1A),
                                ),
                              ),
                              SizedBox(
                                height: Utils.deviceWidth(context) * 0.02,
                              ),
                              PhoneWidget(
                                bgColor: kBinCardBackground,
                                countryCode:
                                    createClientViewModel.pocCountryCode,
                                textEditingController: createClientViewModel
                                    .pocContactNumberController,
                              ),
                              SizedBox(
                                height: Utils.deviceHeight(context) * 0.02,
                              ),
                              TextFormFieldLabel(
                                isRequired: true,
                                containerbackgroundColor: kBinCardBackground,
                                padding: Utils.deviceWidth(context) * 0.04,
                                lebelText: 'Email Address',
                                lebelFontColor: const Color(0xff1A1A1A),
                                borderRadius: BorderRadius.circular(8.0),
                                hint: 'Email Address',
                                controller: createClientViewModel
                                    .pocContactEmailController.value,
                                focusNode: createClientViewModel
                                    .pocContactEmailFocusNode.value,
                                textCapitalization: TextCapitalization.none,
                                keyboardType: TextInputType.emailAddress,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny( RegExp(r'\s')),
                                ],
                                validating: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value)) {
                                    return 'Enter valid email address';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: Utils.deviceHeight(context) * 0.02,
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
