import 'package:cold_storage_flutter/repository/login_repository/login_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';

class ProfileDashboardViewModel extends GetxController {
  final _api = LoginRepository();

  RxString userName = ''.obs;
  RxBool isEntity = false.obs;
  RxBool isClient = false.obs;
  RxBool isMaterial = false.obs;
  RxBool isAsset = false.obs;
  RxBool btnStatus = false.obs;

  @override
  void onInit() {
    print('<><>##@@ ${Utils.decodedMap.toString()}');
    super.onInit();
  }

  void logout() {
    UserPreference userPreference = UserPreference();
    userPreference.logout();
    Get.offAllNamed(RouteName.loginView);
    // Get.offAndToNamed(RouteName.loginView);
  }

  Future getAppLogOut() async{
    EasyLoading.show(status: t.loading);
    _api.logOutApi().then((value) {
      EasyLoading.dismiss();
      if (value['status'] == 0) {

      } else {
        logout();
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }


}
