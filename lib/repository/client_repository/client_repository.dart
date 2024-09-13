import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class ClientRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> timeZonesApi() async {
    dynamic response = await _apiService.getApi(AppUrl.timeZoneApi);
    return response;
  }

  Future<dynamic> getClient() async {
    dynamic response = await _apiService.getApi(AppUrl.createListApi);
    return response;
  }

  Future<dynamic> searchClient(String clientName) async {
    dynamic response =
        await _apiService.getApi('${AppUrl.searchClientListApi}$clientName');
    return response;
  }

  Future<dynamic> getClientDetails(String clientId) async {
    dynamic response = await _apiService.getApi('${AppUrl.clientDetailsApi}$clientId');
    return response;
  }
  
  
  Future<dynamic> updateManualClient(var data,String clientId) async {
    dynamic response = await _apiService.putApi(data,'${AppUrl.updateManualclient}$clientId');
    return response;
  }
  
  
  Future<dynamic> getClientDetailsManual(String clientId) async {
    dynamic response = await _apiService.getApi('${AppUrl.clientDetailsManualApi}$clientId');
    return response;
  }

  Future<dynamic> createClientApi(var data) async {
    dynamic response =
        await _apiService.postWithTokenApi(data, AppUrl.createClientApi);
    return response;
  }

  Future<dynamic> sendRequestClientApi(var data) async {
    dynamic response =
        await _apiService.postWithTokenApi(data, AppUrl.sendRequestClientApi);
    return response;
  }

  Future<dynamic> requestDeclinedClientApi(var data) async {
    dynamic response = await _apiService.postWithTokenApi(
        data, AppUrl.clientRequestDeclinedApi);
    return response;
  }
  
  
  Future<dynamic> updateRelationClient(var data,String clientId) async {
    dynamic response = await _apiService.postWithTokenApi(
        data, '${AppUrl.updateRelationclient}$clientId');
    return response;
  }

  Future<dynamic> requestAcceptClientApi(var data) async {
    dynamic response =
        await _apiService.postWithTokenApi(data, AppUrl.clientRequestAcceptApi);
    return response;
  }

  Future<dynamic> getClientInventoryMaterial(String accountId) async {
    dynamic response = await _apiService
        .getApi('${AppUrl.clientInventoryMaterialList}$accountId');
    return response;
  }

  Future<dynamic> getClientInventoryUnit(
      String accountId, String materialId) async {
    dynamic response = await _apiService.getApi(
        '${AppUrl.clientInventoryUnitList}$materialId?account_id=$accountId');
    return response;
  }

  Future<dynamic> getClientInventoryTransactions(String accountId,
      String categoryId, String materialId, String unitId) async {
    dynamic response = await _apiService.getApi(
        '${AppUrl.clientInventoryTransactionsList}account_id=$accountId&category_id=$categoryId&material_id=$materialId&unit_id=$unitId');
    return response;
  }

  Future<dynamic> getClientInventoryTransactionsDtails(
      String transactionsId, String accountId) async {
    dynamic response = await _apiService.getApi(
        '${AppUrl.clientInventoryTransactionsDetails}$transactionsId?account_id=$accountId');
    return response;
  }

  Future<dynamic> transactionsAdjust(var data) async {
    dynamic response =
        await _apiService.postWithTokenApi(data, AppUrl.materialAdjustQuantity);
    return response;
  }

  Future<dynamic> transactionsReturn(var data) async {
    dynamic response =
        await _apiService.postWithTokenApi(data, AppUrl.materialReturnQuantity);
    return response;
  }
}
