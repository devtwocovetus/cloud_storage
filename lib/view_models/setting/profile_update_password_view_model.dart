import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../repository/profile_repository/profile_repository.dart';
import '../../res/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../controller/user_preference/user_prefrence_view_model.dart';

class ProfileUpdatePasswordViewModel extends GetxController{
  final _api = ProfileRepository();

  final RxBool obscured = true.obs;
  final RxBool obscuredConfirm = true.obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;

  final passwordFocusNode = FocusNode().obs;
  final confirmPasswordFocusNode = FocusNode().obs;
  String userId = '';

  void toggleObscured() {
    obscured.value = !obscured.value;
  }

  void toggleConfirmObscured() {
    obscuredConfirm.value = !obscuredConfirm.value;
  }

  Future<void> submitPasswordForm() async {
    EasyLoading.show(status: 'loading...');
    UserPreference userPreference = UserPreference();
    int id = await userPreference.getUserId() ?? 0;
    userId = id != 0 ? id.toString() : '';
    Map data = {
      "id": userId,
      "password": passwordController.value.text.toString(),
      "password_confirmation": confirmPasswordController.value.text.toString()
    };
    _api.passwordUpdateApi(data).then((value) {
      log('passwordUpdate : $value');
      if (value['status'] == 0) {

      } else {
        EasyLoading.dismiss();
         UserPreference userPreference = UserPreference();
         userPreference.logout();
         Get.offAllNamed(RouteName.loginView);
         Utils.snackBar('Success', 'Password updated successfully');
      }
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
    
  }

}