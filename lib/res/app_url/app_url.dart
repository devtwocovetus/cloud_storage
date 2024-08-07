class AppUrl {
  static const String baseUrl = 'http://143.198.101.180/dev.appcoldstorage.com';
  static const String loginApi = '$baseUrl/api/login';
  static const String signupApi = '$baseUrl/api/signup';
  static const String timeZoneApi = '$baseUrl/api/time-zones';
  static const String unitsApi = '$baseUrl/api/units-master';
  static const String accountSubmitApi = '$baseUrl/api/accounts';
  static const String submitPaymentApi = '$baseUrl/api/confirm-payment';
  static const String userRoleListApi = '$baseUrl/api/roles-list';
  static const String addUserApi = '$baseUrl/api/add-user';
  static const String userListApi = '$baseUrl/api/user-list';
  static const String storageTypeListApi = '$baseUrl/api/storage-types';

  static const String addColdStorageApi = '$baseUrl/api/cold-storage';
  static const String addFarmhouseApi = '$baseUrl/api/add-farm';


  static const String entityListApi = '$baseUrl/api/entity-list';
  static const String sendOtpApi = '$baseUrl/api/signup-send-otp';
  static const String materialListApi = '$baseUrl/api/materials';
  static const String materialCategoriesListApi = '$baseUrl/api/categories';
  static const String materialAddApi = '$baseUrl/api/add-material';
  static const String categoryAddApi = '$baseUrl/api/category';
  static const String unitTypeListApi = '$baseUrl/api/measurement-units-type';
  static const String unitMouListApi = '$baseUrl/api/measurement-units-mou';
  static const String addMaterialApi = '$baseUrl/api/add-material';
  static const String materialUnitListApi = '$baseUrl/api/get-material-units';
  static const String materialDeleteApi = '$baseUrl/api/material';
  static const String createClientApi = '$baseUrl/api/client';
  static const String createListApi = '$baseUrl/api/clients-list-with-request-status';




  static const String materialInCategory = '$baseUrl/api/categories';
  static const String materialInMaterial = '$baseUrl/api/get-material-list-by-category';
  static const String materialInUnit = '$baseUrl/api/get-units-list-by-material';
  static const String materialInBin = '$baseUrl/api/get-bin-list-by-entity';
  static const String materialInClient = '$baseUrl/api/list-clients-customer';

  static const String materialOutClientSupplier = '$baseUrl/api/list-clients-supplier';
  static const String materialOutClientCustomer = '$baseUrl/api/list-clients-customer';
  static const String materialOutClientCustomerEntityList = '$baseUrl/api/entity-list-for-customer/';


  static const String inventoryClientList = '$baseUrl/api/inventory-list?';
  static const String inventoryMaterialList = '$baseUrl/api/material-list-with-count/';
  static const String inventoryUnitsList = '$baseUrl/api/units-list-from-material-id/';
  static const String inventoryTransactionsList = '$baseUrl/api/transactions-list-from-unit-id?';
  static const String inventoryTransactionsDetailList = '$baseUrl/api/transactions-detail-list/';

   static const String materialOutCategory = '$baseUrl/api/categories-list-based-on-supplier-client-id';
   static const String materialOutMaterial = '$baseUrl/api/get-material-list-at-material-out';
   static const String materialOutUnit = '$baseUrl/api/get-units-list-at-material-out';
   static const String materialOutBin = '$baseUrl/api/get-bin-list-by-entity-at-material-out';
   static const String materialOutGetQuantity = '$baseUrl/api/get-available-quantity';

   static const String materialAdjustQuantity = '$baseUrl/api/material-adjust-by-id';
   static const String materialReturnQuantity = '$baseUrl/api/material-return-by-id';







   static const String assetCategoriesList = '$baseUrl/api/asset-categories';
   static const String assetCategoriesAdd = '$baseUrl/api/asset-category';
   static const String assetLocationList = '$baseUrl/api/entity-list';
   static const String assetAdd = '$baseUrl/api/add-asset';
   static const String assetList = '$baseUrl/api/asset-assign';
   static const String assetCategoryAdd = '$baseUrl/api/asset-category';
   static const String assetUserList = '$baseUrl/api/get-users-list-for-entity';
   static const String assetAddAssign = '$baseUrl/api/asset-assign';
   static const String assetHistory = '$baseUrl/api/asset-assign-history/?';
   static const String assetDeleteAssign = '$baseUrl/api/asset-assign/';



  





}
