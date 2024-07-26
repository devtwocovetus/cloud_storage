import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class MaterialInRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> getCategorie() async {
    dynamic response = await _apiService.getApi(AppUrl.materialInCategory);
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
    dynamic response = await _apiService.getApi(AppUrl.materialInClient);
    return response;
  }

 }
