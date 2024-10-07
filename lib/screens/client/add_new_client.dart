import 'package:cold_storage_flutter/res/colors/app_color.dart';
import 'package:cold_storage_flutter/screens/phone_widget.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/client/create_client_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reusable_components/reusable_components.dart';

import '../../res/components/image_view/network_image_view.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controller/user_preference/user_prefrence_view_model.dart';
import '../../i10n/strings.g.dart' as i18n;

class AddNewClient extends StatefulWidget {
  const AddNewClient({super.key});

  @override
  State<AddNewClient> createState() => _AddNewClientState();
}

class _AddNewClientState extends State<AddNewClient> {
  final createClientViewModel = Get.put(CreateClientViewModel());
  final _formkey = GlobalKey<FormState>();
   late i18n.Translations translation;

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translation = i18n.Translations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
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
              {createClientViewModel.submitAccountForm()}
          },
          text: translation.create,
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
                        textAlign: TextAlign.center,
                        text: translation.create,
                        fontSize: 18.0,
                        fontColor: Color(0xFF000000),
                        fontWeight: FontWeight.w500),
                    const Spacer(),
                    Obx(
                      () => IconButton(
                          padding: EdgeInsets.zero,
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
                    lebelText: translation.name,
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(8.0),
                    hint: translation.name,
                    controller:
                        createClientViewModel.clientNameController.value,
                    focusNode: createClientViewModel.clientNameFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    validating: (value) {
                      if (value!.isEmpty) {
                        return translation.enter_name;
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
                        textAlign: TextAlign.center,
                        text: translation.select_role_text,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        fontColor: Color(0xff1A1A1A)),
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
                    child: Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  if (createClientViewModel.isVendor.value ==
                                      0) {
                                    createClientViewModel.isVendor.value = 1;
                                  } else {
                                    createClientViewModel.isVendor.value = 0;
                                  }
                                },
                                child: Obx(
                                  () =>
                                      createClientViewModel.isVendor.value == 1
                                          ? Image.asset(
                                              'assets/images/ic_setting_check_on.png',
                                              width: 20,
                                              height: 20,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/ic_setting_check_off.png',
                                              width: 20,
                                              height: 20,
                                              fit: BoxFit.cover,
                                            ),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                             CustomTextField(
                                textAlign: TextAlign.left,
                                text: translation.vendor,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                fontColor: Color(0xff1A1A1A)),
                          ],
                        ),
                        SizedBox(width: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  if (createClientViewModel.isCustomer.value ==
                                      0) {
                                    createClientViewModel.isCustomer.value = 1;
                                  } else {
                                    createClientViewModel.isCustomer.value = 0;
                                  }
                                },
                                child: Obx(
                                  () =>
                                      createClientViewModel.isCustomer.value ==
                                              1
                                          ? Image.asset(
                                              'assets/images/ic_setting_check_on.png',
                                              width: 20,
                                              height: 20,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/ic_setting_check_off.png',
                                              width: 20,
                                              height: 20,
                                              fit: BoxFit.cover,
                                            ),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                             CustomTextField(
                                textAlign: TextAlign.left,
                                text: translation.customer,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                fontColor: Color(0xff1A1A1A)),
                          ],
                        ),
                      ],
                    ),
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
                        CustomTextField(
                            textAlign: TextAlign.left,
                            text: '.......................',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            fontColor: Color(0xff1A1A1A)),
                        Spacer(),
                        CustomTextField(
                            textAlign: TextAlign.center,
                            text: translation.address,
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
                      lebelText: translation.street1,
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: translation.street1,
                      controller:
                          createClientViewModel.streetOneController.value,
                      focusNode: createClientViewModel.streetOneFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return translation.enter_street_1;
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
                      lebelText: translation.street2,
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: translation.street2,
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
                      lebelText: translation.country,
                      lebelFontColor: const Color(0xff1A1A1A),
                      borderRadius: BorderRadius.circular(8.0),
                      hint: translation.country,
                      controller: createClientViewModel.countryController.value,
                      focusNode: createClientViewModel.countryFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return translation.enter_country;
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
                      controller: createClientViewModel.stateController.value,
                      focusNode: createClientViewModel.stateFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return translation.enter_state;
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
                      controller: createClientViewModel.cityController.value,
                      focusNode: createClientViewModel.cityFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return translation.enter_city;
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
                      controller:
                          createClientViewModel.postalCodeController.value,
                      focusNode: createClientViewModel.postalFocusNode.value,
                      textCapitalization: TextCapitalization.none,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return translation.enter_postal_code;
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
                    child:  CustomTextField(
                      required: false,
                      textAlign: TextAlign.left,
                      text: translation.phone_number,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      fontColor: Color(0xff1A1A1A),
                    ),
                  ),
                  SizedBox(
                    height: Utils.deviceWidth(context) * 0.02,
                  ),
                  PhoneWidget(
                    isRequired: false,
                    countryCode: createClientViewModel.countryCode,
                    textEditingController:
                        createClientViewModel.phoneNumberController,
                  ),
                  SizedBox(
                    height: Utils.deviceWidth(context) * 0.02,
                  ),
                  TextFormFieldLabel(
                    padding: Utils.deviceWidth(context) * 0.04,
                    lebelText: translation.email_address,
                    lebelFontColor: const Color(0xff1A1A1A),
                    borderRadius: BorderRadius.circular(8.0),
                    hint: translation.email_address,
                    isRequired: false,
                    controller: createClientViewModel.emailController.value,
                    focusNode: createClientViewModel.emailFocusNode.value,
                    textCapitalization: TextCapitalization.none,
                    validating: (value) {
                      if (value!.isNotEmpty &&
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return translation.enter_your_email;
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
                         CustomTextField(
                            textAlign: TextAlign.left,
                            text: translation.add_primary_contact,
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
                               Padding(
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
                                        text: translation.point_of_contact,
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
                                  lebelText: translation.contact_name,
                                  lebelFontColor: const Color(0xff1A1A1A),
                                  borderRadius: BorderRadius.circular(8.0),
                                  hint: translation.contact_name,
                                  controller: createClientViewModel
                                      .pocContactNameController.value,
                                  focusNode: createClientViewModel
                                      .pocContactNameFocusNode.value,
                                  textCapitalization: TextCapitalization.none,
                                  validating: (value) {
                                    if (createClientViewModel
                                        .isPocChecked.value) {
                                      if (value!.isEmpty) {
                                        return translation.enter_contact_name;
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
                                child:  CustomTextField(
                                  required: true,
                                  textAlign: TextAlign.left,
                                  text: translation.contact_number,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  fontColor: Color(0xff1A1A1A),
                                ),
                              ),
                              SizedBox(
                                height: Utils.deviceWidth(context) * 0.02,
                              ),
                              PhoneWidget(
                                hintText: translation.contact_number,
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
                                lebelText: translation.email_address,
                                lebelFontColor: const Color(0xff1A1A1A),
                                borderRadius: BorderRadius.circular(8.0),
                                hint: translation.email_address,
                                controller: createClientViewModel
                                    .pocContactEmailController.value,
                                focusNode: createClientViewModel
                                    .pocContactEmailFocusNode.value,
                                textCapitalization: TextCapitalization.none,
                                keyboardType: TextInputType.emailAddress,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s')),
                                ],
                                validating: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value)) {
                                    return translation.enter_valid_email_address;
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
