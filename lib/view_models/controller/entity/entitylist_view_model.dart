import 'package:cold_storage_flutter/models/entity/entity_list_model.dart';
import 'package:cold_storage_flutter/repository/entity_repository/entity_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class EntitylistViewModel extends GetxController {
  final _api = EntityRepository();
  dynamic argumentData = Get.arguments;

  RxString logoUrl = ''.obs;
  RxString backOpration = ''.obs;

  RxList<Entity>? entityList = <Entity>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    backOpration.value = argumentData[0]['first'];
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
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
