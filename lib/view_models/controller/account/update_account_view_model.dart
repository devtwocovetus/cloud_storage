import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:cold_storage_flutter/models/account/account_create_model.dart';
import 'package:cold_storage_flutter/models/account/timezone_model.dart';
import 'package:cold_storage_flutter/models/account/unit_model.dart';
import 'package:cold_storage_flutter/repository/account_repository/account_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/countries.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart' as i18n;

class UpdateAccountViewModel extends GetxController {
  final _api = AccountRepository();

  final accountNameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final streetOneController = TextEditingController().obs;
  final streetTwoController = TextEditingController().obs;
  final countryController = TextEditingController().obs;
  final stateController = TextEditingController().obs;
  final cityController = TextEditingController().obs;
  final postalCodeController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;
  final phoneNumberController = TextEditingController().obs;

  final streetOneBillingController = TextEditingController().obs;
  final streetTwoBillingController = TextEditingController().obs;
  final countryBillingController = TextEditingController().obs;
  final stateBillingController = TextEditingController().obs;
  final cityBillingController = TextEditingController().obs;
  final postalCodeBillingController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final streetOneBillingFocusNode = FocusNode().obs;
  final streetTwoBillingFocusNode = FocusNode().obs;
  final countryBillingFocusNode = FocusNode().obs;
  final stateBillingFocusNode = FocusNode().obs;
  final cityBillingFocusNode = FocusNode().obs;
  final postalBillingFocusNode = FocusNode().obs;

  final RxString countryCode = ''.obs;

  final accountNameFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;
  final streetOneFocusNode = FocusNode().obs;
  final streetTwoFocusNode = FocusNode().obs;
  final countryFocusNode = FocusNode().obs;
  final stateFocusNode = FocusNode().obs;
  final cityFocusNode = FocusNode().obs;
  final postalFocusNode = FocusNode().obs;
  final addressFocusNode = FocusNode().obs;
  final descriptionFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxString defaultLanguage = ''.obs;
  RxBool isCheckedBilling = false.obs;
  RxBool isCheckedAccDelete = false.obs;
  RxString timeZone = ''.obs;
  RxString unitOfM = ''.obs;
  RxString imageBase64 = ''.obs;
  RxString imageName = 'Upload Logo'.obs;
  String? contactNumber;

  RxString mStrBillingAddress = ''.obs;
  RxString mStrDifferentBillingAddress = ''.obs;
  RxString mStrDescription = ''.obs;
  RxString mStrLogo = ''.obs;
  RxString mStrSelectUnit = ''.obs;
  RxString mStrTimezone = ''.obs;
  RxString mStrDefaultLanguage = ''.obs;
  RxString mStrDefaultLanguageDrop = ''.obs;
  RxString mStrPostalCode = ''.obs;
  RxString mStrCity = ''.obs;
  RxString mStrState = ''.obs;
  RxString mStrCountry = ''.obs;
  RxString mStrStreet2 = ''.obs;
  RxString mStrStreet1 = ''.obs;
  RxString mStrContactNumber = ''.obs;
  RxString mStrEmail = ''.obs;
  RxString mStrName = ''.obs;
  RxString mStrId = ''.obs;
  RxString mStrFinalLanguage = ''.obs;
  RxString mStrBillingAddressStreet1 = ''.obs;
  RxString mStrBillingAddressStreet2 = ''.obs;
  RxString mStrBillingAddressCountry = ''.obs;
  RxString mStrBillingAddressState = ''.obs;
  RxString mStrBillingAddressCity = ''.obs;
  RxString mStrBillingAddressPostalCode = ''.obs;

  var unitList = <String>[].obs;
  var unitListId = <int?>[].obs;
  var timeZoneList = <String>[].obs;
  var timeZoneListId = <int?>[].obs;
  var isLoading = true.obs;
  final RxBool obscured = true.obs;

  late i18n.Translations translation;

