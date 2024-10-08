import 'package:cold_storage_flutter/data/network/network_api_services.dart';
import 'package:cold_storage_flutter/res/app_url/app_url.dart';

class StripeRepository {
  final _apiService = NetworkApiServices();

   Future<dynamic> getUserData() async {
    dynamic response = await _apiService.getApi(AppUrl.getAccountDetailsApi);
    return response;
  }

  Future<dynamic> submitPaymentApi(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.submitPaymentApi);
    return response;
  }

  Future<dynamic> updatePaymentApi(var data) async {
    dynamic response = await _apiService.postWithTokenApi(data,AppUrl.updateSubscriptionUnit);
    return response;
  }

  Future<dynamic> getSubscriptionDetail() async {
    dynamic response = await _apiService.getApi(AppUrl.getAccountSubsecriptionDetails);
    return response;
  }
}
