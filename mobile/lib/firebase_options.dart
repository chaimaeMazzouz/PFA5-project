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
    apiKey: 'AIzaSyDncydkCpmgfdzNIETP_35QGw3SJ5c95B4',
    appId: '1:738305311799:web:cdc5e2b3c122544ca6abb2',
    messagingSenderId: '738305311799',
    projectId: 'gestion-de-reservation-fb64e',
    authDomain: 'gestion-de-reservation-fb64e.firebaseapp.com',
    storageBucket: 'gestion-de-reservation-fb64e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqYD5b4MHBNjnZYl7d_97l-hu485W6L24',
    appId: '1:738305311799:android:a57b59411e2d3524a6abb2',
    messagingSenderId: '738305311799',
    projectId: 'gestion-de-reservation-fb64e',
    storageBucket: 'gestion-de-reservation-fb64e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIJLUSN_eAWnYOlH6jmT65gPsgUNxhk3k',
    appId: '1:738305311799:ios:8bad09d03e8c59a3a6abb2',
    messagingSenderId: '738305311799',
    projectId: 'gestion-de-reservation-fb64e',
    storageBucket: 'gestion-de-reservation-fb64e.appspot.com',
    iosBundleId: 'com.example.mobile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDIJLUSN_eAWnYOlH6jmT65gPsgUNxhk3k',
    appId: '1:738305311799:ios:d3c78066e3d736cba6abb2',
    messagingSenderId: '738305311799',
    projectId: 'gestion-de-reservation-fb64e',
    storageBucket: 'gestion-de-reservation-fb64e.appspot.com',
    iosBundleId: 'com.example.mobile.RunnerTests',
  );
}