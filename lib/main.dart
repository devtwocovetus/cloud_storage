
import 'package:cold_storage_flutter/firebase_options.dart';
import 'package:cold_storage_flutter/res/routes/routes.dart';
import 'package:cold_storage_flutter/screens/splash_screen.dart';
import 'package:cold_storage_flutter/view_models/services/notification/fcm_notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    final FCMNotificationService fcmSetting = FCMNotificationService.instance;
    fcmSetting.defaultNotificationHandler(message, 'onBackground');
  } catch (e) {
    debugPrint(e.toString());
  }
}

Future<void> main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } catch (e) {
    debugPrint(e.toString());
  }
  await dotenv.load();
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE'] ?? '';
    Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
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
    return ScreenUtilInit(
      designSize: const Size(412, 847),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_,child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('en' ,'US'),
          fallbackLocale: const Locale('en' ,'US'),
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            )
          ),
          themeMode: ThemeMode.light,
          getPages: AppRoutes.appRoutes(),
          builder: EasyLoading.init(),
        );
      },
    );
  } 
} 
