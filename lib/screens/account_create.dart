import 'dart:convert';
import 'dart:io';

import 'package:cold_storage_flutter/res/components/dropdown/my_custom_drop_down.dart';
import 'package:cold_storage_flutter/screens/phone_widget.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/account/account_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reusable_components/reusable_components.dart';

class AccountCreate extends StatefulWidget {
  const AccountCreate({super.key});

  @override
  State<AccountCreate> createState() => _AccountCreateState();
}

class _AccountCreateState extends State<AccountCreate> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  final accountViewModel = Get.put(AccountViewModel());
  final _formkey = GlobalKey<FormState>();
  bool isCheckedBilling = false;
  List<String> languageItems = ['English', 'Spanish'];

  Future<void> imageBase64Convert() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      accountViewModel.imageBase64.value = '';
      accountViewModel.imageName.value = '';
    } else {
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = "data:image/png;base64,${base64Encode(bytes)}";
      accountViewModel.imageBase64.value = base64Image;
      accountViewModel.imageName.value = image!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      resizeToAvoidBottomInset: true,
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
                  Image.asset(
                    'assets/images/ic_logo_coldstorage.png',
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  const Center(
                    child: CustomTextField(
                        text: 'Create Account!',
                        fontSize: 24.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: 'Account Name',
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(8.0),
                    hint: 'Account Name',
                    controller: accountViewModel.accountNameController.value,
                    focusNode: accountViewModel.accountNameFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    validating: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Account Name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: 'Email Address',
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(8.0),
                    hint: 'Email Address',
                    controller: accountViewModel.emailController.value,
                    focusNode: accountViewModel.emailFocusNode.value,
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
                    countryCode: accountViewModel.countryCode,
                    textEditingController:
                        accountViewModel.phoneNumberController,
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
                      controller: accountViewModel.streetOneController.value,
                      focusNode: accountViewModel.streetOneFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Street 1';
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
                      controller: accountViewModel.streetTwoController.value,
                      focusNode: accountViewModel.streetTwoFocusNode.value,
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
                      controller: accountViewModel.countryController.value,
                      focusNode: accountViewModel.countryFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Country';
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
                      controller: accountViewModel.stateController.value,
                      focusNode: accountViewModel.stateFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter State';
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
                      controller: accountViewModel.cityController.value,
                      focusNode: accountViewModel.cityFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter City';
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
                      controller: accountViewModel.postalCodeController.value,
                      focusNode: accountViewModel.postalFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Postal Code';
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
                        const CustomTextField(
                            textAlign: TextAlign.left,
                            text: 'Different Billing Address ?',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            fontColor: Color(0xff1A1A1A)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isCheckedBilling = !isCheckedBilling;
                            });
                          },
                          child: isCheckedBilling
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
                  isCheckedBilling
                      ? Column(
                          children: [
                            SizedBox(
                              height: Utils.deviceHeight(context) * 0.02,
                            ),
                            TextFormFieldLabel(
                                isRequired: false,
                                padding: Utils.deviceWidth(context) * 0.04,
                                lebelText: 'Billing Address',
                                lebelFontColor: const Color(0xff1A1A1A),
                                minLines: 2,
                                maxLines: 4,
                                borderRadius: BorderRadius.circular(8.0),
                                hint: 'Address',
                                controller:
                                    accountViewModel.addressController.value,
                                focusNode:
                                    accountViewModel.addressFocusNode.value,
                                textCapitalization: TextCapitalization.none,
                                keyboardType: TextInputType.text),
                            const SizedBox(
                              height: 25.0,
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
                  _measurmentUnitWidget,
                  SizedBox(
                    height: Utils.deviceHeight(context) * 0.02,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          Utils.deviceWidth(context) * 0.04, 0, 0, 0),
                      child: const CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Logo',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
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
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CustomTextField(
                                text: accountViewModel.imageName.value,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            MyCustomButton(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                              width: 87.0,
                              height: 38.0,
                              borderRadius: BorderRadius.circular(8.0),
                              onPressed: () => {imageBase64Convert()},
                              text: 'Upload',
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
                      padding: Utils.deviceWidth(context) * 0.04,
                      lebelText: 'Description',
                      lebelFontColor: const Color(0xff1A1A1A),
                      minLines: 2,
                      maxLines: 4,
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'Description',
                      controller: accountViewModel.descriptionController.value,
                      focusNode: accountViewModel.descriptionFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Description';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 20.0,
                  ),
                  MyCustomButton(
                    elevation: 20,
                    height: Utils.deviceHeight(context) * 0.06,
                    padding: Utils.deviceWidth(context) * 0.04,
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: () => {
                      Utils.isCheck = true,
                      if (_formkey.currentState!.validate())
                        {accountViewModel.submitAccountForm()}
                    },
                    text: 'Continue',
                  ),
                  const SizedBox(
                    height: 20.0,
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
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'smmm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Default Language',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxs,
          MyCustomDropDown<String>(
            itemList: languageItems,
            hintText: 'Select default language',
            headerBuilder: (context, selectedItem, enabled) {
              return Text(selectedItem);
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(item);
            },

            validator: (value) {
              if (value == null || value.isEmpty) {
                return "   Select default language";
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
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'smmm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Time Zone',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxs,
          MyCustomDropDown<String>(
            itemList: accountViewModel.timeZoneList.toList(),
            headerBuilder: (context, selectedItem, enabled) {
              return Text(selectedItem);
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(item);
            },

            hintText: 'Select Timezone',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "   Select Timezone";
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

  Widget get _measurmentUnitWidget {
    return Padding(
      padding: App.appSpacer.edgeInsets.only(left: 'sm', right: 'smmm'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
              required: true,
              textAlign: TextAlign.left,
              text: 'Select Unit Of Measurements',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              fontColor: Color(0xff1A1A1A)),
          App.appSpacer.vHxs,
          MyCustomDropDown<String>(
            itemList: accountViewModel.unitList.toList(),
            headerBuilder: (context, selectedItem, enabled) {
              return Text(selectedItem);
            },
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(item);
            },

            hintText: 'Select Unit',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "   Select unit of measurements";
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
