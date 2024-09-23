import 'dart:io';

import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/services/notification/fcm_notification_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../repository/forgot_password_repository/forgot_password_repository.dart';
import '../../utils/utils.dart';

class ForgotPasswordViewModel extends GetxController{
  final _api = ForgotPasswordRepository();

  final emailController = TextEditingController().obs;
  final emailFocusNode = FocusNode().obs;


  Future<void> submitForEmail() async {
    EasyLoading.show(status: 'loading...');
    String deviceId = await FCMNotificationService.instance.getFbToken;
    Map data = {
      "email": emailController.value.text.toString(),
      "device_id" : deviceId,
      "device_type": Platform.isAndroid ? 'android' : 'ios'
    };
    _api.forgotPasswordApi(data).then((value) {
      if (value['status'] == 0) {

      } else {
        // UpdateProfileModel profileData = UpdateProfileModel.fromJson(value);
        // userPreference.saveUserOnProfileUpdate(profileData);
        // EasyLoading.dismiss();
        // Get.delete<ProfileUpdateSettingViewModel>();
        Get.toNamed(RouteName.resetPassword,arguments: {
          'user_email' : emailController.value.text.toString()
        })!.then((value) {});
        Utils.snackBar('Password', 'Email sent successfully');
      }
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

}