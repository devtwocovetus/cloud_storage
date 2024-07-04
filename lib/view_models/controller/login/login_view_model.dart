import 'dart:developer';

import 'package:cold_storage_flutter/models/login/login_model.dart';
import 'package:cold_storage_flutter/repository/login_repository/login_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  final _api = LoginRepository();

  UserPreference userPreference = UserPreference();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool loading = false.obs;

  void loginApi() {
    loading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {
      'email': emailController.value.text,
      'password': passwordController.value.text,
      'device_id': '123456789',
      'device_type': 'android'
    };
    _api.loginApi(data).then((value) {
      loading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        Utils.snackBar('Login', value['message']);
      } else {
        LoginModel loginModel = LoginModel.fromJson(value);

        log('Respos : ${value.toString()}');
        userPreference.saveUser(loginModel).then((value) {
          // releasing resources because we are not going to use this

          if (loginModel.data!.currentAccountStatus == 1) {
            Get.delete<LoginViewModel>();
            Get.offAllNamed(RouteName.accountView)!.then((value) {});
          } else if (loginModel.data!.currentAccountStatus == 2) {
            Get.delete<LoginViewModel>();
            Get.offAllNamed(RouteName.entityOnboarding)!.then((value) {});
          } else if (loginModel.data!.currentAccountStatus == 3) {
            Get.delete<LoginViewModel>();
            ///Will be removed
            Get.offAllNamed(RouteName.entityOnboarding)!.then((value) {});
          } else if (loginModel.data!.currentAccountStatus == 4) {
            Get.delete<LoginViewModel>();
            Get.offAllNamed(RouteName.takeSubscriptionView)!.then((value) {});
          }
          Utils.snackBar('Login', 'Login successfully');
        }).onError((error, stackTrace) {});
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
