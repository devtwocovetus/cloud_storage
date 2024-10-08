import 'dart:developer';

import 'package:cold_storage_flutter/models/material/quality_type_model.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/controller/material/unit_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../data/network/dio_services/api_client.dart';
import '../../../data/network/dio_services/api_provider/material_provider.dart';
import '../../../utils/utils.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';

class MaterialViewModel extends GetxController {
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

  String quantityTypeId = '';

  final valueController = TextEditingController().obs;
  final unitNameC = TextEditingController().obs;
  final unitValueC = TextEditingController().obs;
  final measurementOfUnitC = TextEditingController().obs;
  final safetyDataC = TextEditingController().obs;
  final regulatoryInformationC = TextEditingController().obs;
  final unitLengthC = TextEditingController().obs;
  final unitWidthC = TextEditingController().obs;
  final unitHeightC = TextEditingController().obs;
  final unitDiameterC = TextEditingController().obs;
  final unitWeightC = TextEditingController().obs;
  final unitColorC = TextEditingController().obs;

  final valueFocusNode = FocusNode().obs;
  final unitNameCFocusNode = FocusNode().obs;
  final unitValueCFocusNode = FocusNode().obs;
  final measurementOfUnitCFocusNode = FocusNode().obs;
  final safetyDataCFocusNode = FocusNode().obs;
  final regulatoryInformationCFocusNode = FocusNode().obs;
  final unitLengthCFocusNode = FocusNode().obs;
  final unitWidthCFocusNode = FocusNode().obs;
  final unitHeightCFocusNode = FocusNode().obs;
  final unitDiameterCFocusNode = FocusNode().obs;
  final unitWeightCFocusNode = FocusNode().obs;
  final unitColorCFocusNode = FocusNode().obs;

  ///Specification

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
    }
    measurementOfUnitC.value.text =
        '${mOUType.value.toString()} ${mouName.value.toString()}';

    // userPreference.getUserName().then((value) {
    //   print("abc<>< : ${value.toString()}");
    //   ownerNameC.text = value.toString();
    //   print("abc<>< : ${ownerNameC.text}");
    // });
    super.onInit();
    getQualityType();
  }

  Future getQualityType() async {
    EasyLoading.show(status: t.loading);
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
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  Future<void> addMaterialUnit() async {
    EasyLoading.show(status: t.loading);
    Map data = {
      "category_id": materialCategoryId.value.toString(), //from api
      "material_id": materialNameId.value.toString(), //from api
      "unit_name": Utils.textCapitalizationString(unitNameC.value.text.toString()),
      "quantity_type": quantityTypeId, //from api
      "quantity": unitValueC.value.text.toString(),
      "measurement_of_unit_id": mouId.value.toString(),
      "length": unitLengthC.value.text.toString(),
      "width": unitWeightC.value.text.toString(),
      "height": unitHeightC.value.text.toString(),
      "diameter": unitDiameterC.value.text.toString(),
      "weight": unitWeightC.value.text.toString(),
      "color": unitColorC.value.text.toString(),
      "storage_conditions": listToString(storageConditionsTagsList.value),
      "safety_data": Utils.textCapitalizationString(safetyDataC.value.text.toString()),
      "compliance_certificates": listToString(complianceTagsList.value),
      "regulatory_information": Utils.textCapitalizationString(regulatoryInformationC.value.text.toString()),
      "status": "1"
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
        Utils.snackBar(t.added_text, t.material_unit_added_success_text);
        final materialUnitListViewModel = Get.put(UnitListViewModel());
        materialUnitListViewModel.getMaterialUnitList();
        Get.until(
            (route) => Get.currentRoute == RouteName.materialUnitListScreen);
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
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
}
