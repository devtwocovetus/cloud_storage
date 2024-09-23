import 'package:cold_storage_flutter/models/login/login_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/profile/update_profile_model.dart';

class UserPreference {

  static RxString profileLogo = ''.obs;
  static RxString profileUserName = ''.obs;
  static RxString profileUserEmail = ''.obs;
  static RxString userFirstName = ''.obs;
  static RxString userLastName = ''.obs;
  static RxString userPhoneNumber = ''.obs;

    Future<bool> saveUser(LoginModel responseModel,String roleMap)async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('token', responseModel.data?.token.toString() ?? '');
      sp.setInt('id', responseModel.data?.id ?? 0);
      sp.setString('name', responseModel.data?.fullName ?? '');
      sp.setString('first_name', responseModel.data?.firstName ?? '');
      sp.setString('last_name', responseModel.data?.lastName ?? '');
      sp.setString('phone_number', responseModel.data?.contactNumber ?? '');
      sp.setString('email', responseModel.data?.email ?? '');
      sp.setString('logo_url', responseModel.data?.profileImage ?? '');
      sp.setInt('role', responseModel.data?.role ?? 0);
      sp.setInt('first_time_login', responseModel.data?.firstTimeLogin ?? 0);
      sp.setInt('current_account_status', responseModel.data?.currentAccountStatus ?? 0);
      sp.setString('roleMap', roleMap);
      sp.setBool('isLogin', true);
      await saveLocalInfo(responseModel);
      return true ;
    }

  Future<bool> saveUserOnProfileUpdate(UpdateProfileModel responseModel)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('name', responseModel.data?.name ?? '');
    sp.setString('first_name', responseModel.data?.firstName ?? '');
    sp.setString('last_name', responseModel.data?.lastName ?? '');
    sp.setString('phone_number', responseModel.data?.contactNumber.toString() ?? '');
    sp.setString('email', responseModel.data?.email ?? '');
    sp.setString('logo_url', responseModel.data?.profileImage ?? '');
    await saveLocalInfoOnUpdate(responseModel);
    return true ;
  }

  Future<void> saveLocalInfo(LoginModel responseModel) async{
    profileLogo.value = responseModel.data?.profileImage ?? '';
    profileUserName.value = responseModel.data?.fullName ?? '';
    profileUserEmail.value = responseModel.data?.email ?? '';
    userFirstName.value = responseModel.data?.firstName ?? '';
    userLastName.value = responseModel.data?.lastName ?? '';
    userPhoneNumber.value = responseModel.data?.contactNumber ?? '';
  }

  Future<void> saveLocalInfoOnUpdate(UpdateProfileModel responseModel) async{
    profileLogo.value = responseModel.data?.profileImage ?? '';
    profileUserName.value = responseModel.data?.name ?? '';
    profileUserEmail.value = responseModel.data?.email ?? '';
    userFirstName.value = responseModel.data?.firstName ?? '';
    userLastName.value = responseModel.data?.lastName ?? '';
    userPhoneNumber.value = responseModel.data?.contactNumber.toString() ?? '';
  }

  Future<void> getUserInfo() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    profileLogo.value = sp.getString('logo_url') ?? '';
    profileUserName.value = sp.getString('name') ?? '';
    profileUserEmail.value = sp.getString('email') ?? '';
    userFirstName.value = sp.getString('first_name') ?? '';
    userLastName.value = sp.getString('last_name') ?? '';
    userPhoneNumber.value = sp.getString('phone_number') ?? '';
  }

    Future<bool> logout() async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setBool('isLogin', false);
      return true ;
    }

    Future<bool> updateCurrentAccountStatus(int status)async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setInt('current_account_status', status);
      return true ;
    }

    Future<bool> saveOwnerName(String logoUrl)async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('owner_name', logoUrl);
      return true ;
    }

    Future<bool> changeFirstTimeLoginStatus(int status)async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setInt('first_time_login', status);
      return true ;
    }

    Future<String?> getOwnerName() async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString('owner_name');
      return token;
    }

    Future<int?> getUserId() async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      int? id = sp.getInt('id');
      return id;
    }

  Future<int?> getUserFirstTimeLogin() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    int? id = sp.getInt('first_time_login');
    return id;
  }

    Future<bool> saveLogo(String logoUrl)async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('logo_url', logoUrl);
      profileLogo.value = logoUrl;
      return true ;
    }

    Future<int?> getCurrentAccountStatus() async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      int? token = sp.getInt('current_account_status') ?? 0;
      return token;
    }

    Future<String?> getUserToken() async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString('token');
      return token;
    }

    Future<String?> getLogo() async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? logoUrl = sp.getString('logo_url');
      profileLogo.value = logoUrl ?? '';
      return logoUrl;
    }

    Future<String?> getRole() async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString('roleMap');
      return token;
    }

    
    Future<String?> getUserEmail() async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString('email');
      return token;
    }

    
    Future<String?> getUserName() async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString('name');
      return token;
    }

    Future<String?> getPhoneNumber() async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString('name');
      return token;
    }

    Future<bool?> getUserIsLogin()async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      bool? isLogin = sp.getBool('isLogin');
      return isLogin;
    }

    Future<bool> removeUser()async{
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.clear();
      return true ;
    }
}