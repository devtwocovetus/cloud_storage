import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../repository/category_repository/category_repository.dart';
import '../../../utils/utils.dart';
import '../material_in/update/update_material_view_model.dart';

class CategoryAddOnUpdateViewModel extends GetxController{
  final _api = CategoryRepository();

  final nameController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;

  final nameFocusNode = FocusNode().obs;
  final descriptionFocusNode = FocusNode().obs;

  RxBool loading = false.obs;
  void addCategory(BuildContext context) {
    loading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {
      'name': Utils.textCapitalizationString(nameController.value.text),
      'description':Utils.textCapitalizationString(descriptionController.value.text),
      'status': '1'
    };
    _api.addCategory(data).then((value) {
      loading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Login', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar('Category', 'Category added successfully');
        final updateMaterialViewModel = Get.put(UpdateMaterialViewModel());
        updateMaterialViewModel.getMaterialCategory();
        Navigator.pop(context);

      }
    }).onError((error, stackTrace) {
      loading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}