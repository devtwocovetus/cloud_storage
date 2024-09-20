import 'dart:collection';

import 'package:cold_storage_flutter/models/account/account_create_model.dart';
import 'package:cold_storage_flutter/models/account/timezone_model.dart';
import 'package:cold_storage_flutter/models/account/unit_model.dart';
import 'package:cold_storage_flutter/repository/account_repository/account_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AccountViewModel extends GetxController {
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
  RxString imageBase64 = ''.obs;
  RxString imageName = 'Upload Logo'.obs;
  String? contactNumber;

  var unitList = <String>[].obs;
  var unitListId = <int?>[].obs;
  var timeZoneList = <String>[].obs;
  var timeZoneListId = <int?>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getUnit();
    getTimeZone();
    super.onInit();
  }

  void submitAccountForm() {
    UserPreference userPreference = UserPreference();
    int indexUnit = unitList.indexOf('Imperial');
    int indexTime = timeZoneList.indexOf(timeZone.toString());
    contactNumber = '${countryCode.value}${phoneNumberController.value.text}';
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
      'default_language': 'en',
      'timezone': timeZoneListId[indexTime].toString(),
      'select_unit': unitListId[indexUnit].toString(),
      'description': descriptionController.value.text,
      'logo': imageBase64.toString(),
      'status': '1',
    };
    _api.accountSubmitApi(data).then((value) {
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
        userPreference.updateCurrentAccountStatus(4);
        Get.delete<AccountViewModel>();
        Get.offAllNamed(RouteName.takeSubscriptionView)!.then((value) {});
        Utils.snackBar('Account', 'Account created successfully');
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
        timeZoneList.value =
            timeZoneModel.data!.map((data) => Utils.textCapitalizationString(data.name!)).toList();
        timeZoneListId.value =
            timeZoneModel.data!.map((data) => data.id).toList();
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
        unitList.value = unitModel.data!.map((data) => Utils.textCapitalizationString(data.name!)).toList();
        unitListId.value = unitModel.data!.map((data) => data.id).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.isCheck = true;
      Utils.snackBar('Error', error.toString());
    });
  }
}
