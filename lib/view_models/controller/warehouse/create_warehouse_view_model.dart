import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../models/home/user_list_model.dart';
import '../../../repository/warehouse_repository/warehouse_repository.dart';
import '../../../utils/utils.dart';
import '../user_preference/user_prefrence_view_model.dart';

class WareHouseViewModel extends GetxController{

  final _api = WarehouseRepository();

  TextEditingController storageNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController profilePicC = TextEditingController();
  TextEditingController capacityC = TextEditingController();
  TextEditingController tempRangeMaxC = TextEditingController();
  TextEditingController tempRangeMinC = TextEditingController();
  TextEditingController humidityRangeMaxC = TextEditingController();
  TextEditingController humidityRangeMinC = TextEditingController();
  TextEditingController ownerNameC = TextEditingController();
  RxList<UsersList>? userList = <UsersList>[].obs;
  String managerId = '';
  RxString logoUrl = ''.obs;

  ///For Compliance Certificate
  Rx<StringTagController<String>> complianceTagController = StringTagController().obs;
  Rx<InputFieldValues<String>> complianceFieldValues = InputFieldValues<String>(
      textEditingController: TextEditingController(),
      focusNode: FocusNode(),
      error: 'error',
      onTagChanged: (tag) {},
      onTagSubmitted: (tag) {},
      onTagRemoved: (tag) {},
      tags: [],
      tagScrollController: ScrollController()
  ).obs;
  RxList<String> complianceTagsList = <String>[].obs;
  ScrollController complianceTagScroller = ScrollController();
  RxBool visibleComplianceTagField = false.obs;
  // TextEditingController complianceC = TextEditingController();


  ///For Safety Measures
  Rx<StringTagController<String>> safetyMeasureTagController = StringTagController().obs;
  Rx<InputFieldValues<String>> safetyMeasureFieldValues = InputFieldValues<String>(
      textEditingController: TextEditingController(),
      focusNode: FocusNode(),
      error: 'error',
      onTagChanged: (tag) {},
      onTagSubmitted: (tag) {},
      onTagRemoved: (tag) {},
      tags: [],
      tagScrollController: ScrollController()
  ).obs;
  RxList<String> safetyMeasureTagsList = <String>[].obs;
  ScrollController safetyMeasureTagScroller = ScrollController();
  RxBool visibleSafetyMeasureTagField = false.obs;
  // TextEditingController safetyMeasureC = TextEditingController();


  TextEditingController regulationInfoC = TextEditingController();
  TextEditingController operationalHourStartC = TextEditingController();
  TextEditingController operationalHourEndC = TextEditingController();

  ///Bin Creation
  RxInt createdBinCount = 0.obs;
  RxBool addBinFormOpen = false.obs;

  TextEditingController binNameC = TextEditingController();
  String binTypeOfStorage = '';
  TextEditingController binStorageConditionC = TextEditingController();
  TextEditingController binStorageCapacityC = TextEditingController();
  TextEditingController binTempRangeMaxC = TextEditingController();
  TextEditingController binTempRangeMinC = TextEditingController();
  TextEditingController binHumidityRangeMaxC = TextEditingController();
  TextEditingController binHumidityRangeMinC = TextEditingController();

  @override
  void onInit() {
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    getManagerName();
    super.onInit();
  }

  @override
  void dispose() {
    complianceTagController.value.dispose();
    safetyMeasureTagController.value.dispose();
    super.dispose();
  }

  Future getManagerName() async {
    EasyLoading.show(status: 'loading...');

    _api.managerListApi().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        Utils.snackBar('Error', value['message']);
      } else {
        UserListModel userListModel = UserListModel.fromJson(value);
        userList?.value = userListModel.data!.users!.map((data) => data).toList();
        print('userList?.value : ${userListModel.data!.users!.map((data) => data).toList()}');
        // userLeftCount.value = userListModel.data!.commonDetails!.usersLeftCount!;
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void addColdStorage() {
    EasyLoading.show(status: 'loading...');
    print("List ::: ${complianceTagsList.value.map((e) => e.toString(),).toList()}");
    Map data = {
      'name': storageNameC.text.toString(),
      'email': emailC.text.toString(),
      'address': addressC.text.toString(),
      'phone': phoneC.text.toString(),
      'capacity': capacityC.text.toString(),
      'temperature_min': tempRangeMinC.text.toString(),
      'temperature_max': tempRangeMaxC.text.toString(),
      'humidity_min': tempRangeMinC.text.toString(),
      'humidity_max': humidityRangeMaxC.text.toString(),
      'owner_name': /*ownerNameC.text.toString()*/'Mayur patel',
      'manager_id': managerId,
      'compliance_certificates': listToString(complianceTagsList.value),
      'regulatory_information': regulationInfoC.text.toString(),
      'safety_measures': listToString(safetyMeasureTagsList.value),
      'operational_hours_start': operationalHourStartC.text.toString(),
      'operational_hours_end': operationalHourEndC.text.toString(),
      'status': '1',
    };
    log('DataMap : ${data.toString()}');
    _api.addColdStorageApi(data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        Utils.snackBar('Error', value['message']);
        print('ResP1 ${value['message']}');
      } else {
        print('ResP2 ${value['message']}');
        value['message'];
        // if (accountCreateModel.data!.account!.logo!.isNotEmpty) {
        //   userPreference
        //       .saveLogo(accountCreateModel.data!.account!.logo.toString());
        // }

        Utils.snackBar('Account', 'Account created successfully');
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
      print('ResP3 ${error.toString()}');
    });
  }

  String? listToString(List<String>? urlList) {
    // Convert list of strings to one single string including its brackets and double quotation marks
    if (urlList == null || urlList.isEmpty) {
      return '';
    }
    final buffer = StringBuffer();
    for (int i = 0; i < urlList.length; i++) {
      buffer.write('"${urlList[i]}"');
      if (i < urlList.length - 1) {
        buffer.write(',');
      }
    }
    // buffer.write();
    return buffer.toString();
  }

}
