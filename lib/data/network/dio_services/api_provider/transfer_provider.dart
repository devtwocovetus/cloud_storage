import 'package:cold_storage_flutter/data/network/dio_services/constant/app_url_dio.dart';
import 'package:cold_storage_flutter/data/network/dio_services/dio_api_services.dart';
import 'package:dio/dio.dart';

class TransferProvider{
  Dio client;
  TransferProvider({required this.client});

  final _apiServices = DioApiServices();


  Future<dynamic> tranferAccept({var data}) async {
    dynamic response = await _apiServices.postApi(client,data,AppUrlDio.transferAcceptReject);
    return response;
  }
  
  Future<dynamic> tranferAcceptInternal({var data}) async {
    dynamic response = await _apiServices.postApi(client,data,AppUrlDio.materialInternalTransferStatus);
    return response;
  }

}