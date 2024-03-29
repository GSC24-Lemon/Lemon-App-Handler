// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyBx5PzMpAFV5rd2nBNOTGrdIjY5WuCRc5Y',
    appId: '1:491496864435:web:5c88897e384f537ee68ec6',
    messagingSenderId: '491496864435',
    projectId: 'lemon-df113',
    authDomain: 'lemon-df113.firebaseapp.com',
    storageBucket: 'lemon-df113.appspot.com',
    measurementId: 'G-9XJKRHNC9Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXWeFC9ic3KxigRmpYn0fQ8MFYYl5Zbok',
    appId: '1:491496864435:android:668db5262f3c500ee68ec6',
    messagingSenderId: '491496864435',
    projectId: 'lemon-df113',
    storageBucket: 'lemon-df113.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOW8QO-KD8FSptfnKrYFs2aftzy8MoR9E',
    appId: '1:491496864435:ios:67e43fd72de458e0e68ec6',
    messagingSenderId: '491496864435',
    projectId: 'lemon-df113',
    storageBucket: 'lemon-df113.appspot.com',
    iosBundleId: 'com.example.lemonAppHandlerNew',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCOW8QO-KD8FSptfnKrYFs2aftzy8MoR9E',
    appId: '1:491496864435:ios:2a0f619c96e15518e68ec6',
    messagingSenderId: '491496864435',
    projectId: 'lemon-df113',
    storageBucket: 'lemon-df113.appspot.com',
    iosBundleId: 'com.example.lemonAppHandlerNew.RunnerTests',
  );
}
