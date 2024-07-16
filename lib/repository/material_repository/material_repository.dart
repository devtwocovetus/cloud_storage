import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class MaterialRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> materialListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.materialListApi);
    return response;
  }

  Future<dynamic> materialCategorieListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.materialCategoriesListApi);
    return response;
  }

  
  Future<dynamic> materialUnitListApi(String url) async {
    dynamic response = await _apiService.getApi('${AppUrl.materialUnitListApi}$url');
    return response;
  }

  Future<dynamic> unitTypeListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.unitTypeListApi);
    return response;
  }

  Future<dynamic> unitMouListApi(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.unitMouListApi);
    return response;
  }

  Future<dynamic> createMaterialApi(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.addMaterialApi);
    return response;
  }


  Future<dynamic> deleteMaterialApi(String id) async {
    dynamic response = await _apiService.deleteApi('${AppUrl.materialDeleteApi}/$id');
    return response;
  }


 }
