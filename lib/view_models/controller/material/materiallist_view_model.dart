import 'package:cold_storage_flutter/models/material/material_list_model.dart';
import 'package:cold_storage_flutter/repository/material_repository/material_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../res/components/dropdown/model/dropdown_item_model.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';

class MateriallistViewModel extends GetxController {
    dynamic argumentData = Get.arguments;
  final _api = MaterialRepository();

  RxString backOpration = ''.obs;
  RxString comeFrom = ''.obs;

  RxList<MaterialItem>? materialList = <MaterialItem>[].obs;
  RxList<MaterialItem>? materialListForSearch = <MaterialItem>[].obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    if (argumentData != null) {

      comeFrom.value = argumentData[0]['from'];
    }
    getMaterialList();
    super.onInit();
  }

  void searchFilter(String searchText) {
    List<MaterialItem>? results = [];
    if(searchText.isEmpty) {
      results = materialListForSearch?.value;
      print(results);
    } else {
      results = materialListForSearch?.value.where((element) => element.name!.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
    materialList?.value = results ?? [];
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
    materialList!.sort((a, b) {
      return a.name!.compareTo(b.name!);
    });
  }

  sortListZToA(){
    materialList!.sort((a, b) {
      return b.name!.compareTo(a.name!);
    });
  }

  sortListByDateAsc(){
    materialList!.sort((a, b) {
      return a.createdAt!.compareTo(b.createdAt!);
    });
  }

  sortListByDateDec(){
    materialList!.sort((a, b) {
      return b.createdAt!.compareTo(a.createdAt!);
    });
  }
  ///Sorting Function End

  void deleteMaterial(String id) {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.deleteMaterialApi(id).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
      
      } else {
        Utils.isCheck = true;
        Utils.snackBar(t.success_text, t.record_delete_success_text);
        getMaterialList();
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

  void getMaterialList() {
    isLoading.value = true;
    EasyLoading.show(status: t.loading);
    _api.materialListApi().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        materialList = <MaterialItem>[].obs;
      } else {
        MaterialListModel materialListModel = MaterialListModel.fromJson(value);
        materialList?.value =
            materialListModel.data!.map((data) => data).toList();
        materialListForSearch?.value = materialList!.value;
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }
}
