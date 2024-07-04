import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../models/home/user_list_model.dart';
import '../user_preference/user_prefrence_view_model.dart';

class FarmhouseViewModel extends GetxController{

  TextEditingController farmNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
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
      tagScrollController: ScrollController()
  ).obs;
  RxList<String> soilTagsList = <String>[].obs;
  ScrollController soilTagScroller = ScrollController();
  RxBool visibleSoilTagField = false.obs;
  // TextEditingController complianceC = TextEditingController();

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


  ///For Storage Facility
  Rx<StringTagController<String>> storageFacilityTagController = StringTagController().obs;
  Rx<InputFieldValues<String>> storageFacilityFieldValues = InputFieldValues<String>(
      textEditingController: TextEditingController(),
      focusNode: FocusNode(),
      error: 'error',
      onTagChanged: (tag) {},
      onTagSubmitted: (tag) {},
      onTagRemoved: (tag) {},
      tags: [],
      tagScrollController: ScrollController()
  ).obs;
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
    super.onInit();
  }

  String? listToString(List<String>? urlList) {
    // Convert list of strings to one single string including its brackets and double quotation marks
    if (urlList == null || urlList.isEmpty) {
      return '[]';
    }
    final buffer = StringBuffer('[');
    for (int i = 0; i < urlList.length; i++) {
      buffer.write('"${urlList[i]}"');
      if (i < urlList.length - 1) {
        buffer.write(',');
      }
    }
    buffer.write(']');
    return buffer.toString();
  }
}