import 'dart:developer';

import 'package:cold_storage_flutter/models/material/quality_type_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../repository/material_repository/material_repository.dart';
import '../../../utils/utils.dart';
import '../user_preference/user_prefrence_view_model.dart';

class MaterialViewModel extends GetxController{

  final addMaterialFormKey = GlobalKey<FormState>();
  final _api = MaterialRepository();


  RxString logoUrl = ''.obs;
  TextEditingController storageNameC = TextEditingController();
  TextEditingController measurementOfUnitC = TextEditingController();
  // TextEditingController ownerNameC = TextEditingController();
  TextEditingController safetyDataC = TextEditingController();
  TextEditingController regulatoryInformationC = TextEditingController();

  ///Specification
  TextEditingController unitLengthC = TextEditingController();
  TextEditingController unitWidthC = TextEditingController();
  TextEditingController unitHeightC = TextEditingController();
  TextEditingController unitDiameterC = TextEditingController();
  TextEditingController unitWeightC = TextEditingController();
  TextEditingController unitColorC = TextEditingController();

  ///For Storage Conditions
  Rx<StringTagController<String>> storageConditionsTagController = StringTagController().obs;
  Rx<InputFieldValues<String>> storageConditionsFieldValues = InputFieldValues<String>(
      textEditingController: TextEditingController(),
      focusNode: FocusNode(),
      error: 'error',
      onTagChanged: (tag) {},
      onTagSubmitted: (tag) {},
      onTagRemoved: (tag) {},
      tags: [],
      tagScrollController: ScrollController()).obs;
  RxList<String> storageConditionsTagsList = <String>[].obs;
  ScrollController storageConditionsTagScroller = ScrollController();
  RxBool visibleStorageConditionsTagField = false.obs;
  // TextEditingController safetyMeasureC = TextEditingController();

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
      tagScrollController: ScrollController()).obs;
  RxList<String> complianceTagsList = <String>[].obs;
  ScrollController complianceTagScroller = ScrollController();
  RxBool visibleComplianceTagField = false.obs;
  // TextEditingController complianceC = TextEditingController();

  RxList<QualityType>? qualityTypeTypeList = <QualityType>[].obs;


  @override
  void onInit() {
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
      // logoUrl.value = 'https://img.freepik.com/free-vector/gradient-logo-with-abstract-shape_23-2148216799.jpg';
    });

    // userPreference.getUserName().then((value) {
    //   print("abc<>< : ${value.toString()}");
    //   ownerNameC.text = value.toString();
    //   print("abc<>< : ${ownerNameC.text}");
    // });
    super.onInit();
    getStorageType();
  }

  Future getStorageType() async {
    EasyLoading.show(status: 'loading...');
    _api.qualityTypeListApi().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        QualityTypeModel qualityTypeModel = QualityTypeModel.fromJson(value);
        qualityTypeTypeList?.value = qualityTypeModel.type!;
        log('qualityTypeTypeList?.value : ${qualityTypeModel.type!}');
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

}