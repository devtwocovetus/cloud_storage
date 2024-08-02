import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class InventoryRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> inventoryClientListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.inventoryClientList);
    return response;
  }

  Future<dynamic> inventoryMaterialListApi(String clientId) async {
    dynamic response = await _apiService.getApi('${AppUrl.inventoryMaterialList}$clientId');
    return response;
  }
  
  Future<dynamic> inventoryUnitsListApi(String materialId) async {
    dynamic response = await _apiService.getApi('${AppUrl.inventoryUnitsList}$materialId');
    return response;
  }
  
  
  Future<dynamic> inventoryTransactionsDetailListApi(String transactionsId) async {
    dynamic response = await _apiService.getApi('${AppUrl.inventoryTransactionsDetailList}$transactionsId');
    return response;
  }
  
  
  Future<dynamic> inventoryTransactionsListApi(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.inventoryTransactionsList);
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
