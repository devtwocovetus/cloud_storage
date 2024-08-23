import 'package:cold_storage_flutter/models/entity/entity_list_model.dart';
import 'package:cold_storage_flutter/repository/entity_repository/entity_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class EntitylistSettingViewModel extends GetxController {
  final _api = EntityRepository();

  RxString logoUrl = ''.obs;
  RxBool isCheckDaily = false.obs;

  RxList<Entity>? entityList = <Entity>[].obs;
  RxList<bool>? listDaily = <bool>[].obs;
  RxList<bool>? listWeekly = <bool>[].obs;
  RxList<bool>? listMonthly = <bool>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
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
        listDaily?.value = entityListModel.data!.map((data) => false).toList();
        listWeekly?.value = entityListModel.data!.map((data) => false).toList();
        listMonthly?.value = entityListModel.data!.map((data) => false).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void deleteEntity(String entityId, String entityType) {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.entityDelete(entityId, entityType).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar('Success', 'Record has been successfully deleted');
        getEntityList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
