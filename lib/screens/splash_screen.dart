import 'package:cold_storage_flutter/view_models/services/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../view_models/services/app_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

   SplashServices splashScreen = SplashServices();

 @override
  void initState() {
    super.initState();
    splashScreen.isLogin();

  }

  @override
  Widget build(BuildContext context) {
    App.initGlobalResources(context);

    return Scaffold(
      body: Center(
        child: logo(160, 160),
      ),
    );
  }

  Widget logo(double height_, double width_) {
    return Image.asset(
              'assets/images/ic_logo_coldstorage.png',
              width: 600.0.h,
              height: 240.0.h,
              fit: BoxFit.fill,
            );
  }

}