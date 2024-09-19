import 'package:cold_storage_flutter/data/network/dio_services/api_client.dart';
import 'package:cold_storage_flutter/data/network/dio_services/api_provider/assigned_provider.dart';
import 'package:cold_storage_flutter/models/entity/entity_assigned_list_model.dart';
import 'package:cold_storage_flutter/models/entity/entity_list_model.dart';
import 'package:cold_storage_flutter/repository/entity_repository/entity_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class EntitylistUserAssignSettingViewModel extends GetxController {
  final _api = EntityRepository();
  dynamic argumentData = Get.arguments;
  RxString userId = ''.obs;
  RxBool isCheckDaily = false.obs;

  RxList<EntityAssigned>? entityList = <EntityAssigned>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    if (argumentData != null) {
      userId.value = argumentData[0]['userId'];
    }
    getEntityList();
    super.onInit();
  }

  void getEntityList() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.entityAssigndList(userId.value).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        EntityAssignedListModel entityListModel =
            EntityAssignedListModel.fromJson(value);
        entityList?.value = entityListModel.data!.map((data) => data).toList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void assignedUser(EntityAssigned entity) {
    EasyLoading.show(status: 'loading...');
    Map data = {
      'entity_id': entity.entityId.toString(),
      'entity_type_id': entity.entityType.toString(),
      'user_id': userId.value.toString(),
      'assigned': 1
    };
    DioClient client = DioClient();
    final api2 = AssignedProvider(client: client.init());
    api2.userAssigned(data: data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        Utils.isCheck = true;
        Utils.snackBar('Success', 'User successfully assigned to the entity');
        getEntityList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void removeAssignedUser(EntityAssigned entity) {
    EasyLoading.show(status: 'loading...');
    Map data = {
      'entity_id': entity.entityId.toString(),
      'entity_type_id': entity.entityType.toString(),
      'user_id': userId.value.toString(),
      'assigned': 0
    };
    DioClient client = DioClient();
    final api2 = AssignedProvider(client: client.init());
    api2.userAssigned(data: data).then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      } else {
        Utils.isCheck = true;
        Utils.snackBar('Success', 'User removed from the entity');
        getEntityList();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
