
import 'package:dio/dio.dart';

abstract class BaseApiServices {

  Future<dynamic> getApi(String url);

  Future<dynamic> postWithTokenApi(dynamic data, String url);

  Future<dynamic> putApi(dynamic data, String url);

  Future<dynamic> postApi(dynamic data, String url);

  Future<dynamic> deleteApi(String url);

}

abstract class BaseApiServices2 {

  Future<dynamic> getApi(Dio client,String url) ;

  Future<dynamic> postApi(Dio client,dynamic data, String url) ;

  Future<dynamic> putApi(Dio client,dynamic data, String url) ;
}