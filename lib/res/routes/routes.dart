import 'package:cold_storage_flutter/screens/change_password_on_first_login.dart';
import 'package:cold_storage_flutter/screens/entity_transfer/entity_list_for_transfer.dart';
import 'package:cold_storage_flutter/screens/forgot_password/reset_password.dart';
import 'package:cold_storage_flutter/screens/material/material_out/update/quantity_creation_material_out_update_form.dart';
import 'package:cold_storage_flutter/screens/setting/profile_update_password.dart';
import 'package:get/get.dart';
import 'package:cold_storage_flutter/screens/sign_in.dart';
import 'package:cold_storage_flutter/screens/sign_up.dart';
import 'package:cold_storage_flutter/screens/home_screen.dart';
import 'package:cold_storage_flutter/screens/user_create.dart';
import 'package:cold_storage_flutter/screens/splash_screen.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/screens/account_create.dart';
import 'package:cold_storage_flutter/screens/user/user_list.dart';
import 'package:cold_storage_flutter/screens/thankyou_sign_up.dart';
import 'package:cold_storage_flutter/screens/take_subscription.dart';
import 'package:cold_storage_flutter/screens/client/client_list.dart';
import 'package:cold_storage_flutter/screens/client/search_client.dart';
import 'package:cold_storage_flutter/screens/category/category_add.dart';
import 'package:cold_storage_flutter/screens/client/add_new_client.dart';
import 'package:cold_storage_flutter/screens/setting/account_update.dart';
import 'package:cold_storage_flutter/screens/entity/entity_list_demo.dart';
import 'package:cold_storage_flutter/screens/cold_asset/create_asset.dart';
import 'package:cold_storage_flutter/screens/entity/entity_dashboard.dart';
import 'package:cold_storage_flutter/screens/material/material_create.dart';
import 'package:cold_storage_flutter/screens/entity/entity_onboarding.dart';
import 'package:cold_storage_flutter/screens/user/update_user_setting.dart';
import 'package:cold_storage_flutter/screens/setting/user_list_setting.dart';
import 'package:cold_storage_flutter/screens/setting/setting_dashboard.dart';
import 'package:cold_storage_flutter/screens/entity/entity_list_screen.dart';
import 'package:cold_storage_flutter/screens/material/material_unit_list.dart';
import 'package:cold_storage_flutter/screens/setting/user_create_setting.dart';
import 'package:cold_storage_flutter/screens/client/client_detail_screen.dart';
import 'package:cold_storage_flutter/screens/cold_asset/asset_list_screen.dart';
import 'package:cold_storage_flutter/screens/setting/setting_subscription.dart';
import 'package:cold_storage_flutter/screens/entity/new_entity_list_screen.dart';
import 'package:cold_storage_flutter/screens/material/material_list_screen.dart';
import 'package:cold_storage_flutter/screens/cold_asset/update/update_asset.dart';
import 'package:cold_storage_flutter/screens/material/add_material_quantity.dart';
import 'package:cold_storage_flutter/screens/setting/profile_update_setting.dart';
import 'package:cold_storage_flutter/screens/cold_asset/asset_history_screen.dart';
import 'package:cold_storage_flutter/screens/material/material_in/material_in.dart';
import 'package:cold_storage_flutter/screens/setting/profile_dashbord_setting.dart';
import 'package:cold_storage_flutter/screens/transaction_log/transaction_in_out.dart';
import 'package:cold_storage_flutter/screens/setting/entity_list_setting_screen.dart';
import 'package:cold_storage_flutter/screens/material/material_out/material_out.dart';
import 'package:cold_storage_flutter/screens/inventory/inventory_unit_list_screen.dart';
import 'package:cold_storage_flutter/screens/transaction_log/transaction_log_list.dart';
import 'package:cold_storage_flutter/screens/inventory/inventory_client_list_screen.dart';
import 'package:cold_storage_flutter/screens/cold_storage_warehouse/update_warehouse.dart';
import 'package:cold_storage_flutter/screens/cold_storage_warehouse/create_warehouse.dart';
import 'package:cold_storage_flutter/screens/notification/transfer_notification_list.dart';
import 'package:cold_storage_flutter/screens/material/material_in/update_material_in.dart';
import 'package:cold_storage_flutter/screens/farmhouse_grover/update_farmhouse_grover.dart';
import 'package:cold_storage_flutter/screens/inventory/inventory_material_list_screen.dart';
import 'package:cold_storage_flutter/screens/farmhouse_grover/create_farmhouse_grover.dart';
import 'package:cold_storage_flutter/screens/gallary/app_gallery_view.dart';
import 'package:cold_storage_flutter/screens/material/update_material/update_material.dart';
import 'package:cold_storage_flutter/screens/material/material_in/thankyou_material_in.dart';
import 'package:cold_storage_flutter/screens/material/material_out/thankyou_material_out.dart';
import 'package:cold_storage_flutter/screens/material/transfer/transfer_material_mapping.dart';
import 'package:cold_storage_flutter/screens/material/transfer/transfer_incoming_material.dart';
import 'package:cold_storage_flutter/screens/inventory/inventory_transactions_list_screen.dart';
import 'package:cold_storage_flutter/screens/material/transfer/thankyou_material_in_client.dart';
import 'package:cold_storage_flutter/screens/inventory/inventory_transactions_detail_screen.dart';
import 'package:cold_storage_flutter/screens/setting/entity_list_assign_user_setting_screen.dart';
import 'package:cold_storage_flutter/screens/material/update_material/update_material_quantity.dart';
import 'package:cold_storage_flutter/screens/client_inventory/client_inventory_unit_list_screen.dart';
import 'package:cold_storage_flutter/screens/client_inventory/client_inventory_material_list_screen.dart';
import 'package:cold_storage_flutter/screens/material/material_out/quantity_creation_materialout_form.dart';
import 'package:cold_storage_flutter/screens/client_inventory/client_inventory_transactions_list_screen.dart';
import 'package:cold_storage_flutter/screens/client_inventory/client_inventory_transactions_detail_screen.dart';

