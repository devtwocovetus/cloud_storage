import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/screens/account_create.dart';
import 'package:cold_storage_flutter/screens/cold_storage_warehouse/create_warehouse.dart';
import 'package:cold_storage_flutter/screens/entity/entity_onboarding.dart';
import 'package:cold_storage_flutter/screens/sign_in.dart';
import 'package:cold_storage_flutter/screens/sign_up.dart';
import 'package:cold_storage_flutter/screens/splash_screen.dart';
import 'package:cold_storage_flutter/screens/take_subscription.dart';
import 'package:cold_storage_flutter/screens/thankyou_sign_up.dart';
import 'package:cold_storage_flutter/screens/user/user_list.dart';
import 'package:cold_storage_flutter/screens/user_create.dart';
import 'package:get/get.dart';

class AppRoutes {
  static appRoutes() => [

    GetPage(
      name: RouteName.accountView,
      page: () => const AccountCreate() ,
    ),
    GetPage(
      name: RouteName.splashScreen,
      page: () => const SplashScreen() ,
    ) ,
    GetPage(
      name: RouteName.loginView,
      page: () => const SignIn() ,
    ) ,
    GetPage(
      name: RouteName.signUpView,
      page: () => const SignUp(),
    ),
    GetPage(
      name: RouteName.thankYousignUpView,
      page: () => const ThankyouSignUp(),
    ),
    GetPage(
      name: RouteName.entityOnboarding,
      page: () => const EntityOnboarding(),
    ),
    GetPage(
      name: RouteName.createWarehouse,
      page: () => CreateWarehouse(),
    ),
    GetPage(
      name: RouteName.takeSubscriptionView,
      page: () => const TakeSubscription(),
    ),
    GetPage(
      name: RouteName.userListView,
      page: () => UserList(),
    ),
    GetPage(
      name: RouteName.createUserView,
      page: () => const UserCreate(),
    ),

  ];
}
