import 'dart:convert';

import 'package:cold_storage_flutter/models/signup/signup_model.dart';
import 'package:cold_storage_flutter/repository/signup_repository/signup_repository.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignupViewModel extends GetxController {
  final _api = SignupRepository();

  UserPreference userPreference = UserPreference();

final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final conpasswordController = TextEditingController().obs;

 final nameFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  final conpasswordFocusNode = FocusNode().obs;
  RxString contactNumber = ''.obs;

  RxBool loading = false.obs;

  void signUpApi() {
    loading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {
      'name': nameController.value.text,
      'email': emailController.value.text,
      'password': passwordController.value.text,
      'contact_number': contactNumber.toString(),
      'device_id': '123456789',
      'device_type': 'android'
    };
    _api.signupApi(data).then((value) {
      loading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        Utils.snackBar('Login', value['message']);
      } else {
        SignupModel signupModel = SignupModel.fromJson(value);

        Get.delete<SignupViewModel>();
        Get.offAllNamed(RouteName.thankYousignUpView)!.then((value) {});
        Utils.snackBar('Sign Up', 'Sign Up successfully');
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }
}
