

import 'dart:async';

import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SplashServices {

  UserPreference userPreference = UserPreference();

  void isLogin(){

    userPreference.getUserIsLogin().then((value){

      if (kDebugMode) {
        print(value);
      }

      if(value == false || value.toString() == 'null'){
        Timer(const Duration(seconds: 3) ,
                () => Get.offAllNamed(RouteName.takeSubscriptionView) );
      }else {
         Timer(const Duration(seconds: 3) ,
                 () => Get.offAllNamed(RouteName.takeSubscriptionView) );
      }
    });


  }
}