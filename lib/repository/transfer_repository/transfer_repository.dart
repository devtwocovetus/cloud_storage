import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class TransferRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> getTranferIncomingRequest(String clientId) async {
    dynamic response = await _apiService.getApi('${AppUrl.materialTransferIncomingRequest}$clientId');
    return response;
  }
  
  
  Future<dynamic> internalTransferNotificationsList(String entityId,String entityType) async {
    dynamic response = await _apiService.getApi('${AppUrl.internalTransferNotificationsList}?entity_id=$entityId&entity_type=$entityType');
    return response;
  }

  Future<dynamic> getTranferIncomingDetail(String transferId) async {
    dynamic response = await _apiService.getApi('${AppUrl.materialTransferDetails}$transferId');
    return response;
  }

  Future<dynamic> entityListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.entityListApi);
    return response;
  }


Future<dynamic> getCategorie() async {
    dynamic response = await _apiService.getApi(AppUrl.materialInCategory);
    return response;
  }

Future<dynamic> getTransferDetails(String notificationId) async {
    dynamic response = await _apiService.getApi('${AppUrl.internalTransferNotificationsDetail}$notificationId');
    return response;
  }
  
  
  
  Future<dynamic> getMaterial(String categoryId) async {
    dynamic response = await _apiService.getApi('${AppUrl.materialInMaterial}/$categoryId');
    return response;
  }
  
  
  Future<dynamic> getUnit(String materialId) async {
    dynamic response = await _apiService.getApi('${AppUrl.materialInUnit}/$materialId');
    return response;
  }

  
  Future<dynamic> getBin(String entityId) async {
    dynamic response = await _apiService.getApi('${AppUrl.materialInBin}/$entityId');
    return response;
  }

  Future<dynamic> getClient() async {
    dynamic response = await _apiService.getApi(AppUrl.materialInListClient);
    return response;
  }
  
  Future<dynamic> getClientList() async {
    dynamic response = await _apiService.getApi(AppUrl.listClientsForMaterialMapping);
    return response;
  }

  Future<dynamic> rejectRequest(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.requestReject);
    return response;
  }
  
  
  Future<dynamic> materialInternalTransferStatus(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.materialInternalTransferStatus);
    return response;
  }
  
  Future<dynamic> autoMappingData(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.autoMappingData);
    return response;
  }
}
