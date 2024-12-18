import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'notification/fcm_notification_services.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';

class SplashServices {
  UserPreference userPreference = UserPreference();

  Future<void> isLogin() async {
    _checkForNotificationTap();
  }

  void _checkForNotificationTap() async {
    bool? isLogin = await userPreference.getUserIsLogin();
    int? currentStatus = await userPreference.getCurrentAccountStatus();
    int? userFirstTimeLogin = await userPreference.getUserFirstTimeLogin();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Check if the app was launched in the background from a terminated state via notification
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      // Handle the notification when the app is opened from a terminated state

      if (isLogin == false || isLogin.toString() == 'null') {
        Timer(const Duration(seconds: 3),
            () => Get.offAllNamed(RouteName.loginView));
      } else {
        await userPreference.getUserInfo();
        String? userRole = await userPreference.getRole();
        Utils.decodedMap = json.decode(userRole!);
        FCMNotificationService.instance.defaultOnLaunch(initialMessage);
      }
    } else {
      if (isLogin == false || isLogin.toString() == 'null') {
        Timer(const Duration(seconds: 3),
            () => Get.offAllNamed(RouteName.loginView));
      } else {
        await userPreference.getUserInfo();
        String? userRole = await userPreference.getRole();
        Utils.decodedMap = json.decode(userRole!);

        if (userFirstTimeLogin != 0) {
          Timer(const Duration(seconds: 3),
              () => Get.offAllNamed(RouteName.changePasswordOnFirstLogin));
        } else {
          if (currentStatus == 1) {
            Timer(const Duration(seconds: 3),
                () => Get.offAllNamed(RouteName.accountView));
          } else if (currentStatus == 4) {
            Timer(const Duration(seconds: 3),
                () => Get.offAllNamed(RouteName.takeSubscriptionView));
          } else {
            Timer(const Duration(seconds: 3),
                () => Get.offAllNamed(RouteName.homeScreenView));
          }
        }
      }
    }
  }
}
// }
