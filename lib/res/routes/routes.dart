import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/screens/account_create.dart';
import 'package:cold_storage_flutter/screens/category/category_add.dart';
import 'package:cold_storage_flutter/screens/client/add_new_client.dart';
import 'package:cold_storage_flutter/screens/cold_storage_warehouse/create_warehouse.dart';
import 'package:cold_storage_flutter/screens/entity/entity_list_demo.dart';
import 'package:cold_storage_flutter/screens/entity/entity_list_screen.dart';
import 'package:cold_storage_flutter/screens/entity/entity_onboarding.dart';
import 'package:cold_storage_flutter/screens/entity/new_entity_list_screen.dart';

import 'package:cold_storage_flutter/screens/farmhouse_grover/create_farmhouse_grover.dart';

import 'package:cold_storage_flutter/screens/home_screen.dart';
import 'package:cold_storage_flutter/screens/material/material_create.dart';
import 'package:cold_storage_flutter/screens/material/material_list_screen.dart';

import 'package:cold_storage_flutter/screens/sign_in.dart';
import 'package:cold_storage_flutter/screens/sign_up.dart';
import 'package:cold_storage_flutter/screens/splash_screen.dart';
import 'package:cold_storage_flutter/screens/take_subscription.dart';
import 'package:cold_storage_flutter/screens/thankyou_sign_up.dart';
import 'package:cold_storage_flutter/screens/user/user_list.dart';
import 'package:cold_storage_flutter/screens/user_create.dart';
import 'package:get/get.dart';

import '../../screens/entity/entity_dashboard.dart';
import '../../screens/material/add_material_quantity.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.accountView,
          page: () => const AccountCreate(),
        ),
        GetPage(
          name: RouteName.splashScreen,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: RouteName.loginView,
          page: () => const SignIn(),
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
          name: RouteName.entityOnboarding,
          page: () => EntityOnboarding(),
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
        GetPage(
          name: RouteName.createFarmhouse,
          page: () => CreateFarmhouseGrover(),
        ),
        GetPage(
          name: RouteName.homeScreenView,
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: RouteName.entityListScreen,
          page: () => const EntityListScreen(),
        ),
        GetPage(
          name: RouteName.entityListDemoScreen,
          page: () => EntityListDemo(),
        ),
        GetPage(
          name: RouteName.entityDashboard,
          page: () => EntityDashboard(),
        ),
        GetPage(
          name: RouteName.newEntityListScreen,
          page: () => const NewEntityListScreen(),
        ),
        GetPage(
          name: RouteName.materialListScreen,
          page: () => const MaterialListScreen(),
        ),
        GetPage(
          name: RouteName.createMaterialScreen,
          page: () => const MaterialCreate(),
        ),
        GetPage(
          name: RouteName.addCategoryScreen,
          page: () => const CategoryAdd(),
        ),
        
        GetPage(
         name: RouteName.addMaterialQuantityScreen,
          page: () => AddMaterialQuantity(),
        ),
        GetPage(
         name: RouteName.addNewClientScreen,
          page: () => AddNewClient(),
        ),

      ];

          
  

}
