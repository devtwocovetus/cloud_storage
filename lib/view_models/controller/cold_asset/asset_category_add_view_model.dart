
import 'package:cold_storage_flutter/repository/cold_asset_repository/cold_asset_repository.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/cold_asset/cold_asset_view_model.dart';
import 'package:cold_storage_flutter/view_models/controller/cold_asset/update/update_asset_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AssetCategoryAddViewModel extends GetxController {
  AssetCategoryAddViewModel({required this.incomingStatus});
  int incomingStatus;
  final _api = ColdAssetRepository();

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
      'description': Utils.textCapitalizationString(descriptionController.value.text),
      'status': '1'
    };
    _api.postAddCategory(data).then((value) {
      loading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Login', value['message']);
      } else {
        Utils.isCheck = true;
        Utils.snackBar('Category', 'Category added successfully');
        if(incomingStatus != 0){
          final updateAssetViewModel = Get.put(UpdateAssetViewModel());
          updateAssetViewModel.getCategory();
          Navigator.pop(context);
        }else{
          final creatematerialViewModel = Get.put(ColdAssetViewModel());
          creatematerialViewModel.getCategory();
          Navigator.pop(context);
        }
       
     }
    }).onError((error, stackTrace) {
      loading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
