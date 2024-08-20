import '../../data/network/network_api_services.dart';
import '../../res/app_url/app_url.dart';

class FarmhouseRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> soilTypeListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.getSoilTypeApi);
    return response;
  }

  Future<dynamic> farmingTypeListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.getFarmingTypeApi);
    return response;
  }

  Future<dynamic> farmingMethodsListApi() async {
    dynamic response = await _apiService.getApi(AppUrl.getFarmingMethodApi);
    return response;
  }

  Future<dynamic> addSoilTypeApi({required var typeName}) async {
    dynamic response = await _apiService.postWithTokenApi(typeName,AppUrl.saveSoilTypeApi);
    return response;
  }

  Future<dynamic> addFarmingTypeApi({required var typeName}) async {
    dynamic response = await _apiService.postWithTokenApi(typeName,AppUrl.saveFarmingTypeApi);
    return response;
  }

  Future<dynamic> addFarmingMethodApi({required var typeName}) async {
    dynamic response = await _apiService.postWithTokenApi(typeName,AppUrl.saveFarmingMethodApi);
    return response;
  }

  Future<dynamic> managerListApi() async {
    dynamic response = await _apiService.getApi('${AppUrl.userListApi}?role_id=3');
    return response;
  }

  Future<dynamic> addFarmHouseApi(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.addFarmhouseApi);
    return response;
  }

}