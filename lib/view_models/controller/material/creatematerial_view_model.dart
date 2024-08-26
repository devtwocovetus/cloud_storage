import 'package:cold_storage_flutter/models/material/material_categorie_model.dart';
import 'package:cold_storage_flutter/models/material/measurement_unit_mou.dart';
import 'package:cold_storage_flutter/models/material/measurement_units_type.dart';
import 'package:cold_storage_flutter/repository/material_repository/material_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/material/materiallist_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CreatematerialViewModel extends GetxController {
  final _api = MaterialRepository();

  RxString materialCategory = ''.obs;
  var categoryList = <String>[].obs;
  var categoryListId = <int?>[].obs;
  var unitTypeList = <String>[].obs;
  var mouList = <String>[].obs;
  
  var mouListId = <int?>[].obs;
  final RxString unitType = ''.obs;
  final RxString unitMou = ''.obs;

  final nameController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;

  final nameFocusNode = FocusNode().obs;
  final descriptionFocusNode = FocusNode().obs;
  final valueFocusNode = FocusNode().obs;

  RxString logoUrl = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    UserPreference userPreference = UserPreference();
    userPreference.getLogo().then((value) {
      logoUrl.value = value.toString();
    });
    getMaterialCategorie();
    getMaterialUnitType();
    super.onInit();
  }

  void getMaterialCategorie() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.materialCategorieListApi().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MaterialCategorieModel userRole =
            MaterialCategorieModel.fromJson(value);
        categoryList.value = userRole.data!.map((data) => Utils.textCapitalizationString(data.name!)).toList();
        categoryListId.value = userRole.data!.map((data) => data.id).toList();
        
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void getMaterialUnitType() {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    _api.unitTypeListApi().then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        MeasurementUnitsType measurementUnitsType =
            MeasurementUnitsType.fromJson(value);
        unitTypeList.value =
            measurementUnitsType.data!.map((data) => Utils.textCapitalizationString(data.unitType!)).toList();
            if (unitTypeList.isNotEmpty) {
          unitType.value = unitTypeList[0];
          getMouList(unitTypeList[0]);
        } else {
          unitType.value = 'Type';
        }
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void getMouList(String unitType) {
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {'unit_type': unitType};
    _api.unitMouListApi(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Login', value['message']);
      } else {
        MeasurementUnitMou measurementUnitmou =
            MeasurementUnitMou.fromJson(value);
        mouList.value =
            measurementUnitmou.data!.map((data) => Utils.textCapitalizationString(data.unitName!)).toList();
        mouListId.value =
            measurementUnitmou.data!.map((data) => data.id).toList();
            if(mouList.isNotEmpty){
              unitMou.value = mouList[0];
            }else {
              unitMou.value = '';
            }
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  Future<void> createMaterial()  async {
    int indexMou = mouList.indexOf(unitMou.toString());
    int indexCategory = categoryList.indexOf(materialCategory.toString());
    isLoading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {
      'name': nameController.value.text,
      'category': categoryListId[indexCategory].toString(),
      'description': descriptionController.value.text,
      'mou_id': mouListId[indexMou].toString(),
      'status': "1"
    };
    _api.createMaterialApi(data).then((value) {
      isLoading.value = false;
      EasyLoading.dismiss();
      printWrapped('<><><>## ${value.toString()}');
      if (value['status'] == 0) {
        // Utils.snackBar('Error', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar('Material', 'Material created successfully');
        final materiallistViewModel = Get.put(MateriallistViewModel());
        materiallistViewModel.getMaterialList();
       Get.until((route) => Get.currentRoute == RouteName.materialListScreen);
      }
    }).onError((error, stackTrace) {
      isLoading.value = false;
      EasyLoading.dismiss();
       Utils.isCheck = true;
      Utils.snackBar('Error', error.toString());
    });
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
