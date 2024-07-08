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

  final firstNameController = TextEditingController().obs;
  final lastNameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final otpController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final conpasswordController = TextEditingController().obs;

  final firstNameFocusNode = FocusNode().obs;
  final lastNameFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;
  final otpFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  final conpasswordFocusNode = FocusNode().obs;
  RxString contactNumber = ''.obs;

  RxBool loading = false.obs;
  RxBool isOtpSent = false.obs;

  @override
  void onInit() {
    otpController.value.text = '123456';
    super.onInit();
  }

  int validateForOtp() {
    int statusCode = 0;
    if (firstNameController.value.text.isEmpty ||
        lastNameController.value.text.isEmpty ||
        emailController.value.text.isEmpty) {
      statusCode = 0;
    } else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.value.text)){
      statusCode = 2;
    }else{
      statusCode = 1;
    }
    return statusCode;
  }

  void sendOtp() {
    loading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {
      'first_name': firstNameController.value.text,
      'last_name': lastNameController.value.text,
      'email': emailController.value.text,
    };
    _api.signupSendOtpApi(data).then((value) {
      loading.value = false;
      EasyLoading.dismiss();
      if (value['status'] == 0) {
        Utils.snackBar('Error', value['message']);
      } else {
        isOtpSent.value = true;
        Utils.snackBar('Otp', ' Otp is sent to the email address');
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      EasyLoading.dismiss();
      Utils.snackBar('Error', error.toString());
    });
  }

  void signUpApi() {
    loading.value = true;
    EasyLoading.show(status: 'loading...');
    Map data = {
      'first_name': firstNameController.value.text,
      'last_name': lastNameController.value.text,
      'email': emailController.value.text,
      'otp': otpController.value.text,
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
