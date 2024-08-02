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
}
