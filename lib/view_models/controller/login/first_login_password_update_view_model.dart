import 'dart:developer';

import 'package:cold_storage_flutter/i10n/strings.g.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../repository/login_repository/login_repository.dart';
import '../../../res/routes/routes_name.dart';
import '../../../utils/utils.dart';

class FirstLoginPasswordUpdateViewModel extends GetxController{
  dynamic argumentData = Get.arguments;
  final _api = LoginRepository();

  int userId = 0;
  final RxBool obscured = true.obs;
  final RxBool obscuredConfirm = true.obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;

  final passwordFocusNode = FocusNode().obs;
  final confirmPasswordFocusNode = FocusNode().obs;

  void toggleObscured() {
    obscured.value = !obscured.value;
  }

  void toggleConfirmObscured() {
    obscuredConfirm.value = !obscuredConfirm.value;
  }

  @override
  void onInit() {
    if (argumentData != null) {
      userId = argumentData['user_id'];
    }
    super.onInit();
  }

  void logout() {
    UserPreference userPreference = UserPreference();
    userPreference.logout();
    Get.offAllNamed(RouteName.loginView);
    // Get.offAndToNamed(RouteName.loginView);
  }

  Future<void> submitPassword() async {
    if(userId == 0){
      userId = await UserPreference().getUserId() ?? 0;
    }
    EasyLoading.show(status: t.loading);
    Map data = {
      "id":userId.toString(),
      "password": passwordController.value.text.toString(),
      "password_confirmation": confirmPasswordController.value.text.toString()
    };
    _api.createPasswordApi(data).then((value) {
      log('Password Updated : $value');
      if (value['status'] == 0) {

      } else {
        log('Password Updated : $value');
        UserPreference userPreference = UserPreference();
        userPreference.changeFirstTimeLoginStatus(0);
        EasyLoading.dismiss();
        Get.delete<FirstLoginPasswordUpdateViewModel>();
        Get.offAllNamed(RouteName.homeScreenView)!.then((value) {});
        Utils.snackBar(t.success_text, t.password_updated_success_text);
      }
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

}