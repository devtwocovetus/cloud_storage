import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class MaterialOutRepository {
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

  Future<dynamic> getClientSupplier(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.materialOutClientSupplier);
    return response;
  }

  Future<dynamic> getClientCustomer() async {
    dynamic response = await _apiService.getApi(AppUrl.materialOutClientCustomer);
    return response;
  }

  Future<dynamic> getEntityList(String customerId) async {
    dynamic response = await _apiService.getApi('${AppUrl.materialOutClientCustomerEntityList}$customerId');
    return response;
  }

 }
