import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordViewModel extends GetxController{

  final emailController = TextEditingController().obs;
  final emailFocusNode = FocusNode().obs;

}