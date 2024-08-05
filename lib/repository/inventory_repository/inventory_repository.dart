import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class InventoryRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> inventoryClientListApi(String entityId,String entityType) async {
    dynamic response = await _apiService.getApi('${AppUrl.inventoryClientList}entity_id=$entityId&entity_type=$entityType');
    return response;
  }

  Future<dynamic> inventoryMaterialListApi(String clientId,String entityId,String entityType) async {
    dynamic response = await _apiService.getApi('${AppUrl.inventoryMaterialList}$clientId?entity_id=$entityId&entity_type=$entityType');
    return response;
  }
  
  Future<dynamic> inventoryUnitsListApi(String materialId,String entityId,String entityType) async {
    dynamic response = await _apiService.getApi('${AppUrl.inventoryUnitsList}$materialId?entity_id=$entityId&entity_type=$entityType');
    return response;
  }
  
  
  Future<dynamic> inventoryTransactionsDetailListApi(String transactionsId,String entityId,String entityType) async {
    dynamic response = await _apiService.getApi('${AppUrl.inventoryTransactionsDetailList}$transactionsId?entity_id=$entityId&entity_type=$entityType');
    return response;
  }
  
  
  Future<dynamic> inventoryTransactionsListApi(String unitId,String catId,String materialId,String entityId,String entityType) async {
    dynamic response = await _apiService.getApi('${AppUrl.inventoryTransactionsList}unit_id=$unitId&category_id=$catId&material_id=$materialId&entity_id=$entityId&entity_type=$entityType');
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
