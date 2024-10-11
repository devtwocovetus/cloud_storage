import 'package:cold_storage_flutter/data/network/dio_services/api_client.dart';
import 'package:cold_storage_flutter/data/network/dio_services/api_provider/report_provider.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';
import 'package:cold_storage_flutter/models/entity/entity_list_model.dart';
import 'package:cold_storage_flutter/repository/entity_repository/entity_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../res/components/dropdown/model/dropdown_item_model.dart';

class EntitylistSettingViewModel extends GetxController {
  final _api = EntityRepository();

  RxBool isCheckDaily = false.obs;

  RxList<Entity>? entityList = <Entity>[].obs;
  RxList<Entity>? entityListForSearch = <Entity>[].obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getEntityList();
    super.onInit();
  }

  void searchFilter(String searchText) {
    searchController.value.text = searchText;
    List<Entity>? results = [];
    if(searchText.isEmpty) {
      results = entityListForSearch?.value;
      print(results);
    } else {
      results = entityListForSearch?.value.where((element) => element.name!.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
    entityList?.value = results ?? [];
  }

  ///Sorting Function start
  List<DropdownItemModel> sortingItems = [
    DropdownItemModel(value: 1,title: 'A-Z'),
    DropdownItemModel(value: 2,title: 'Z-A'),
    DropdownItemModel(value: 3,title: 'Date ASC'),
    DropdownItemModel(value: 4,title: 'Date DESC'),
  ];

  sortListByProperty(DropdownItemModel item){
    switch (item.value) {
      case 1:
        sortListAToZ();
        break;
      case 2:
        sortListZToA();
        break;
      case 3:
        sortListByDateAsc();
        break;
      case 4:
        sortListByDateDec();
        break;
    }
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

  sortListByDateAsc(){
    entityList!.sort((a, b) {
      return a.createdAt!.compareTo(b.createdAt!);
    });
  }

  sortListByDateDec(){
    entityList!.sort((a, b) {
      return b.createdAt!.compareTo(a.createdAt!);
    });
  }
  ///Sorting Function End

  void getEntityList() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.entityListApi().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        EntityListModel entityReportingListModel =
            EntityListModel.fromJson(value);
        entityList?.value =
            entityReportingListModel.data!.map((data) => data).toList();
        entityListForSearch?.value = entityList!.value;
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  void deleteEntity(String entityId, String entityType) {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.entityDelete(entityId, entityType).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar(t.success_text, t.record_delete_success_text);
        getEntityList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  
}
