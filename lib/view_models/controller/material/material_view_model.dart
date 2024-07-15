import 'dart:developer';

import 'package:cold_storage_flutter/models/material/quality_type_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../data/network/dio_services/api_client.dart';
import '../../../data/network/dio_services/api_provider/material_provider.dart';
import '../../../utils/utils.dart';
import '../user_preference/user_prefrence_view_model.dart';

class MaterialViewModel extends GetxController{

  final addMaterialFormKey = GlobalKey<FormState>();

  RxString logoUrl = ''.obs;
  TextEditingController unitNameC = TextEditingController();
  String quantityTypeId = '';
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
    getQualityType();
  }

  Future getQualityType() async {
    EasyLoading.show(status: 'loading...');
    DioClient client = DioClient();
    final api = MaterialProvider(client: client.init());
    api.qualityTypeListApi().then((value) {
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

  Future<void> addMaterialUnit() async {
    EasyLoading.show(status: 'loading...');
    Map data = {
      "category_id": 1,//from api
      "material_id": 11,//from api
      "unit_name": unitNameC.text.toString(),
      "quantity_type": quantityTypeId,//from api
      "measurement_of_unit_id":11,
      "length": unitLengthC.text.toString(),
      "width": unitWeightC.text.toString(),
      "height": unitHeightC.text.toString(),
      "diameter": unitDiameterC.text.toString(),
      "weight": unitWeightC.text.toString(),
      "color": unitColorC.text.toString(),
      "storage_conditions": listToString(storageConditionsTagsList.value),
      "safety_data": safetyDataC.text.toString(),
      "compliance_certificates": listToString(complianceTagsList.value),
      "regulatory_information": regulatoryInformationC.text.toString(),
      "status":"1"
    };
    log('DataMap : ${data.toString()}');
    DioClient client = DioClient();
    final api = MaterialProvider(client: client.init());
    api.addMaterialUnit(data: data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        log('ResP1 ${value['message']}');
      } else {
        log('ResP2 ${value['message']}');
        Utils.isCheck = true;
        Utils.snackBar('Added', 'Material unit added successfully');

        // if (inComingStatus.value == 'NEW') {
        //   final entityListViewModel = Get.put(NewEntitylistViewModel());
        //   entityListViewModel.getEntityList();
        //   Get.until(
        //           (route) => Get.currentRoute == RouteName.newEntityListScreen);
        // } else if (inComingStatus.value == 'OLD') {
        //   final entityListViewModel = Get.put(EntitylistViewModel());
        //   entityListViewModel.getEntityList();
        //   Get.until((route) => Get.currentRoute == RouteName.entityListScreen);
        // }
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
      log('ResP3 ${error.toString()}');
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