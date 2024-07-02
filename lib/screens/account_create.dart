import 'dart:convert';
import 'dart:io';

import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/account/account_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
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
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  Image.asset(
                    'assets/images/ic_logo_coldstorage.png',
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  const CustomTextField(
                      text: 'Create Account!',
                      fontSize: 24.0,
                      fontColor: Color(0xFF000000),
                      fontWeight: FontWeight.w700),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: CustomTextField(
                        required: true,
                          textAlign: TextAlign.left,
                          text: 'Account Name',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  CustomTextFormField(
                      width: 345.0,
                      height: 40.0,
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'Account Name',
                      controller: accountViewModel.accountNameController.value,
                      focusNode: accountViewModel.accountNameFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          Utils.snackBar('Account Name', 'Enter Account Name');
                          return '';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: CustomTextField(
                        required: true,
                          textAlign: TextAlign.left,
                          text: 'Email Address',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  CustomTextFormField(
                      width: 345.0,
                      height: 40.0,
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'Email Address',
                      controller: accountViewModel.emailController.value,
                      focusNode: accountViewModel.emailFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          Utils.snackBar('Email', 'Enter Email');
                          return '';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: CustomTextField(
                        required: true,
                          textAlign: TextAlign.left,
                          text: 'Contact Number',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  CustomTextFormField(
                      width: 345.0,
                      height: 40.0,
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'Contact Number',
                      controller:
                          accountViewModel.contactNumberController.value,
                      focusNode: accountViewModel.contactNumberFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          Utils.snackBar(
                              'Contact Number', 'Enter Contact Number');
                          return '';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number),
                  const SizedBox(
                    height: 15.0,
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
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: CustomTextField(
                        required: true,
                          textAlign: TextAlign.left,
                          text: 'Street 1',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  CustomTextFormField(
                      width: 345.0,
                      height: 40.0,
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'Street 1',
                      controller: accountViewModel.streetOneController.value,
                      focusNode: accountViewModel.streetOneFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          Utils.snackBar('Street 1', 'Enter Street 1');
                          return '';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: CustomTextField(
                        required: true,
                          textAlign: TextAlign.left,
                          text: 'Street 2',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  CustomTextFormField(
                      width: 345.0,
                      height: 40.0,
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'Street 2',
                      controller: accountViewModel.streetTwoController.value,
                      focusNode: accountViewModel.streetTwoFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          Utils.snackBar('Street 2', 'Enter Street 2');
                          return '';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: CustomTextField(
                        required: true,
                          textAlign: TextAlign.left,
                          text: 'Country',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  CustomTextFormField(
                      width: 345.0,
                      height: 40.0,
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'Country',
                      controller: accountViewModel.countryController.value,
                      focusNode: accountViewModel.countryFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          Utils.snackBar('Country', 'Enter Country');
                          return '';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: CustomTextField(
                        required: true,
                          textAlign: TextAlign.left,
                          text: 'State',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  CustomTextFormField(
                      width: 345.0,
                      height: 40.0,
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'State',
                      controller: accountViewModel.stateController.value,
                      focusNode: accountViewModel.stateFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          Utils.snackBar('State', 'Enter State');
                          return '';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: CustomTextField(
                        required: true,
                          textAlign: TextAlign.left,
                          text: 'City',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  CustomTextFormField(
                      width: 345.0,
                      height: 40.0,
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'City',
                      controller: accountViewModel.cityController.value,
                      focusNode: accountViewModel.cityFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          Utils.snackBar('City', 'Enter City');
                          return '';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: CustomTextField(
                        required: true,
                          textAlign: TextAlign.left,
                          text: 'Postal Code',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  CustomTextFormField(
                      width: 345.0,
                      height: 40.0,
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'Postal Code',
                      controller: accountViewModel.postalCodeController.value,
                      focusNode: accountViewModel.postalFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          Utils.snackBar('Postal Code', 'Enter Postal Code');
                          return '';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                    child: Row(
                      children: [
                        const CustomTextField(
                            textAlign: TextAlign.left,
                            text: 'Different Billing Address ?',
                            fontSize: 15.0,
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
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                                child: CustomTextField(
                                    textAlign: TextAlign.left,
                                    text: 'Billing Address',
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                    fontColor: Color(0xff1A1A1A)),
                              ),
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            CustomTextFormField(
                                width: 345.0,
                                height: 57.0,
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
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: CustomTextField(
                        required: true,
                          textAlign: TextAlign.left,
                          text: 'Default Language',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: SizedBox(
                      width: 370.0,
                      height: 80.0,
                      child: CustomDropdown(
                        height: 60,
                        selectHint: 'Select default language',
                        selectedTimezone: null,
                        onItemSelected: (item) =>
                            accountViewModel.defaultLanguage.value = item,
                        allItems: languageItems,
                        validating: (value) {
                          if (value == null || value.isEmpty) {
                            Utils.snackBar(
                                'Language', 'Select default language');
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: CustomTextField(
                        required: true,
                          textAlign: TextAlign.left,
                          text: 'Time Zone',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: SizedBox(
                      width: 370.0,
                      height: 80.0,
                      child: CustomDropdown(
                        height: 60,
                        selectHint: 'Select Timezone',
                        selectedTimezone: null,
                        onItemSelected: (item) =>
                            accountViewModel.timeZone.value = item,
                        allItems: accountViewModel.timeZoneList.toList(),
                        validating: (value) {
                          if (value == null || value.isEmpty) {
                            Utils.snackBar('Timezone', 'Select Timezone');
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: CustomTextField(
                        required: true,
                          textAlign: TextAlign.left,
                          text: 'Select Unit Of Measurements',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Padding(
                   padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: SizedBox(
                        width: 370.0,
                        height: 80.0,
                        child: CustomDropdown(
                          height: 60,
                          selectHint: 'Select Unit',
                          selectedTimezone: null,
                          onItemSelected: (item) =>
                              accountViewModel.unitOfM.value = item,
                          allItems: accountViewModel.unitList.toList(),
                          validating: (value) {
                            if (value == null || value.isEmpty) {
                              Utils.snackBar(
                                  'Unit', 'Select unit of measurements');
                              return '';
                            }
                            return null;
                          },
                        )),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: CustomTextField(
                          textAlign: TextAlign.left,
                          text: 'Logo',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Container(
                    width: 345.0,
                    height: 40.0,
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
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: CustomTextField(
                        required: true,
                          textAlign: TextAlign.left,
                          text: 'Description',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          fontColor: Color(0xff1A1A1A)),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  CustomTextFormField(
                      width: 345.0,
                      height: 57.0,
                      minLines: 2,
                      maxLines: 4,
                      borderRadius: BorderRadius.circular(8.0),
                      hint: 'Description',
                      controller: accountViewModel.descriptionController.value,
                      focusNode: accountViewModel.descriptionFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          Utils.snackBar('Description', 'Enter Description');
                          return '';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text),
                  const SizedBox(
                    height: 20.0,
                  ),
                  MyCustomButton(
                    width: 312.0,
                    height: 48.0,
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
}
