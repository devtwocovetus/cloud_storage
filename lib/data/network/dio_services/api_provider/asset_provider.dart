import 'package:cold_storage_flutter/data/network/dio_services/constant/app_url_dio.dart';
import 'package:cold_storage_flutter/data/network/dio_services/dio_api_services.dart';
import 'package:dio/dio.dart';

class AssetProvider{
  Dio client;
  AssetProvider({required this.client});

  final _apiServices = DioApiServices();

  Future<dynamic> updateAssetApi({var data,required int id}) async {
    dynamic response = await _apiServices.putApi(client,data,'${AppUrlDio.updateAsset}/$id');
    return response;
  }

}