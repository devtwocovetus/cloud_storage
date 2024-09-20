import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'notification/fcm_notification_services.dart';
import 'package:cold_storage_flutter/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';

class SplashServices {
  UserPreference userPreference = UserPreference();

  Future<void> isLogin() async {
    _initPlatformState();

     bool? isLogin = await userPreference.getUserIsLogin();
     int? currentStatus = await userPreference.getCurrentAccountStatus();
    
     print('<><><> $isLogin');
     print('<><><> $currentStatus');

     if (isLogin == false || isLogin.toString() == 'null') {
       Timer(const Duration(seconds: 3),
           () => Get.offAllNamed(RouteName.loginView));
     } else {
       await userPreference.getUserInfo();
       String? userRole = await userPreference.getRole();
       Utils.decodedMap =  json.decode(userRole!);

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

  Future<void> _initPlatformState() async {
    // AppDeepLinkService().init();
    //
    // _app.init();
    //
    // WidgetsBinding.instance.addObserver(_app.appLifecycleHandler!);
    log('I am Here In the background11');
    FirebaseMessaging.instance.getInitialMessage().then(
          (RemoteMessage? message) =>
          FCMNotificationService.instance.defaultOnLaunch(message),
    );
  }

  }
// }