import '../../screens/client/update_manual_client.dart';
import '../../screens/forgot_password/forgot_password.dart';
import '../../screens/setting/entity_list_report_screen.dart';

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
          name: RouteName.searchClientScreen,
          page: () => SearchClient(),
        ),
        GetPage(
          name: RouteName.materialUnitListScreen,
          page: () => const MaterialUnitList(),
        ),
        GetPage(
          name: RouteName.addNewClientScreen,
          page: () => const AddNewClient(),
        ),
        GetPage(
          name: RouteName.clientListScreen,
          page: () => ClientList(),
        ),
        GetPage(
          name: RouteName.materialInScreen,
          page: () => MaterialIn(),
        ),
        GetPage(name: RouteName.materialOutScreen, page: () => MaterialOut()),
        GetPage(
            name: RouteName.materialInThankyou,
            page: () => const ThankyouMaterialIn()),
        GetPage(
            name: RouteName.materialOutThankyou,
            page: () => const ThankyouMaterialOut()),
        GetPage(
            name: RouteName.inventoryClientListScreen,
            page: () => const InventoryClientListScreen()),
        GetPage(
            name: RouteName.inventoryMaterialListScreen,
            page: () => const InventoryMaterialListScreen()),
        GetPage(
          name: RouteName.inventoryUnitListScreen,
          page: () => const InventoryUnitListScreen(),
        ),
        GetPage(
          name: RouteName.inventoryTransactionsListScreen,
          page: () => const InventoryTransactionsListScreen(),
        ),
        GetPage(
          name: RouteName.inventoryTransactionsDetailsListScreen,
          page: () => const InventoryTransactionsDetailScreen(),
        ),
        GetPage(
          name: RouteName.quantityCreationMaterialoutScreen,
          page: () =>  QuantityCreationMaterialoutForm(),
        ),
        GetPage(
          name: RouteName.createAssetScreen,
          page: () =>  CreateAsset(),
        ),
        GetPage(
          name: RouteName.assetListScreen,
          page: () =>  const AssetListScreen(),
        ),
        GetPage(
          name: RouteName.assetHistoryListScreen,
          page: () =>  const AssetHistoryScreen(),
        ),
        
        GetPage(
          name: RouteName.transferMaterialScreen,
          page: () =>   TransferMaterialMapping(),
        ),
        
        GetPage(
          name: RouteName.transferIncomingMaterialScreen,
          page: () =>   TransferIncomingMaterial(),
        ),
        
        GetPage(
          name: RouteName.transferNotificationListScreen,
          page: () =>   TransferNotificationList(),
        ),
       
        GetPage(
          name: RouteName.clientDetailsScreen,
          page: () =>   const ClientDetailScreen(),
        ),
        
        GetPage(
          name: RouteName.clientInventoryMaterialListScreen,
          page: () =>   const ClientInventoryMaterialListScreen(),
        ),
        GetPage(
          name: RouteName.clientInventoryUnitListScreen,
          page: () =>   const ClientInventoryUnitListScreen(),
        ),
        GetPage(
          name: RouteName.clientInventoryTransactionsListScreen,
          page: () =>   const ClientInventoryTransactionsListScreen(),
        ),
        GetPage(
          name: RouteName.clientInventoryTransactionsDetailScreen,
          page: () =>   const ClientInventoryTransactionsDetailScreen(),
        ),

        GetPage(
          name: RouteName.thankyouMaterialInClient,
          page: () =>   const ThankyouMaterialInClient(),
        ),
        GetPage(
          name: RouteName.transactionInOut,
          page: () => const TransactionInOut(),
        ),
        GetPage(
          name: RouteName.transactionLogList,
          page: () => const TransactionLogList(),
        ),
        
        GetPage(
          name: RouteName.settingDashboard,
          page: () =>  SettingDashboard(),
        ),
        
        GetPage(
          name: RouteName.userListSetting,
          page: () =>  UserListSetting(),
        ),
        GetPage(
          name: RouteName.userCreateSetting,
          page: () =>  const UserCreateSetting(),
        ),
        GetPage(
          name: RouteName.updateWarehouse,
          page: () => UpdateWarehouse(),
        ),
        GetPage(
          name: RouteName.entityListSettingScreen,
          page: () => const EntityListSettingScreen(),
        ),
        GetPage(
          name: RouteName.entityListAssignUserSettingScreen,
          page: () => const EntityListAssignUserSettingScreen(),
        ),
        GetPage(
          name: RouteName.updateFarmhouse,
          page: () => UpdateFarmhouseGrover(),
        ),
        
        GetPage(
          name: RouteName.settingSubscription,
          page: () => const SettingSubscription(),
        ),
        
        GetPage(
          name: RouteName.accountUpdate,
          page: () => const AccountUpdate(),
        ),
        GetPage(
          name: RouteName.updateUserView,
          page: () => UpdateUserSetting(),
        ),
        GetPage(
          name: RouteName.updateMaterialScreen,
          page: () => const UpdateMaterialScreen(),
        ),
        GetPage(
          name: RouteName.updateMaterialQuantityScreen,
          page: () => UpdateMaterialQuantity(),
        ),
        GetPage(
          name: RouteName.updateMaterialIn,
          page: () => UpdateMaterialIn(),
        ),
        
        GetPage(
          name: RouteName.profileUpdateSetting,
          page: () => const ProfileUpdateSetting(),
        ),
        
        GetPage(
          name: RouteName.profileDashbordSetting,
          page: () => const ProfileDashbordSetting(),
        ),
        GetPage(
          name: RouteName.updateAssetScreen,
          page: () => UpdateAsset()
        ),
        
        GetPage(
          name: RouteName.entityListReportScreen,
          page: () => const EntityListReportScreen()
        ),
        
        GetPage(
          name: RouteName.updateManualClient,
          page: () => const UpdateManualClient()
        ),
        GetPage(
          name: RouteName.appGalleryView,
          page: () => const AppGalleryView()
        ),
        
        GetPage(
          name: RouteName.quantityCreationMaterialOutUpdateForm,
          page: () =>  QuantityCreationMaterialOutUpdateForm()
        ),
        GetPage(
          name: RouteName.profileUpdatePassword,
          page: () =>  ProfileUpdatePassword()
        ),
        GetPage(
          name: RouteName.forgotPassword,
          page: () => ForgotPassword()
        ),
        GetPage(
          name: RouteName.resetPassword,
          page: () => ResetPassword()
        ),
        GetPage(
          name: RouteName.changePasswordOnFirstLogin,
          page: () => ChangePasswordOnFirstLogin()
        ),
        GetPage(
          name: RouteName.entityListForTransferScreen,
          page: () => EntityListForTransfer()
        ),
      ];
}
