class AppUrl {
  static const String baseUrl = 'https://dev.appcoldstorage.com';
  static const String loginApi = '$baseUrl/api/login';
  static const String signupApi = '$baseUrl/api/signup';
  static const String changePasswordOnFirstLoginApi = '$baseUrl/api/change-password';
  static const String timeZoneApi = '$baseUrl/api/time-zones';
  static const String getAccountDetailsApi = '$baseUrl/api/get-account-detail';
  static const String unitsApi = '$baseUrl/api/units-master';
  static const String accountSubmitApi = '$baseUrl/api/accounts';
  static const String submitPaymentApi = '$baseUrl/api/confirm-payment';
  static const String updateSubscriptionUnit = '$baseUrl/api/update-subscription-unit';
  static const String userRoleListApi = '$baseUrl/api/roles-list';
  static const String addUserApi = '$baseUrl/api/add-user';
  static const String updateUserApi = '$baseUrl/api/update-user';
  static const String userListApi = '$baseUrl/api/user-list';
  static const String storageTypeListApi = '$baseUrl/api/storage-types';

  static const String addColdStorageApi = '$baseUrl/api/cold-storage';
  static const String addFarmhouseApi = '$baseUrl/api/add-farm';
  static const String getSoilTypeApi = '$baseUrl/api/get-soil-types';
  static const String saveSoilTypeApi = '$baseUrl/api/save-soil-types';
  static const String getFarmingTypeApi = '$baseUrl/api/get-farming-types';
  static const String saveFarmingTypeApi = '$baseUrl/api/save-farming-types';
  static const String getFarmingMethodApi = '$baseUrl/api/get-farming-methods';
  static const String saveFarmingMethodApi = '$baseUrl/api/save-farming-methods';


  static const String entityListApi = '$baseUrl/api/entity-list';
  static const String entityListTransferRequest = '$baseUrl/api/entity-list-transfer-request';
  static const String sendOtpApi = '$baseUrl/api/signup-send-otp';
  static const String materialListApi = '$baseUrl/api/materials';
  static const String materialCategoriesListApi = '$baseUrl/api/categories';
  static const String materialAddApi = '$baseUrl/api/add-material';
  static const String categoryAddApi = '$baseUrl/api/category';
  static const String unitTypeListApi = '$baseUrl/api/measurement-units-type';
  static const String unitMouListApi = '$baseUrl/api/measurement-units-mou';
  static const String addMaterialApi = '$baseUrl/api/add-material';
  static const String updateMaterialApi = '$baseUrl/api/material';
  static const String materialUnitListApi = '$baseUrl/api/get-material-units';
  static const String materialDeleteApi = '$baseUrl/api/material';
  static const String createClientApi = '$baseUrl/api/client';
  static const String createListApi = '$baseUrl/api/clients-list-with-request-status';
  static const String searchClientListApi = '$baseUrl/api/clients-search-list?name=';
  static const String sendRequestClientApi = '$baseUrl/api/accounts-relations';
  static const String clientDetailsApi = '$baseUrl/api/clients-details/';
  static const String clientDetailsManualApi = '$baseUrl/api/manual-client-details/';
  static const String clientRequestDeclinedApi = '$baseUrl/api/account-request-declined';
  static const String clientRequestAcceptApi = '$baseUrl/api/account-request-accept-reject';
  static const String updateManualclient = '$baseUrl/api/clients/';
  static const String updateRelationclient = '$baseUrl/api/update-account-user-type/';

  static const String clientInventoryMaterialList = '$baseUrl/api/material-list-with-count-without-entity/?account_id=';
  static const String clientInventoryUnitList = '$baseUrl/api/units-list-from-material-id-without-entity/';
  static const String clientInventoryTransactionsList = '$baseUrl/api/transactions-list-from-unit-id-without-entity?';
  static const String clientInventoryTransactionsDetails = '$baseUrl/api/transactions-detail-list-without-entity/';
  static const String materialTransferDetails = '$baseUrl/api/external-transfer-detail/';
  static const String autoMappingData = '$baseUrl/api/auto-store-data';
  static const String requestReject = '$baseUrl/api/material-external-transfer-reject';
  static const String materialInternalTransferStatus = '$baseUrl/api/material-internal-transfer-status';




