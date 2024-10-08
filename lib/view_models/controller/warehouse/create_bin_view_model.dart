import 'package:cold_storage_flutter/view_models/controller/warehouse/create_warehouse_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../models/storage_type/storage_types.dart';
import '../../../repository/warehouse_repository/warehouse_repository.dart';
import '../../../utils/utils.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';

class CreateBinViewModel extends GetxController {
  final _api = WarehouseRepository();

  final binNameController = TextEditingController().obs;
  final storageConditionController = TextEditingController().obs;
  final capacityController = TextEditingController().obs;
  final maxTempController = TextEditingController().obs;
  final minTempController = TextEditingController().obs;
  final maxHumidityController = TextEditingController().obs;
  final minHumidityController = TextEditingController().obs;
  final otherStorageTypeController = TextEditingController().obs;


final binNameFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;
  final storageConditionFocusNode = FocusNode().obs;
  final capacityFocusNode = FocusNode().obs;
  final maxTempFocusNode = FocusNode().obs;
  final minTempFocusNode = FocusNode().obs;
  final maxHumidityFocusNode = FocusNode().obs;
  final minHumidityFocusNode = FocusNode().obs;
  final otherStorageTypeFocusNode = FocusNode().obs;


  RxString storageType = ''.obs;

  var storageTypeList = <String>[].obs;
  var storageTypeListId = <int?>[].obs;

  @override
  void onInit() {
    getStorageType();
    super.onInit();
  }

  Future getStorageType() async {
    EasyLoading.show(status: t.loading);
    _api.storageTypeListApi().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        StorageTypeModel storageTypeModel = StorageTypeModel.fromJson(value);
        storageTypeList.value =
            storageTypeModel.type!.map((data) => Utils.textCapitalizationString(data.name!)).toList();
        storageTypeListId.value =
            storageTypeModel.type!.map((data) => data.id).toList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  addBinToList(BuildContext context) {
    int indexStorage = storageTypeList.indexOf(storageType.toString());
    Map<String, dynamic> bin = {
      "bin_name": Utils.textCapitalizationString(binNameController.value.text.toString()),
      "type_of_storage": Utils.textCapitalizationString(storageTypeListId[indexStorage].toString()),
      "type_of_storage_other": Utils.textCapitalizationString(otherStorageTypeController.value.text.toString()),
      "storage_condition": storageConditionController.value.text.toString(),
      "capacity": Utils.textCapitalizationString(capacityController.value.text.toString()),
      "temperature_min": minTempController.value.text.toString(),
      "temperature_max": maxTempController.value.text.toString(),
      "humidity_min": minHumidityController.value.text.toString(),
      "humidity_max": maxHumidityController.value.text.toString()
    };
    bool exists = false;
    final creatematerialViewModel = Get.put(WareHouseViewModel());
    creatematerialViewModel.entityBinList.forEach((e) {
      if(e['bin_name'].toString().trim().toLowerCase() == binNameController.value.text.toString().trim().toLowerCase()){
        exists = true;
        Utils.snackBar('Bin', 'The bin name is already exists');
        return;
      }else{
        exists = false;
      }
    });
    if(!exists){
      Utils.snackBar('Bin', 'Bin created successfully');
      creatematerialViewModel.addBinToList(bin);
      Get.delete<CreateBinViewModel>();
      Navigator.pop(context);
    }
  }

  // Future<void> addColdStorage() async {
  //   EasyLoading.show(status: 'loading...');
  //   print("entityBinList.value ::: ${entityBinList.value.map((e) => jsonEncode(e),).toList()}");
  //
  //   print("List ::: ${complianceTagsList.value.map((e) => e.toString(),).toList()}");
  //   Map data = {
  //     'name': storageNameC.text.toString(),
  //     'email': emailC.text.toString(),
  //     'address': addressC.text.toString(),
  //     'phone': '${countryCode.value.toString()}${phoneC.value.text.toString()}',
  //     'capacity': capacityC.text.toString(),
  //     'temperature_min': tempRangeMinC.text.toString(),
  //     'temperature_max': tempRangeMaxC.text.toString(),
  //     'humidity_min': tempRangeMinC.text.toString(),
  //     'humidity_max': humidityRangeMaxC.text.toString(),
  //     'owner_name': /*ownerNameC.text.toString()*/ 'Mayur patel',
  //     'manager_id': managerId,
  //     'compliance_certificates': listToString(complianceTagsList.value),
  //     'regulatory_information': regulationInfoC.text.toString(),
  //     'safety_measures': listToString(safetyMeasureTagsList.value),
  //     'operational_hours_start': operationalHourStartC.text.toString(),
  //     'operational_hours_end': operationalHourEndC.text.toString(),
  //     'profile_image': imageBase64.value,
  //     'entity_bin_master[0]': [{
  //       "bin_name": "sdfd",
  //       "type_of_storage": "1",
  //       "type_of_storage_other": "",
  //       "storage_condition": "sdfdsf",
  //       "capacity": "34234",
  //       "temperature_min": "-20°C",
  //       "temperature_max": "-10°C",
  //       "humidity_min": "-20°C",
  //       "humidity_max": "-10°C"
  //     }],
  //     'status': '1',
  //   };
  //   log('DataMap : ${data.toString()}');
  //   _api.addColdStorageApi(data).then((value) {
  //     EasyLoading.dismiss();
  //     if (value['status'] == 0) {
  //       print('ResP1 ${value['message']}');
  //     } else {
  //       print('ResP2 ${value['message']}');
  //       Utils.isCheck = true;
  //       Utils.snackBar('Account', 'Entity created successfully');
  //       if (inComingStatus.value == 'NEW') {
  //         final entityListViewModel = Get.put(NewEntitylistViewModel());
  //         entityListViewModel.getEntityList();
  //         Get.until((route) => Get.currentRoute == RouteName.newEntityListScreen);
  //       } else if (inComingStatus.value == 'OLD') {
  //         final entityListViewModel = Get.put(EntitylistViewModel());
  //         entityListViewModel.getEntityList();
  //         Get.until((route) => Get.currentRoute == RouteName.entityListScreen);
  //       }
  //     }
  //   }).onError((error, stackTrace) {
  //     EasyLoading.dismiss();
  //     Utils.snackBar('Error', error.toString());
  //     print('ResP3 ${error.toString()}');
  //   });
  // }
}
