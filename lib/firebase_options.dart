// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB8Tpx_RflhYChtwHCgfGeoKk--A4Gusxc',
    appId: '1:448276089440:web:4cf9bbcb825c17cdc1d105',
    messagingSenderId: '448276089440',
    projectId: 'agtech-70c59',
    authDomain: 'agtech-70c59.firebaseapp.com',
    storageBucket: 'agtech-70c59.appspot.com',
    measurementId: 'G-QRZKE5G2NF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDtv0I4HLQVX98yYZVtY4xLsVJofM_Nvlg',
    appId: '1:448276089440:android:8b8a066014d7c26bc1d105',
    messagingSenderId: '448276089440',
    projectId: 'agtech-70c59',
    storageBucket: 'agtech-70c59.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDUX5LdIu2raq0HZ5uqvcXqn_cwW33yKkU',
    appId: '1:448276089440:ios:65aa4c70ac21bad9c1d105',
    messagingSenderId: '448276089440',
    projectId: 'agtech-70c59',
    storageBucket: 'agtech-70c59.appspot.com',
    iosBundleId: 'com.appcoldstorage.coldstorage',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDUX5LdIu2raq0HZ5uqvcXqn_cwW33yKkU',
    appId: '1:448276089440:ios:942c5221485cc723c1d105',
    messagingSenderId: '448276089440',
    projectId: 'agtech-70c59',
    storageBucket: 'agtech-70c59.appspot.com',
    iosBundleId: 'com.example.coldStorageFlutter',
  );

}