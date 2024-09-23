import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../models/entity/entity_list_model.dart';
import '../../repository/entity_repository/entity_repository.dart';
import '../../utils/utils.dart';

class EntityListForTransferViewModel extends GetxController{
  dynamic argumentData = Get.arguments;
  final _api = EntityRepository();

  final searchController = TextEditingController().obs;
  var isLoading = true.obs;
  RxList<Entity>? entityList = <Entity>[].obs;
  RxString entityName = ''.obs;
  RxString entityId = ''.obs;
  RxString entityType = ''.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      entityName.value = argumentData[0]['entityName'];
      entityId.value = argumentData[0]['entityId'];
      entityType.value = argumentData[0]['entityType'];
    }
    getEntityList();
    super.onInit();
  }

  void getEntityList() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.entityListApi().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        EntityListModel entityListModel = EntityListModel.fromJson(value);
        entityList?.value = entityListModel.data!.map((data) => data).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

}