import '../../data/network/network_api_services.dart';
import '../../res/app_url/app_url.dart';

class FarmhouseRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> managerListApi() async {
    dynamic response = await _apiService.getApi('${AppUrl.userListApi}?role_id=3');
    return response;
  }

  Future<dynamic> addFarmHouseApi(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.addFarmhouseApi);
    return response;
  }

}