
import 'package:cold_storage_flutter/firebase_options.dart';
import 'package:cold_storage_flutter/i10n/strings.g.dart';
import 'package:cold_storage_flutter/res/components/dismiss_keyboard.dart';
import 'package:cold_storage_flutter/res/routes/routes.dart';
import 'package:cold_storage_flutter/view_models/controller/user_preference/user_prefrence_view_model.dart';
import 'package:cold_storage_flutter/view_models/services/notification/fcm_notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../i10n/strings.g.dart' as i18n;

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
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
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

  late String? appLocale;

  UserPreference userPreference = UserPreference();

  // Localization preference
  appLocale = await userPreference.getAppLang();
  if (appLocale == null || appLocale.isEmpty) {
    i18n.LocaleSettings.useDeviceLocale();
    appLocale = i18n.LocaleSettings.currentLocale.languageCode;
    userPreference.saveAppLang(appLocale);
  }

  appLocale.toString() != 'en' ? i18n.LocaleSettings.setLocale(i18n.AppLocale.es) : i18n.LocaleSettings.setLocale(i18n.AppLocale.en);
  // setAppLocale(appLocale);
   
  runApp(TranslationProvider(child: const MyApp()));
 
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
        return DismissKeyboard(
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            locale: TranslationProvider.of(context).flutterLocale,
            // fallbackLocale: const Locale('en' ,'US'),
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
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
          ),
        );
      },
    );
  } 
} 
