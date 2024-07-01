
import 'package:cold_storage_flutter/res/routes/routes.dart';
import 'package:cold_storage_flutter/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


Future<void> main() async { 
  await dotenv.load();
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE'] ?? '';
  await Stripe.instance.applySettings();
   configLoading();
  runApp(const MyApp()); 
 
} 

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
  
class MyApp extends StatelessWidget { 
  const MyApp({super.key}); 
  @override 
  Widget build(BuildContext context) { 
    return GetMaterialApp(
      locale: const Locale('en' ,'US'),
      fallbackLocale: const Locale('en' ,'US'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: AppRoutes.appRoutes(),
      builder: EasyLoading.init(),
    );
  } 
} 
