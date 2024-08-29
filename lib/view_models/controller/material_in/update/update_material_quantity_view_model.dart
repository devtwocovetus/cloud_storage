import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../../data/network/dio_services/api_client.dart';
import '../../../../data/network/dio_services/api_provider/material_provider.dart';
import '../../../../models/material/quality_type_model.dart';
import '../../../../res/routes/routes_name.dart';
import '../../../../utils/utils.dart';
import '../../material/unit_list_view_model.dart';
import '../../user_preference/user_prefrence_view_model.dart';

class UpdateMaterialQuantityViewModel extends GetxController{
  dynamic argumentData = Get.arguments;
  final addMaterialFormKey = GlobalKey<FormState>();

  RxString materialName = ''.obs;
  RxString materialNameId = ''.obs;
  RxString materialCategory = ''.obs;
  RxString materialCategoryId = ''.obs;
  RxString materialDescription = ''.obs;
  RxString mOUValue = ''.obs;
  RxString mOUType = ''.obs;
  RxString mouId = ''.obs;
  RxString mouName = ''.obs;


  RxString logoUrl = ''.obs;
  TextEditingController unitNameC = TextEditingController();
  TextEditingController unitValueC = TextEditingController();
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
  Rx<StringTagController<String>> storageConditionsTagController =
      StringTagController().obs;
  Rx<InputFieldValues<String>> storageConditionsFieldValues =
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
  RxList<String> storageConditionsTagsList = <String>[].obs;
  ScrollController storageConditionsTagScroller = ScrollController();
  RxBool visibleStorageConditionsTagField = false.obs;
  // TextEditingController safetyMeasureC = TextEditingController();

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

  RxList<QualityType>? qualityTypeTypeList = <QualityType>[].obs;
  QualityType? initialQualityType;
  RxMap<String,dynamic> updatingMaterial = <String, dynamic>{}.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      materialName.value = argumentData[0]['MaterialName'];
      materialNameId.value = argumentData[0]['MaterialNameId'];
      materialCategory.value = argumentData[0]['MaterialCategory'];
      materialCategoryId.value = argumentData[0]['MaterialCategoryId'];
      mouId.value = argumentData[0]['MOUID'];
      mOUValue.value = argumentData[0]['MOUValue'];
      mOUType.value = argumentData[0]['MOUType'];
      mouName.value = argumentData[0]['MOUNAME'];
      updatingMaterial.value = jsonDecode(argumentData[0]['material_data']);
    }
    log('updatingMaterial.value : ${jsonDecode(argumentData[0]['material_data'])}');
    measurementOfUnitC.text = '${mOUType.value.toString()} ${mouName.value.toString()}';
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    getQualityType();
    assignInitialValue();
    super.onInit();
  }

  assignInitialValue(){
    unitNameC.text = updatingMaterial['unit_name'] != null ? updatingMaterial['unit_name'].toString() : '';
    unitValueC.text = updatingMaterial['quantity'] != null ? updatingMaterial['quantity'].toString() : '';
    quantityTypeId = updatingMaterial['quantity_type'] != null ? updatingMaterial['quantity_type'].toString() : '';
    safetyDataC.text = updatingMaterial['safety_data'] != null ? updatingMaterial['safety_data'].toString() : '';
    regulatoryInformationC.text = updatingMaterial['regulatory_information'] != null ? updatingMaterial['regulatory_information'].toString() : '';
    unitLengthC.text = updatingMaterial['length'] != null ? updatingMaterial['length'].toString() : '';
    unitWidthC.text = updatingMaterial['width'] != null ? updatingMaterial['width'].toString() : '';
    unitHeightC.text = updatingMaterial['height'] != null ? updatingMaterial['height'].toString() : '';
    unitDiameterC.text = updatingMaterial['diameter'] != null ? updatingMaterial['diameter'].toString() : '';
    unitWeightC.text = updatingMaterial['weight'] != null ? updatingMaterial['weight'].toString() : '';
    unitColorC.text = updatingMaterial['color'] != null ? updatingMaterial['color'].toString() : '';
    storageConditionsTagsList.value = updatingMaterial['storage_conditions'] != null ? stringToList(updatingMaterial['storage_conditions']) : [];
    complianceTagsList.value = updatingMaterial['compliance_certificates'] != null ? stringToList(updatingMaterial['compliance_certificates']) : [];
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
        if(qualityTypeTypeList!.value.isNotEmpty){
          int index = qualityTypeTypeList!.value.indexWhere((e) {
            return e.id == int.parse(quantityTypeId);
          });
          initialQualityType = qualityTypeTypeList!.value[index];
          log('initialQualityType?.value 1: $initialQualityType');
        }
        log('qualityTypeTypeList?.value : ${qualityTypeModel.type!}');
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future<void> updateMaterialUnit() async {
    EasyLoading.show(status: 'loading...');
    Map data = {
      "category_id": materialCategoryId.value.toString(), //from api
      "material_id": materialNameId.value.toString(), //from api
      "unit_name": unitNameC.text.toString(),
      "quantity_type": quantityTypeId, //from api
      "quantity": unitValueC.text.toString(),
      "measurement_of_unit_id": mouId.value.toString(),
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
      "status": "1"
    };
    log('DataMap : ${data.toString()}');
    DioClient client = DioClient();
    final api = MaterialProvider(client: client.init());
    api.updateMaterialUnit(data: data,id: int.parse(updatingMaterial['id'].toString())).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        log('ResP1 ${value['message']}');
      } else {
        log('ResP2 ${value['message']}');
        Utils.isCheck = true;
        Utils.snackBar('Added', 'Material unit updated successfully');
        final materialUnitListViewModel = Get.put(UnitListViewModel());
        materialUnitListViewModel.getMaterialUnitList();
        Get.until(
                (route) => Get.currentRoute == RouteName.materialUnitListScreen);
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
      buffer.write(urlList[i]);
      if (i < urlList.length - 1) {
        buffer.write(',');
      }
    }
    // buffer.write();
    return buffer.toString();
  }

  List<String> stringToList(String? urlString) {
    // Convert list of strings to one single string including its brackets and double quotation marks
    if (urlString == null || urlString.isEmpty) {
      return [];
    }
    String cleanedInput = urlString.replaceAll(r'\"', '')
        .replaceAll('\"', '');
    List<String> list = cleanedInput.split(',');
    List<String> newList = list.map((e) {
      return e.toString().trim();
    }).toList();
    return newList;
  }
}