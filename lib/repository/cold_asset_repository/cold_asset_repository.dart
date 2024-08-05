import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class ColdAssetRepository {
  final _apiService = NetworkApiServices();

  // Future<dynamic> timeZonesApi() async {
  //   dynamic response = await _apiService.getApi(AppUrl.timeZoneApi);
  //   return response;
  // }

  Future<dynamic> postCategoryAdd(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.assetCategoriesAdd);
    return response;
  }

  Future<dynamic> getCategories() async {
    dynamic response = await _apiService.getApi(AppUrl.assetCategoriesList);
    return response;
  }

  Future<dynamic> getLocation() async {
    dynamic response = await _apiService.getApi(AppUrl.assetLocationList);
    return response;
  }

  Future<dynamic> getAssetList() async {
    dynamic response = await _apiService.getApi(AppUrl.assetList);
    return response;
  }
  
  Future<dynamic> deletAssign(String assignId) async {
    dynamic response = await _apiService.deleteApi('${AppUrl.assetDeleteAssign}$assignId');
    return response;
  }

  Future<dynamic> getUserList() async {
    dynamic response = await _apiService.getApi(AppUrl.assetUserList);
    return response;
  }

  Future<dynamic> postAddAsset(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.assetAdd);
    return response;
  }

  Future<dynamic> postAddCategory(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.assetCategoryAdd);
    return response;
  }
  
  Future<dynamic> postAddAssign(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.assetAddAssign);
    return response;
  }

Future<dynamic> getAssetHistory(String assetId,String startDate,String endDate) async {
    dynamic response = await _apiService.getApi('${AppUrl.assetHistory}asset_id=$assetId&start_date=$startDate&end_date=$endDate');
    return response;
  }

}
