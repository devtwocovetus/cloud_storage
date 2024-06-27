
import 'dart:collection';

import 'package:cold_storage_flutter/models/account/timezone_model.dart';
import 'package:cold_storage_flutter/models/account/unit_model.dart';
import 'package:cold_storage_flutter/repository/account_repository/account_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AccountViewModel extends GetxController {
  final _api = AccountRepository();

  final accountNameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final contactNumberController = TextEditingController().obs;
  final streetOneController = TextEditingController().obs;
  final streetTwoController = TextEditingController().obs;
  final countryController = TextEditingController().obs;
  final stateController = TextEditingController().obs;
  final cityController = TextEditingController().obs;
  final postalCodeController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;

  final accountNameFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;
  final contactNumberFocusNode = FocusNode().obs;
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
  


  var unitList = <String?>[].obs;
  var unitListId = <int?>[].obs;
  var timeZoneList = <String?>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getUnit();
    getTimeZone();
    super.onInit();
  }

  void submitAccountForm() {
    print('<><><>@#@#  $defaultLanguage');
    print('<><><>@#@#  $timeZone');
    print('<><><>@#@#  $unitOfM');

  }

  void getTimeZone() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.timeZonesApi().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        Utils.snackBar('Error', value['message']);
      } else {
        TimeZoneModel timeZoneModel = TimeZoneModel.fromJson(value);
        timeZoneList.value =
            timeZoneModel.data!.map((data) => data.name).toList();
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
        Utils.snackBar('Error', value['message']);
      } else {
        UnitModel unitModel = UnitModel.fromJson(value);
        unitList.value = unitModel.data!.map((data) => data.name).toList();
        unitListId.value = unitModel.data!.map((data) => data.id).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
