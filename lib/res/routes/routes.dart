import 'package:cold_storage_flutter/models/client/client_inventory_material_list.dart';
import 'package:cold_storage_flutter/models/inventory/inventory_client_list_model.dart';
import 'package:cold_storage_flutter/models/inventory/inventory_material_list_model.dart';
import 'package:cold_storage_flutter/res/routes/routes_name.dart';
import 'package:cold_storage_flutter/screens/account_create.dart';
import 'package:cold_storage_flutter/screens/category/category_add.dart';
import 'package:cold_storage_flutter/screens/client/add_new_client.dart';
import 'package:cold_storage_flutter/screens/client/client_detail_screen.dart';
import 'package:cold_storage_flutter/screens/client/client_list.dart';
import 'package:cold_storage_flutter/screens/client/search_client.dart';
import 'package:cold_storage_flutter/screens/client_inventory/client_inventory_material_list_screen.dart';
import 'package:cold_storage_flutter/screens/client_inventory/client_inventory_transactions_detail_screen.dart';
import 'package:cold_storage_flutter/screens/client_inventory/client_inventory_transactions_list_screen.dart';
import 'package:cold_storage_flutter/screens/client_inventory/client_inventory_unit_list_screen.dart';
import 'package:cold_storage_flutter/screens/cold_asset/asset_history_screen.dart';
import 'package:cold_storage_flutter/screens/cold_asset/asset_list_screen.dart';
import 'package:cold_storage_flutter/screens/cold_asset/create_asset.dart';
import 'package:cold_storage_flutter/screens/cold_storage_warehouse/create_warehouse.dart';
import 'package:cold_storage_flutter/screens/cold_storage_warehouse/update_warehouse.dart';
import 'package:cold_storage_flutter/screens/entity/entity_list_demo.dart';
import 'package:cold_storage_flutter/screens/entity/entity_list_screen.dart';
import 'package:cold_storage_flutter/screens/entity/entity_onboarding.dart';
import 'package:cold_storage_flutter/screens/entity/new_entity_list_screen.dart';

import 'package:cold_storage_flutter/screens/farmhouse_grover/create_farmhouse_grover.dart';

import 'package:cold_storage_flutter/screens/home_screen.dart';
import 'package:cold_storage_flutter/screens/inventory/inventory_client_list_screen.dart';
import 'package:cold_storage_flutter/screens/inventory/inventory_material_list_screen.dart';
import 'package:cold_storage_flutter/screens/inventory/inventory_transactions_detail_screen.dart';
import 'package:cold_storage_flutter/screens/inventory/inventory_transactions_list_screen.dart';
import 'package:cold_storage_flutter/screens/inventory/inventory_unit_list_screen.dart';
import 'package:cold_storage_flutter/screens/material/material_create.dart';
import 'package:cold_storage_flutter/screens/material/material_in/material_in.dart';
import 'package:cold_storage_flutter/screens/material/material_in/thankyou_material_in.dart';
import 'package:cold_storage_flutter/screens/material/material_list_screen.dart';
import 'package:cold_storage_flutter/screens/material/material_out/material_out.dart';
import 'package:cold_storage_flutter/screens/material/material_out/quantity_creation_materialout_form.dart';
import 'package:cold_storage_flutter/screens/material/material_out/thankyou_material_out.dart';
import 'package:cold_storage_flutter/screens/material/material_unit_list.dart';
import 'package:cold_storage_flutter/screens/material/transfer/thankyou_material_in_client.dart';
import 'package:cold_storage_flutter/screens/material/transfer/transfer_incoming_material.dart';
import 'package:cold_storage_flutter/screens/material/transfer/transfer_material_mapping.dart';
import 'package:cold_storage_flutter/screens/notification/transfer_notification_list.dart';

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
import '../../screens/transaction/transaction_in_out.dart';

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
          name: RouteName.updateWarehouse,
          page: () => UpdateWarehouse(),
        ),
      ];
}
