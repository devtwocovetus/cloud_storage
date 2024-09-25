import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class EntityRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> entityListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.entityListApi);
    return response;
  }
  
  Future<dynamic> entityListForTransferApi(String entityId,String entityType) async {
    dynamic response = await _apiService.getApi('${AppUrl.entityListTransferRequest}?entity_type=$entityType&entity_id=$entityId');
    return response;
  }

  Future<dynamic> entityDelete(String entityId, String entityType) async {
    dynamic response = await _apiService.deleteApi('${AppUrl.deleteEntity}/$entityId/$entityType');
    return response;
  }

  Future<dynamic> entityReportingCycleList() async {
    dynamic response = await _apiService.getApi(AppUrl.entityReportingCycleRelationList);
    return response;
  }


  Future<dynamic> entityAssigndList(String userId) async {
    dynamic response = await _apiService.getApi('${AppUrl.listEntityUserRelations}$userId');
    return response;
  }
  
  
  Future<dynamic> userAssignd(var data) async {
    dynamic response = await _apiService.postApi(data,AppUrl.addEntityUserRelation);
    return response;
  }


 }