  static const String materialInCategory = '$baseUrl/api/categories';
  static const String internalTransferNotificationsDetail = '$baseUrl/api/internal-transfer-notifications-detail/';
  static const String materialInMaterial = '$baseUrl/api/get-material-list-by-category';
  static const String materialInUnit = '$baseUrl/api/get-units-list-by-material';
  static const String materialInBin = '$baseUrl/api/get-bin-list-by-entity';
  static const String materialInClient = '$baseUrl/api/list-clients-customer';
  static const String materialInListClient = '$baseUrl/api/list-clients-for-materialIn';
  static const String listClientsForMaterialMapping = '$baseUrl/api/list-clients-for-materialMapping';

  static const String materialOutClientSupplier = '$baseUrl/api/list-clients-supplier';
  static const String materialOutClientCustomer = '$baseUrl/api/list-clients-customer';
  static const String materialOutClientCustomerEntityList = '$baseUrl/api/entity-list-for-customer/';
  static const String materialInternalTransfer = '$baseUrl/api/material-internal-transfer';


  static const String inventoryClientList = '$baseUrl/api/inventory-list?';
  static const String inventoryMaterialList = '$baseUrl/api/material-list-with-count';
  static const String inventoryUnitsList = '$baseUrl/api/units-list-from-material-id/';
  static const String inventoryTransactionsListFromMaterialId = '$baseUrl/api/transactions-list-from-material-id';
  static const String inventoryTransactionsList = '$baseUrl/api/transactions-list-from-unit-id?';
  static const String inventoryTransactionsDetailList = '$baseUrl/api/transactions-detail-list/';

   static const String materialOutCategory = '$baseUrl/api/categories-list-based-on-supplier-client-id';
   static const String getMaterialOutCategory = '$baseUrl/api/get-categories-list-at-material-out';
   static const String materialOutMaterial = '$baseUrl/api/get-material-list-at-material-out';
   static const String getMaterialOutMaterial = '$baseUrl/api/get-material-list-at-material-out';
   static const String materialOutUnit = '$baseUrl/api/get-units-list-at-material-out';
   static const String getMaterialOutUnit = '$baseUrl/api/get-units-list-at-material-out';
   static const String materialOutBin = '$baseUrl/api/get-bin-list-by-entity-at-material-out';
   static const String materialOutGetQuantity = '$baseUrl/api/get-available-quantity';

   static const String materialAdjustQuantity = '$baseUrl/api/material-adjust-by-id';
   static const String materialReturnQuantity = '$baseUrl/api/material-return-by-id';


    static const String transactionLogList = '$baseUrl/api/transactions?';
    static const String transactionsDetail = '$baseUrl/api/transactions-detail/';



   static const String materialTransferIncomingRequest = '$baseUrl/api/all-sent-upcoming-requests-list/';
   static const String internalTransferNotificationsList = '$baseUrl/api/internal-transfer-notifications-list';








   static const String assetCategoriesList = '$baseUrl/api/asset-categories';
   static const String assetCategoriesAdd = '$baseUrl/api/asset-category';
   static const String assetLocationList = '$baseUrl/api/entity-list';
   static const String assetAdd = '$baseUrl/api/add-asset';
   static const String assetDetails = '$baseUrl/api/asset';
   static const String assetList = '$baseUrl/api/asset-assign';
   static const String assetCategoryAdd = '$baseUrl/api/asset-category';
   static const String assetUserList = '$baseUrl/api/get-users-list-for-entity';
   static const String assetAddAssign = '$baseUrl/api/asset-assign';
   static const String assetHistory = '$baseUrl/api/asset-assign-history/?';
   static const String assetDeleteAssign = '$baseUrl/api/asset-assign/';


   //delete

     static const String deleteUser = '$baseUrl/api/user/';
     static const String deleteEntity = '$baseUrl/api/delete-entity';
     static const String deleteUnit = '$baseUrl/api/delete-material-unit/';



     
     static const String entityReportingCycleRelationList = '$baseUrl/api/entity-reporting-cycle-relation-list';
     static const String listEntityUserRelations = '$baseUrl/api/list-entity-user-relations/';
     static const String addEntityUserRelation = '$baseUrl/api/add-entity-user-relation';
     static const String getAccountSubsecriptionDetails = '$baseUrl/api/get-account-subsecription-details';
     static const String getAccountDetail = '$baseUrl/api/get-account-detail';
     static const String updateProfile = '$baseUrl/api/update-profile';
     static const String forgotPassword = '$baseUrl/api/forget-password';
     static const String resetPassword = '$baseUrl/api/reset-password';
     static const String updatePassword = '$baseUrl/api/update-password';

  ///Global Notification List
     static const String notificationList = '$baseUrl/api/notifications-list';

  





}
