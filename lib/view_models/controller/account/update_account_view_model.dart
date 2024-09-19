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

  RxString defaultLanguage = ''.obs;
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

  var unitList = <String>[].obs;
  var unitListId = <int?>[].obs;
  var timeZoneList = <String>[].obs;
  var timeZoneListId = <int?>[].obs;
  var isLoading = true.obs;

  @override
  Future<void> onInit() async {
    await getAccountDetails();

    super.onInit();
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
    EasyLoading.show(status: 'loading...');
    Map data = {
      'name': accountNameController.value.text,
      'email': emailController.value.text,
      'contact_number': contactNumber.toString(),
      'street1': streetOneController.value.text,
      'street2': streetTwoController.value.text,
      'country': countryController.value.text,
      'state': stateController.value.text,
      'city': cityController.value.text,
      'postal_code': postalCodeController.value.text,
      'default_language': mStrFinalLanguage.value,
      'timezone': timeZoneListId[indexTime].toString(),
      // 'select_unit': '1',
      // 'description': descriptionController.value.text,
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
        if (accountCreateModel.data!.account!.logo!.isNotEmpty) {
          userPreference
              .saveLogo(accountCreateModel.data!.account!.logo.toString());
        }
        Utils.snackBar('Account', 'Account updated successfully');
        Get.until((route) => Get.currentRoute == RouteName.settingDashboard);
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
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
        mStrBillingAddress.value = value['data']['billing_address'].toString();
        mStrDifferentBillingAddress.value =
            value['data']['different_billing_address'].toString();
        mStrDescription.value = value['data']['description'].toString();
        mStrLogo.value = value['data']['logo'].toString();
        mStrSelectUnit.value = value['data']['select_unit'].toString();
        mStrTimezone.value = value['data']['timezone'].toString();
        mStrDefaultLanguage.value =
            value['data']['default_language'].toString();
        mStrPostalCode.value = value['data']['postal_code'].toString();
        mStrCity.value = value['data']['city'].toString();
        mStrState.value = value['data']['state'].toString();
        mStrCountry.value = value['data']['country'].toString();
        mStrStreet2.value = value['data']['street2'].toString();
        mStrStreet1.value = value['data']['street1'].toString();
        mStrContactNumber.value = value['data']['contact_number'].toString();
        mStrEmail.value = value['data']['email'].toString();
        mStrName.value = value['data']['name'].toString();
        mStrId.value = value['data']['id'].toString();
        if (mStrDefaultLanguage.value == 'en') {
          defaultLanguage.value = 'English';
        } else {
          defaultLanguage.value = 'Spanish';
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

        getUnit();
        getTimeZone();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void getTimeZone() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
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
      Utils.snackBar('Error', error.toString());
    });
  }

  void getUnit() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
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
      Utils.snackBar('Error', error.toString());
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
