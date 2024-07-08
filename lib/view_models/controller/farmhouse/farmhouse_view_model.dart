import 'dart:developer';

import 'package:cold_storage_flutter/view_models/controller/entity/entitylist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../models/home/user_list_model.dart';
import '../../../repository/farmhouse_repository/farmhouse_repository.dart';
import '../../../utils/utils.dart';
import '../user_preference/user_prefrence_view_model.dart';

class FarmhouseViewModel extends GetxController {
  final _api = FarmhouseRepository();

  TextEditingController farmNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  Rx<TextEditingController> phoneC = TextEditingController().obs;
  RxString countryCode = ''.obs;

  TextEditingController profilePicC = TextEditingController();
  TextEditingController farmSizeC = TextEditingController();
  TextEditingController typeOfFarmingC = TextEditingController();
  // TextEditingController tempRangeMaxC = TextEditingController();
  // TextEditingController tempRangeMinC = TextEditingController();
  // TextEditingController humidityRangeMaxC = TextEditingController();
  // TextEditingController humidityRangeMinC = TextEditingController();
  TextEditingController ownerNameC = TextEditingController();
  RxList<UsersList>? userList = <UsersList>[].obs;
  String managerNameC = '';
  TextEditingController farmingMethodC = TextEditingController();
  TextEditingController irrigationSystemC = TextEditingController();
  final entityListViewModel = Get.put(EntitylistViewModel());

  ///For Soil Type
  Rx<StringTagController<String>> soilTagController = StringTagController().obs;
  Rx<InputFieldValues<String>> soilFieldValues = InputFieldValues<String>(
          textEditingController: TextEditingController(),
          focusNode: FocusNode(),
          error: 'error',
          onTagChanged: (tag) {},
          onTagSubmitted: (tag) {},
          onTagRemoved: (tag) {},
          tags: [],
          tagScrollController: ScrollController())
      .obs;
  RxList<String> soilTagsList = <String>[].obs;
  ScrollController soilTagScroller = ScrollController();
  RxBool visibleSoilTagField = false.obs;
  // TextEditingController complianceC = TextEditingController();

  ///For Compliance Certificate
  Rx<StringTagController<String>> complianceTagController =
      StringTagController().obs;
  Rx<InputFieldValues<String>> complianceFieldValues = InputFieldValues<String>(
          textEditingController: TextEditingController(),
          focusNode: FocusNode(),
          error: 'error',
          onTagChanged: (tag) {},
          onTagSubmitted: (tag) {},
          onTagRemoved: (tag) {},
          tags: [],
          tagScrollController: ScrollController())
      .obs;
  RxList<String> complianceTagsList = <String>[].obs;
  ScrollController complianceTagScroller = ScrollController();
  RxBool visibleComplianceTagField = false.obs;
  // TextEditingController complianceC = TextEditingController();

  ///For Storage Facility
  Rx<StringTagController<String>> storageFacilityTagController =
      StringTagController().obs;
  Rx<InputFieldValues<String>> storageFacilityFieldValues =
      InputFieldValues<String>(
              textEditingController: TextEditingController(),
              focusNode: FocusNode(),
              error: 'error',
              onTagChanged: (tag) {},
              onTagSubmitted: (tag) {},
              onTagRemoved: (tag) {},
              tags: [],
              tagScrollController: ScrollController())
          .obs;
  RxList<String> storageFacilityTagsList = <String>[].obs;
  ScrollController storageFacilityTagScroller = ScrollController();
  RxBool visibleStorageFacilityTagField = false.obs;
  // TextEditingController safetyMeasureC = TextEditingController();
  RxString logoUrl = ''.obs;
  @override
  void onInit() {
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    getManagerName();
    super.onInit();
  }

  Future getManagerName() async {
    EasyLoading.show(status: 'loading...');

    _api.managerListApi().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
        print('userList?.value : ${value['message']}');
      } else {
        UserListModel userListModel = UserListModel.fromJson(value);
        userList?.value =
            userListModel.data!.users!.map((data) => data).toList();
        print(
            'userList?.value : ${userListModel.data!.users!.map((data) => data).toList()}');
        // userLeftCount.value = userListModel.data!.commonDetails!.usersLeftCount!;
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future<void> addFarmhouse() async {
    EasyLoading.show(status: 'loading...');
    print("List ::: ${complianceTagsList.value.map(
          (e) => e.toString(),
        ).toList()}");
    Map data = {
      'name': farmNameC.text.toString(),
      'email': emailC.text.toString(),
      'address': addressC.text.toString(),
      'phone': '${countryCode.value.toString()}${phoneC.value.text.toString()}',
      'location': '',
      'farm_size': farmSizeC.text.toString(),
      'type_of_farming': typeOfFarmingC.text.toString(),
      'owner_name': /*ownerNameC.text.toString()*/ 'Mayur patel',
      'manager_id': managerNameC.toString(),
      'farming_method': farmingMethodC.text.toString(),
      'irrigation_system': irrigationSystemC.text.toString(),
      'soil_type': listToString(soilTagsList.value),
      'compliance_certificates': listToString(complianceTagsList.value),
      'storage_facilities': listToString(storageFacilityTagsList.value),
      'status': '1',
    };
    log('DataMap : ${data.toString()}');
    _api.addFarmHouseApi(data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
        print('ResP1 ${value['message']}');
      } else {
        print('ResP2 ${value['message']}');
        value['message'];
        // if (accountCreateModel.data!.account!.logo!.isNotEmpty) {
        //   userPreference
        //       .saveLogo(accountCreateModel.data!.account!.logo.toString());
        // }
        Utils.snackBar('Entity', 'Entity created successfully');
        entityListViewModel.getEntityList();
        Get.back();
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
