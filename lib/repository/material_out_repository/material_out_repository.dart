import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class MaterialOutRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> getCategorie(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.materialOutCategory);
    return response;
  }
  
  
  
  Future<dynamic> getMaterial(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.materialOutMaterial);
    return response;
  }
  
  
  Future<dynamic> getUnit(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.materialOutUnit);
    return response;
  }

  
  Future<dynamic> getBin(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.materialOutBin);
    return response;
  }

  Future<dynamic> getQuantity(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.materialOutGetQuantity);
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
