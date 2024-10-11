import 'package:cold_storage_flutter/i10n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../repository/forgot_password_repository/forgot_password_repository.dart';
import '../../res/routes/routes_name.dart';
import '../../utils/utils.dart';

class ResetPasswordViewModel extends GetxController{
  dynamic argumentData = Get.arguments;
  final _api = ForgotPasswordRepository();

  final RxBool obscured = true.obs;
  final RxBool obscuredConfirm = true.obs;
  String email = '';
  final otpController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final conPasswordController = TextEditingController().obs;
  final otpFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  final conPasswordFocusNode = FocusNode().obs;

  @override
  void onInit() {
    if (argumentData != null) {
      email = argumentData['user_email'];
    }
    super.onInit();
  }

  void toggleObscured() {
    obscured.value = !obscured.value;
  }

  void toggleConfirmObscured() {
    obscuredConfirm.value = !obscuredConfirm.value;
  }

  Future<void> resetPassword() async {
    EasyLoading.show(status: t.loading);
    Map data = {
      "email":email.toString(),
      "otp": otpController.value.text.toString(),
      "password":passwordController.value.text.toString(),
      "password_confirmation":conPasswordController.value.text.toString()
    };
    _api.resetPasswordApi(data).then((value) {
      if (value['status'] == 0) {

      } else {
        // UpdateProfileModel profileData = UpdateProfileModel.fromJson(value);
        // userPreference.saveUserOnProfileUpdate(profileData);
        // EasyLoading.dismiss();
        Get.delete<ResetPasswordViewModel>();
        Get.offAllNamed(RouteName.loginView)!.then((value) {});
        Utils.snackBar(t.success_text, t.password_reset_success_text);
      }
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar(t.error_text, error.toString());
    });
  }

}