  @override
  Future<void> onInit() async {
    await getAccountDetails();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   translation = i18n.Translations.of(Get.context!);
  //   super.onReady();
  // }

  void toggleObscured() {
    obscured.value = !obscured.value;
  }

  void submitAccountForm() {
    UserPreference userPreference = UserPreference();
    int indexUnit = unitList.indexOf(unitOfM.toString());
    int indexTime = timeZoneList.indexOf(timeZone.toString());
    contactNumber = '${countryCode.value}${phoneNumberController.value.text}';
    if (defaultLanguage.value == 'English') {
      mStrFinalLanguage.value = 'en';
    } else {
      mStrFinalLanguage.value = 'es';
    }
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    Map data = {
      'name': Utils.textCapitalizationString(accountNameController.value.text),
      'email': emailController.value.text,
      'contact_number': contactNumber.toString(),
      'street1': Utils.textCapitalizationString(streetOneController.value.text),
      'street2': Utils.textCapitalizationString(streetTwoController.value.text),
      'country': Utils.textCapitalizationString(countryController.value.text),
      'state': Utils.textCapitalizationString(stateController.value.text),
      'city': Utils.textCapitalizationString(cityController.value.text),
      'postal_code': postalCodeController.value.text,
      'different_billing_address': isCheckedBilling.value ? '1' : '0',
      'billing_address_street1': Utils.textCapitalizationString(streetOneBillingController.value.text),
      'billing_address_street2': Utils.textCapitalizationString(streetTwoBillingController.value.text),
      'billing_address_country': Utils.textCapitalizationString(countryBillingController.value.text),
      'billing_address_state': Utils.textCapitalizationString(stateBillingController.value.text),
      'billing_address_city': Utils.textCapitalizationString(cityBillingController.value.text),
      'billing_address_postal_code': postalCodeBillingController.value.text,
      'default_language': mStrFinalLanguage.value,
      'timezone': timeZoneListId[indexTime].toString(),
      // 'select_unit': '1',
      'description':
          Utils.textCapitalizationString(descriptionController.value.text),
      'logo': imageBase64.toString(),
      'status': '1',
    };
    log('DataData : ${data.toString()}');
    _api.accountUpdateApi(data, mStrId.toString()).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        AccountCreateModel accountCreateModel =
            AccountCreateModel.fromJson(value);
        // if (accountCreateModel.data!.account!.logo!.isNotEmpty) {
        //   userPreference
        //       .saveLogo(accountCreateModel.data!.account!.logo.toString());
        // }
        Utils.snackBar(t.account, t.account_updated_success_text);
        Get.until((route) => Get.currentRoute == RouteName.settingDashboard);
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error, error.toString());
    });
  }

  Future<void> accountDelete()  async {
    print('Password ------ ${passwordController.value.text}');
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.accountDeleteApi(mStrId.toString(),passwordController.value.text.toString().trim()).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();

      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar(t.success_text, t.account_deleted_success_text);
        logout();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.isCheck = true;
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  void logout() {
    UserPreference userPreference = UserPreference();
    userPreference.logout();
    Get.offAllNamed(RouteName.loginView);
    // Get.offAndToNamed(RouteName.loginView);
  }

  Future<void> getAccountDetails() async {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.getAccountDetails().then((value) {
      print('value1212 : ${jsonEncode(value)}');
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        mStrBillingAddress.value =
            value['data']['accoutDetails']['billing_address'].toString();
        mStrDifferentBillingAddress.value = value['data']['accoutDetails']
                ['different_billing_address']
            .toString();
        mStrDescription.value =
            value['data']['accoutDetails']['description'].toString();
        mStrLogo.value = value['data']['accoutDetails']['logo'].toString();
        mStrSelectUnit.value =
            value['data']['accoutDetails']['select_unit'].toString();
        mStrTimezone.value =
            value['data']['accoutDetails']['timezone'].toString();
        mStrDefaultLanguage.value =
            value['data']['accoutDetails']['default_language'].toString();
        mStrPostalCode.value =
            value['data']['accoutDetails']['postal_code'].toString();
        mStrCity.value = value['data']['accoutDetails']['city'].toString();
        mStrState.value = value['data']['accoutDetails']['state'].toString();
        mStrCountry.value =
            value['data']['accoutDetails']['country'].toString();
        mStrStreet2.value =
            value['data']['accoutDetails']['street2'].toString();
        mStrStreet1.value =
            value['data']['accoutDetails']['street1'].toString();
        mStrContactNumber.value =
            value['data']['accoutDetails']['contact_number'].toString();
        mStrEmail.value = value['data']['accoutDetails']['email'].toString();
        mStrName.value = value['data']['accoutDetails']['name'].toString();

        mStrBillingAddressStreet1.value = value['data']['accoutDetails']
                ['billing_address_street1']
            .toString();
        mStrBillingAddressStreet2.value = value['data']['accoutDetails']
                ['billing_address_street2']
            .toString();
        mStrBillingAddressCountry.value = value['data']['accoutDetails']
                ['billing_address_country']
            .toString();
        mStrBillingAddressState.value =
            value['data']['accoutDetails']['billing_address_state'].toString();
        mStrBillingAddressCity.value =
            value['data']['accoutDetails']['billing_address_city'].toString();
        mStrBillingAddressPostalCode.value = value['data']['accoutDetails']
                ['billing_address_postal_code']
            .toString();

        mStrId.value = value['data']['accoutDetails']['id'].toString();
        if (mStrDefaultLanguage.value == 'en') {
          defaultLanguage.value = 'English';
        } else {
          defaultLanguage.value = 'Spanish';
        }

        if (mStrDifferentBillingAddress.value == '0') {
          isCheckedBilling.value = false;
        } else {
          isCheckedBilling.value = true;
        }

        seperatePhoneAndDialCode();
        accountNameController.value.text =
            mStrName.value.replaceAll('null', '');
        emailController.value.text = mStrEmail.value.replaceAll('null', '');
        streetOneController.value.text =
            mStrStreet1.value.replaceAll('null', '');
        streetTwoController.value.text =
            mStrStreet2.value.replaceAll('null', '');
        countryController.value.text = mStrCountry.value.replaceAll('null', '');
        stateController.value.text = mStrState.value.replaceAll('null', '');
        cityController.value.text = mStrCity.value.replaceAll('null', '');
        postalCodeController.value.text =
            mStrPostalCode.value.replaceAll('null', '');
        addressController.value.text =
            mStrBillingAddress.value.replaceAll('null', '');
        descriptionController.value.text =
            mStrDescription.value.replaceAll('null', '');

        streetOneBillingController.value.text =
            mStrBillingAddressStreet1.value.replaceAll('null', '');
        streetTwoBillingController.value.text =
            mStrBillingAddressStreet2.value.replaceAll('null', '');
        countryBillingController.value.text =
            mStrBillingAddressCountry.value.replaceAll('null', '');
        stateBillingController.value.text =
            mStrBillingAddressState.value.replaceAll('null', '');
        cityBillingController.value.text =
            mStrBillingAddressCity.value.replaceAll('null', '');
        postalCodeBillingController.value.text =
            mStrBillingAddressPostalCode.value.replaceAll('null', '');

        getUnit();
        getTimeZone();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error, error.toString());
    });
  }

  void getTimeZone() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.timeZonesApi().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        TimeZoneModel timeZoneModel = TimeZoneModel.fromJson(value);
        timeZoneList.value = timeZoneModel.data!
            .map((data) => Utils.textCapitalizationString(data.name!))
            .toList();
        timeZoneListId.value =
            timeZoneModel.data!.map((data) => data.id).toList();
        int index = timeZoneListId.indexOf(int.parse(mStrTimezone.value));
        print('<><><><>##### $index');
        timeZone.value = timeZoneList[index].toString();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error, error.toString());
    });
  }

  void getUnit() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.unitApi().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        UnitModel unitModel = UnitModel.fromJson(value);
        unitList.value = unitModel.data!
            .map((data) => Utils.textCapitalizationString(data.name!))
            .toList();
        unitListId.value = unitModel.data!.map((data) => data.id).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.isCheck = true;
      Utils.snackBar(t.error, error.toString());
    });
  }

  seperatePhoneAndDialCode() {
    Map<String, String> foundedCountry = {};
    for (var country in Countries.allCountries) {
      String dialCode = country["dial_code"].toString();
      if (mStrContactNumber.value.contains(dialCode)) {
        foundedCountry = country;
      }
    }

    if (foundedCountry.isNotEmpty) {
      var dialCode = mStrContactNumber.value.substring(
        0,
        foundedCountry["dial_code"]!.length,
      );
      var newPhoneNumber = mStrContactNumber.value.substring(
        foundedCountry["dial_code"]!.length,
      );
      mStrContactNumber.value = newPhoneNumber.toString();
      phoneNumberController.value.text = mStrContactNumber.value;
    }
  }
}
