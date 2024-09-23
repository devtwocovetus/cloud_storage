import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../repository/login_repository/login_repository.dart';
import '../../../utils/utils.dart';

class FirstLoginPasswordUpdateViewModel extends GetxController{
  dynamic argumentData = Get.arguments;
  final _api = LoginRepository();

  int userId = 0;
  final RxBool obscured = true.obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;

  final passwordFocusNode = FocusNode().obs;
  final confirmPasswordFocusNode = FocusNode().obs;

  void toggleObscured() {
    obscured.value = !obscured.value;
  }

  @override
  void onInit() {
    if (argumentData != null) {
      userId = argumentData['user_id'];
    }
    super.onInit();
  }

  Future<void> submitPassword() async {
    EasyLoading.show(status: 'loading...');
    Map data = {
      "id":660,
      "password":"Cold@123",
      "password_confirmation":"Cold@123"
    };
    // _api.forgotPasswordApi(data).then((value) {
    //   if (value['status'] == 0) {
    //
    //   } else {
    //     // UpdateProfileModel profileData = UpdateProfileModel.fromJson(value);
    //     // userPreference.saveUserOnProfileUpdate(profileData);
    //     // EasyLoading.dismiss();
    //     // Get.delete<ProfileUpdateSettingViewModel>();
    //     // Get.offAllNamed(RouteName.homeScreenView)!.then((value) {});
    //     Utils.snackBar('Success', 'Password updated successfully');
    //   }
    //   EasyLoading.dismiss();
    // }).onError((error, stackTrace) {
    //   EasyLoading.dismiss();
    //   Utils.snackBar('Error', error.toString());
    // });
  }

}