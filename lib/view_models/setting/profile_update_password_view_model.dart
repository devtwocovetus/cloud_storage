import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileUpdatePasswordViewModel extends GetxController{

  final RxBool obscured = true.obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;

  final passwordFocusNode = FocusNode().obs;
  final confirmPasswordFocusNode = FocusNode().obs;

  void toggleObscured() {
    obscured.value = !obscured.value;
  }
}