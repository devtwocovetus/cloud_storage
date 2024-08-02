import 'dart:async';

import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:get/get.dart';

class SplashServices {
  UserPreference userPreference = UserPreference();

  Future<void> isLogin() async {

    
     bool? isLogin = await userPreference.getUserIsLogin();
     int? currentStatus = await userPreference.getCurrentAccountStatus();
     print('<><><> $isLogin');
     print('<><><> $currentStatus');

     if (isLogin == false || isLogin.toString() == 'null') {
       Timer(const Duration(seconds: 3),
           () => Get.offAllNamed(RouteName.loginView));
     } else {
       if (currentStatus == 1) {
        Timer(const Duration(seconds: 3),
             () => Get.offAllNamed(RouteName.accountView));
       } else if (currentStatus == 4) {
        Timer(const Duration(seconds: 3),
            () => Get.offAllNamed(RouteName.takeSubscriptionView));
      } else {
        Timer(const Duration(seconds: 3),
            () => Get.offAllNamed(RouteName.entityOnboarding));
       }
    }
    }
  }
// }
