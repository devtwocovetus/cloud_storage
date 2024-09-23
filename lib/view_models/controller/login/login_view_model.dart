import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cold_storage_flutter/models/login/login_model.dart';
import 'package:cold_storage_flutter/repository/login_repository/login_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../services/notification/fcm_notification_services.dart';

class LoginViewModel extends GetxController {
  final _api = LoginRepository();
  
   var roleList = <Permissions>[].obs;
     Map<String, dynamic> userRoleList = {};
  UserPreference userPreference = UserPreference();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool loading = false.obs;

  Future<void> loginApi() async {
    loading.value = true;
    EasyLoading.show(status: 'loading...');
    String deviceId = await FCMNotificationService.instance.getFbToken;
    Map data = {
      'email': emailController.value.text.toString().trim(),
      'password': passwordController.value.text.toString().trim(),
      'device_id': deviceId,
      'device_type': Platform.isAndroid ? 'android' : 'ios'
    };
    _api.loginApi(data).then((value) {
      loading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        // Utils.snackBar('Login', value['message']);
      } else {
        LoginModel loginModel = LoginModel.fromJson(value);
        log('Respos : ${value.toString()}');
        roleList.value = loginModel.data!.permissions!.map((data) => data).toList();
        for (Permissions permissions in roleList) {
          userRoleList[permissions.name.toString()] = permissions.status!;
        }
        Utils.decodedMap = userRoleList;
        String encodedMap = json.encode(userRoleList);
        userPreference.saveUser(loginModel,encodedMap).then((value) {
          if (loginModel.data!.currentAccountStatus == 1) {
            Get.delete<LoginViewModel>();
            Get.offAllNamed(RouteName.accountView)!.then((value) {});
          } else if (loginModel.data!.currentAccountStatus == 2) {
            Get.delete<LoginViewModel>();
            Get.offAllNamed(RouteName.homeScreenView)!.then((value) {});
          } else if (loginModel.data!.currentAccountStatus == 3) {
            Get.delete<LoginViewModel>();
            Get.offAllNamed(RouteName.homeScreenView)!.then((value) {});
          } else if (loginModel.data!.currentAccountStatus == 4) {
            Get.delete<LoginViewModel>();
            Get.offAllNamed(RouteName.takeSubscriptionView)!.then((value) {});
          }

          Utils.snackBar('Success', 'Logged in successfully');
        }).onError((error, stackTrace) {});
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
