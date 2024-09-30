import 'package:cold_storage_flutter/models/entity/entity_list_model.dart';
import 'package:cold_storage_flutter/repository/entity_repository/entity_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class EntitylistViewModel extends GetxController {
  final _api = EntityRepository();
  dynamic argumentData = Get.arguments;

  RxString backOperation = ''.obs;

  RxList<Entity>? entityList = <Entity>[].obs;
  RxList<Entity>? entityListForSearch = <Entity>[].obs;
  var isLoading = true.obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;

  @override
  void onInit() {
    if (argumentData != null) {
      backOperation.value = argumentData[0]['EOB'];
    }
    getEntityList();
    super.onInit();
  }

  void searchFilter(String searchText) {
    List<Entity>? results = [];
    if(searchText.isEmpty) {
      results = entityListForSearch?.value;
      print(results);
    } else {
      results = entityListForSearch?.value.where((element) => element.name!.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
    entityList?.value = results ?? [];
  }

  sortListAToZ(){
    entityList!.sort((a, b) {
      return a.name!.compareTo(b.name!);
    });
  }

  sortListZToA(){
    entityList!.sort((a, b) {
      return b.name!.compareTo(a.name!);
    });
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
        entityListForSearch?.value = entityList!.value;
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
