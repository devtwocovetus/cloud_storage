import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class TransactionLogRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> transactionClientListApi(String entityId,String entityType) async {
    dynamic response = await _apiService.getApi('${AppUrl.transactionLogList}entity_id=$entityId&entity_type=$entityType');
    return response;
  }

  Future<dynamic> transactionsDetail(String transactionsId) async {
    dynamic response = await _apiService.getApi('${AppUrl.transactionsDetail}$transactionsId');
    return response;
  }
  
  Future<dynamic> inventoryUnitsListApi(String materialId,String entityId,String entityType,String clientId) async {
    dynamic response = await _apiService.getApi('${AppUrl.inventoryUnitsList}$materialId?entity_id=$entityId&entity_type=$entityType&client_id=$clientId');
    return response;
  }
  
  
  Future<dynamic> inventoryTransactionsDetailListApi(String transactionsId,String entityId,String entityType) async {
    dynamic response = await _apiService.getApi('${AppUrl.inventoryTransactionsDetailList}$transactionsId?entity_id=$entityId&entity_type=$entityType');
    return response;
  }
  
  
  Future<dynamic> inventoryTransactionsListApi(String unitId,String catId,String materialId,String entityId,String entityType, String clientId) async {
    dynamic response = await _apiService.getApi('${AppUrl.inventoryTransactionsList}unit_id=$unitId&category_id=$catId&material_id=$materialId&entity_id=$entityId&entity_type=$entityType&client_id=$clientId');
    return response;
  }

  Future<dynamic> transactionsAdjust(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.materialAdjustQuantity);
    return response;
  }

  Future<dynamic> transactionsReturn(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.materialReturnQuantity);
    return response;
  }
  
  
 }
