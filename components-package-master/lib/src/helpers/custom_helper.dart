import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum SnackBarStates { success, error }

abstract class CustomHelper {
  static SystemUiOverlayStyle setTheSystemUIOverlayStyle({
    Color systemNavigationBarColor = Colors.transparent,
    Color statusBarColor = Colors.transparent,
    Brightness statusBarBrightness = Brightness.light,
    Brightness statusBarIconBrightness = Brightness.light,
    Color systemNavigationBarDividerColor = Colors.white,
  }) {
    return SystemUiOverlayStyle(
      systemNavigationBarColor: systemNavigationBarColor,
      statusBarColor: statusBarColor,
      statusBarBrightness: statusBarBrightness,
      statusBarIconBrightness: statusBarIconBrightness,
      systemNavigationBarDividerColor: systemNavigationBarDividerColor,
    );
  }

  static SnackbarController buildSnackBar({
    required BuildContext context,
    required String message,
    required SnackBarStates state,
    required String title,
    TextStyle? titleStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    TextStyle? messageStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    Duration? duration = const Duration(milliseconds: 3500),
    SnackPosition? snackPosition = SnackPosition.BOTTOM,
    SnackStyle? snackStyle = SnackStyle.FLOATING,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? borderRadius,
    List<BoxShadow>? boxShadows,
    Curve? forwardAnimationCurve,
    Curve? reverseAnimationCurve,
    Duration? animationDuration = const Duration(milliseconds: 400),
  }) {
    return Get.snackbar(
      "",
      "",
      titleText: Text(
        title,
        style: titleStyle,
      ),
      messageText: Text(
        message,
        style: messageStyle,
      ),
      duration: duration,
      snackPosition: snackPosition,
      snackStyle: snackStyle,
      icon: state == SnackBarStates.error
          ? const Icon(
              Icons.warning,
              color: Colors.white,
              size: 35,
            )
          : const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 35,
            ),
      shouldIconPulse: state == SnackBarStates.error ? true : false,
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 22.0,
          ),
      margin: margin ??
          const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 32.0,
          ),
      borderRadius: borderRadius ?? 16.0,
      backgroundColor: chooseSnackBarClr(state),
      boxShadows: boxShadows ??
          [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(2, 5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
      forwardAnimationCurve: forwardAnimationCurve ?? Curves.easeInBack,
      reverseAnimationCurve: reverseAnimationCurve ?? Curves.easeOutBack,
      animationDuration: animationDuration,
    );
  }

  static Color chooseSnackBarClr(SnackBarStates state) {
    Color color;
    switch (state) {
      case SnackBarStates.success:
        color = Colors.green;
        break;
      case SnackBarStates.error:
        color = Colors.red;
        break;
    }
    return color;
  }

  static void validatingPasswordField({
    required BuildContext context,
    String? value,
    Duration? duration = const Duration(milliseconds: 3500),
    SnackPosition? snackPosition = SnackPosition.BOTTOM,
    SnackStyle? snackStyle = SnackStyle.FLOATING,
    Curve? forwardAnimationCurve,
    Curve? reverseAnimationCurve,
    Duration? animationDuration = const Duration(milliseconds: 400),
  }) {
    if (value!.isEmpty) {
      CustomHelper.buildSnackBar(
        context: context,
        title: "Something went wrong",
        message: "Enter your Password!",
        state: SnackBarStates.error,
        duration: duration,
        forwardAnimationCurve: forwardAnimationCurve ?? Curves.easeInBack,
        reverseAnimationCurve: reverseAnimationCurve ?? Curves.easeOutBack,
        animationDuration: animationDuration,
        snackPosition: snackPosition,
        snackStyle: snackStyle,
      );
    } else if (value.length < 8) {
      CustomHelper.buildSnackBar(
        context: context,
        title: "Something went wrong",
        message: "Too short password!",
        state: SnackBarStates.error,
        duration: duration,
        forwardAnimationCurve: forwardAnimationCurve ?? Curves.easeInBack,
        reverseAnimationCurve: reverseAnimationCurve ?? Curves.easeOutBack,
        animationDuration: animationDuration,
        snackPosition: snackPosition,
        snackStyle: snackStyle,
      );
    }
  }

  static void validatingEmailField({
    required BuildContext context,
    String? value,
    Duration? duration = const Duration(milliseconds: 3500),
    SnackPosition? snackPosition = SnackPosition.BOTTOM,
    SnackStyle? snackStyle = SnackStyle.FLOATING,
    Curve? forwardAnimationCurve,
    Curve? reverseAnimationCurve,
    Duration? animationDuration = const Duration(milliseconds: 400),
  }) {
    if (value!.isEmpty) {
      CustomHelper.buildSnackBar(
        context: context,
        title: "Something went wrong",
        message: "Enter your Email!",
        state: SnackBarStates.error,
        duration: duration,
        forwardAnimationCurve: forwardAnimationCurve ?? Curves.easeInBack,
        reverseAnimationCurve: reverseAnimationCurve ?? Curves.easeOutBack,
        animationDuration: animationDuration,
        snackPosition: snackPosition,
        snackStyle: snackStyle,
      );
    } else if (!value.contains('@')) {
      CustomHelper.buildSnackBar(
        context: context,
        title: "Something went wrong",
        message: "Incorrect Email!",
        state: SnackBarStates.error,
        duration: duration,
        forwardAnimationCurve: forwardAnimationCurve ?? Curves.easeInBack,
        reverseAnimationCurve: reverseAnimationCurve ?? Curves.easeOutBack,
        animationDuration: animationDuration,
        snackPosition: snackPosition,
        snackStyle: snackStyle,
      );
    }
  }

  static void validatingPhoneField({
    required BuildContext context,
    String? value,
    Duration? duration = const Duration(milliseconds: 3500),
    SnackPosition? snackPosition = SnackPosition.BOTTOM,
    SnackStyle? snackStyle = SnackStyle.FLOATING,
    Curve? forwardAnimationCurve,
    Curve? reverseAnimationCurve,
    Duration? animationDuration = const Duration(milliseconds: 400),
  }) {
    if (value!.isEmpty) {
      CustomHelper.buildSnackBar(
        context: context,
        title: "Something went wrong",
        message: "Enter your Phone Number!",
        state: SnackBarStates.error,
        duration: duration,
        forwardAnimationCurve: forwardAnimationCurve ?? Curves.easeInBack,
        reverseAnimationCurve: reverseAnimationCurve ?? Curves.easeOutBack,
        animationDuration: animationDuration,
        snackPosition: snackPosition,
        snackStyle: snackStyle,
      );
    } else if (value.length < 10) {
      CustomHelper.buildSnackBar(
        context: context,
        title: "Something went wrong",
        message: "Too short Phone Number!",
        state: SnackBarStates.error,
        duration: duration,
        forwardAnimationCurve: forwardAnimationCurve ?? Curves.easeInBack,
        reverseAnimationCurve: reverseAnimationCurve ?? Curves.easeOutBack,
        animationDuration: animationDuration,
        snackPosition: snackPosition,
        snackStyle: snackStyle,
      );
    }
  }

  static void validatingConfirmPassField({
    required BuildContext context,
    required TextEditingController passController,
    String? value,
    Duration? duration = const Duration(milliseconds: 3500),
    SnackPosition? snackPosition = SnackPosition.BOTTOM,
    SnackStyle? snackStyle = SnackStyle.FLOATING,
    Curve? forwardAnimationCurve,
    Curve? reverseAnimationCurve,
    Duration? animationDuration = const Duration(milliseconds: 400),
  }) {
    if (value! != passController.text) {
      CustomHelper.buildSnackBar(
        context: context,
        title: "Something went wrong",
        message: "Password doesn't match!",
        state: SnackBarStates.error,
        duration: duration,
        forwardAnimationCurve: forwardAnimationCurve ?? Curves.easeInBack,
        reverseAnimationCurve: reverseAnimationCurve ?? Curves.easeOutBack,
        animationDuration: animationDuration,
        snackPosition: snackPosition,
        snackStyle: snackStyle,
      );
    } else if (value.isEmpty) {
      CustomHelper.buildSnackBar(
        context: context,
        title: "Something went wrong",
        message: "Confirm your Password!",
        state: SnackBarStates.error,
        duration: duration,
        forwardAnimationCurve: forwardAnimationCurve ?? Curves.easeInBack,
        reverseAnimationCurve: reverseAnimationCurve ?? Curves.easeOutBack,
        animationDuration: animationDuration,
        snackPosition: snackPosition,
        snackStyle: snackStyle,
      );
    }
  }

  static void validatingNameField({
    required BuildContext context,
    String? value,
    Duration? duration = const Duration(milliseconds: 3500),
    SnackPosition? snackPosition = SnackPosition.BOTTOM,
    SnackStyle? snackStyle = SnackStyle.FLOATING,
    Curve? forwardAnimationCurve,
    Curve? reverseAnimationCurve,
    Duration? animationDuration = const Duration(milliseconds: 400),
  }) {
    if (value!.isEmpty) {
      CustomHelper.buildSnackBar(
        context: context,
        title: "Something went wrong",
        message: "Name can't be blank!",
        state: SnackBarStates.error,
        duration: duration,
        forwardAnimationCurve: forwardAnimationCurve ?? Curves.easeInBack,
        reverseAnimationCurve: reverseAnimationCurve ?? Curves.easeOutBack,
        animationDuration: animationDuration,
        snackPosition: snackPosition,
        snackStyle: snackStyle,
      );
    }
  }

  static void keyboardUnfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
