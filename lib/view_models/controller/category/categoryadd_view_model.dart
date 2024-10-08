import 'package:cold_storage_flutter/repository/category_repository/category_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/material/creatematerial_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';

class CategoryaddViewModel extends GetxController {
  final _api = CategoryRepository();

  final nameController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;

  final nameFocusNode = FocusNode().obs;
  final descriptionFocusNode = FocusNode().obs;

  RxBool loading = false.obs;

  void addCategory(BuildContext context) {
    loading.value = true;
    EasyLoading.show(status: t.loading);
    Map data = {
      'name': Utils.textCapitalizationString(nameController.value.text),
      'description': Utils.textCapitalizationString(descriptionController.value.text),
      'status': '1'
    };
    _api.addCategory(data).then((value) {
      loading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Login', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar(t.category, t.category_added_success_text);
        final creatematerialViewModel = Get.put(CreatematerialViewModel());
        creatematerialViewModel.getMaterialCategorie();
        Navigator.pop(context);
       
     }
    }).onError((error, stackTrace) {
      loading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }
}
