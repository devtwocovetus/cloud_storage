class AppUrlDio {
  static const String baseUrl = 'https://uat.appcoldstorage.com';
  // static const String baseUrl = 'http://143.198.101.180';
  // static const String baseUrl = 'https://dev.appcoldstorage.com';
  static const String loginApi = '/api/login';
  static const String signupApi = '/api/signup';
  static const String timeZoneApi = '/api/time-zones';
  static const String unitsApi = '/api/units-master';
  static const String accountSubmitApi = '/api/accounts';
  static const String submitPaymentApi = '/api/confirm-payment';
  static const String userRoleListApi = '/api/roles-list';
  static const String addUserApi = '/api/add-user';
  static const String userListApi = '/api/user-list';
  static const String updateUserApi = '/api/update-user';
  static const String storageTypeListApi = '/api/storage-types';

  ///cold storage & farm house
  static const String addColdStorageApi = '/api/cold-storage';
  static const String addFarmhouseApi = '/api/add-farm';
  static const String updateFarmhouseApi = '/api//update-farm';
  static const String updateWarehouseApi = '/api//cold-storage';
  static const String transferAcceptReject = '/api/material-external-transfer-accept-reject';
  static const String materialInternalTransferStatus = '/api/material-internal-transfer-status';


  static const String entityListApi = '/api/entity-list';
  static const String sendOtpApi = '/api/signup-send-otp';

  ///Add Material
  static const String qualityTypeApi = '/api/measurement-quantity-type-master';
  static const String addMaterialUnitApi = '/api/add-material-unit';
  static const String updateMaterialUnitApi = '/api/update-material-unit';
  static const String addMaterialInApi = '/api/material-in';
  static const String addMaterialOutApi = '/api/material-out';
  static const String addEntityReportingCycleRelation = '/api/add-entity-reporting-cycle-relation';
  static const String addEntityUserRelation = '/api/add-entity-user-relation';

  ///Asset
  static const String updateAsset = '/api/asset';

  ///Inventory Material Update Screen
  static const String transactionMasterDetailsWithMaterialUpdate = '/api/transaction-master-details-with-material-update';


  ///Material transfer
  static const String materialInternalTransfer = '/api/material-internal-transfer';



}