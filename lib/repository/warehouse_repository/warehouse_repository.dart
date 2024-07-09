import '../../data/network/network_api_services.dart';
import '../../res/app_url/app_url.dart';

class WarehouseRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> managerListApi() async {
    dynamic response = await _apiService.getApi('${AppUrl.userListApi}?role_id=3');
    return response;
  }

  Future<dynamic> storageTypeListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.storageTypeListApi);
    return response;
  }

  Future<dynamic> addColdStorageApi(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.addColdStorageApi);
    return response;
  }

}