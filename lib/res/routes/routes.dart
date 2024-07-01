import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/screens/account_create.dart';
import 'package:cold_storage_flutter/screens/sign_in.dart';
import 'package:cold_storage_flutter/screens/sign_up.dart';
import 'package:cold_storage_flutter/screens/splash_screen.dart';
import 'package:cold_storage_flutter/screens/take_subscription.dart';
import 'package:cold_storage_flutter/screens/thankyou_sign_up.dart';
import 'package:cold_storage_flutter/screens/user_create.dart';
import 'package:get/get.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.splashScreen,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: RouteName.loginView,
          page: () => const SignIn(),
        ),
        GetPage(
          name: RouteName.accountView,
          page: () => const AccountCreate(),
        ),
        GetPage(
          name: RouteName.signUpView,
          page: () => const SignUp(),
        ),
        GetPage(
          name: RouteName.thankYousignUpView,
          page: () => const ThankyouSignUp(),
        ),

        GetPage(
          name: RouteName.takeSubscriptionView,
          page: () => const TakeSubscription(),
        ),

        GetPage(
          name: RouteName.createUserView,
          page: () => const UserCreate(),
        ),
      ];
}
