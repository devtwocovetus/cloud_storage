import 'dart:developer';

import 'package:cold_storage_flutter/view_models/controller/warehouse/update/update_warehouse_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../models/entity/entity_list_update_model.dart';
import '../../../../models/storage_type/storage_types.dart';
import '../../../../repository/warehouse_repository/warehouse_repository.dart';
import '../../../../utils/utils.dart';

class AddBinOnUpdateViewmodel extends GetxController{
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
  StorageType? storageType;
  Rx<String> storageName = ''.obs;

  RxList<StorageType> storageTypeList = <StorageType>[].obs;
  // Rx<EntityBinMaster> entityBin = EntityBinMaster().obs;

  @override
  void onInit() {
    getStorageType();
    super.onInit();
  }

  Future getStorageType() async {
    EasyLoading.show(status: 'loading...');
    _api.storageTypeListApi().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        StorageTypeModel storageTypeModel = StorageTypeModel.fromJson(value);
        storageTypeList.value = storageTypeModel.type!;
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  addBinToList(BuildContext context) {
    EntityBinUpdateMaster bin = EntityBinUpdateMaster.fromJson({
      "bin_name": binNameController.value.text.toString(),
      "type_of_storage": storageType!.id,
      "type_of_storage_other": otherStorageTypeController.value.text.toString(),
      "storage_condition": storageConditionController.value.text.toString(),
      "capacity": capacityController.value.text.toString(),
      "temperature_min": minTempController.value.text.toString(),
      "temperature_max": maxTempController.value.text.toString(),
      "humidity_min": minHumidityController.value.text.toString(),
      "humidity_max": maxHumidityController.value.text.toString()
    });
    log('bin viewModel : ${bin.toString()}');
    bool exists = false;
    final updateWarehouseViewModel = Get.put(UpdateWarehouseViewModel());
    updateWarehouseViewModel.entityBinList.forEach((e) {
      if(e.binName.toString().trim().toLowerCase() == binNameController.value.text.toString().trim().toLowerCase()){
        exists = true;
        Utils.snackBar('Bin', 'The bin name is already exists');
        return;
      }else{
        exists = false;
      }
    });
    if(!exists){
      Utils.snackBar('Bin', 'Bin created successfully');
      updateWarehouseViewModel.addBinToList(bin);
      Get.delete<AddBinOnUpdateViewmodel>();
      Navigator.pop(context);
    }
  }
}