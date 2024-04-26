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
        return windows;
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
    apiKey: 'AIzaSyAmFUHRoTEdZrW8-9rhN3CBwU96p9ENPGY',
    appId: '1:922354865701:web:df46f30cbb661f22c091cc',
    messagingSenderId: '922354865701',
    projectId: 'otpchecker-33680',
    authDomain: 'otpchecker-33680.firebaseapp.com',
    storageBucket: 'otpchecker-33680.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4cXJ0-Tp-_OEH4RocEdNw3YQErazg0ok',
    appId: '1:922354865701:android:53f8eb3c6c60da70c091cc',
    messagingSenderId: '922354865701',
    projectId: 'otpchecker-33680',
    storageBucket: 'otpchecker-33680.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCf2VpWp1oPmC3Oax_kLaCtxzk0ZX9dZYg',
    appId: '1:922354865701:ios:f591f49e5b26b582c091cc',
    messagingSenderId: '922354865701',
    projectId: 'otpchecker-33680',
    storageBucket: 'otpchecker-33680.appspot.com',
    iosBundleId: 'com.example.otp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCf2VpWp1oPmC3Oax_kLaCtxzk0ZX9dZYg',
    appId: '1:922354865701:ios:f591f49e5b26b582c091cc',
    messagingSenderId: '922354865701',
    projectId: 'otpchecker-33680',
    storageBucket: 'otpchecker-33680.appspot.com',
    iosBundleId: 'com.example.otp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAmFUHRoTEdZrW8-9rhN3CBwU96p9ENPGY',
    appId: '1:922354865701:web:6f46f9adabdb5aecc091cc',
    messagingSenderId: '922354865701',
    projectId: 'otpchecker-33680',
    authDomain: 'otpchecker-33680.firebaseapp.com',
    storageBucket: 'otpchecker-33680.appspot.com',
  );

}