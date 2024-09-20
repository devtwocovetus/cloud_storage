import 'dart:io';

import 'package:cold_storage_flutter/view_models/services/notification/fcm_notification_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../repository/forgot_password_repository/forgot_password_repository.dart';
import '../../utils/utils.dart';

class ResetPasswordViewModel extends GetxController{
  dynamic argumentData = Get.arguments;
  final _api = ForgotPasswordRepository();

  final RxBool obscured = true.obs;
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

  Future<void> submitForEmail() async {
    EasyLoading.show(status: 'loading...');
    String deviceId = await FCMNotificationService.instance.getFbToken;
    Map data = {
      "email":"testing787using@gmail.com",
      "otp": 660944,
      "password":"Cold@123",
      "password_confirmation":"Cold@123"
    };
    _api.forgotPasswordApi(data).then((value) {
      if (value['status'] == 0) {

      } else {
        // UpdateProfileModel profileData = UpdateProfileModel.fromJson(value);
        // userPreference.saveUserOnProfileUpdate(profileData);
        // EasyLoading.dismiss();
        // Get.delete<ProfileUpdateSettingViewModel>();
        // Get.offAllNamed(RouteName.homeScreenView)!.then((value) {});
        Utils.snackBar('Password', 'Email sent successfully');
      }
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

}